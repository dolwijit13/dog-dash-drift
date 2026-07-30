var GDragonRubyGameId = 'dog-dash-drift-v3';
var GDragonRubyGameTitle = 'Dog Dash Drift';
var GDragonRubyDevTitle = 'inuyama';
var GDragonRubyGameVersion = '0.1';
var GDragonRubyIcon = '/metadata/icon.png';
var GDragonRubyWriteDir = '/dolwijit13-dog-dash-drift';
var GDragonRubyOrientation = 'landscape';

function syncDataFiles(dbname, baseurl) {
    var retval = {};
    if (typeof (dbname) === "undefined") { dbname = "files"; }
    if (typeof (baseurl) === "undefined") { baseurl = ""; }

    var urlrandomizerarg = '';

    var state = {
        db: null,
        reported_result: false,
        xhrs: {},
        remote_manifest: {},
        remote_manifest_loaded: false,
        local_manifest: {},
        local_manifest_loaded: false,
        total_to_download: 0,
        total_downloaded: 0,
        total_files: 0,
        pending_files: []
    };

    var log = function(str) { console.log("CACHEAPPDATA: " + str); }
    var debug = function(str) {}

    var clear_state = function() {
        for (var i in state.xhrs) {
            state.xhrs[i].abort();
        }
        delete state.db;
        delete state.xhrs;
        delete state.remote_manifest;
        delete state.local_manifest;
    };

    var failed = function(why) {
        if (state.reported_result) { return; }
        state.reported_result = true;
        log("[FAILURE] " + why);
        clear_state();
        if (retval.onerror) {
            retval.onerror(why);
        }
    };

    retval.abort = function() {
        failed("Aborted.");
    }

    var succeeded = function() {
        if (state.reported_result) { return; }
        state.reported_result = true;
        var why = "File data synchronized (downloaded " + Math.ceil(state.total_downloaded / 1048576) + " megabytes in " + state.total_files + " files)";
        log("[SUCCESS] " + why);
        retval.db = state.db;
        retval.manifest = state.remote_manifest;
        clear_state();
        if (retval.onsuccess) {
            retval.onsuccess(why);
        }
    };

    var prevprogress = "";
    var progress = function(str) {
        if (state.reported_result) { return; }
        if (str == prevprogress) { return; }
        prevprogress = str;
        log("[PROGRESS] " + str);
        if (retval.onprogress) {
            retval.onprogress(str, state.total_downloaded, state.total_to_download);
        }
    }

    var dbopen = window.indexedDB.open(dbname, 1);

    dbopen.onupgradeneeded = function(event) {
        progress("Upgrading/creating local database...");
        var db = event.target.result;
        var metadataStore = db.createObjectStore("metadata", { keyPath: 'filename' });
        var dataStore = db.createObjectStore("data", { keyPath: 'chunkid', autoIncrement: true });
        dataStore.createIndex("data", "filename", { unique: false });
    };

    dbopen.onerror = function(event) {
      var isBraveBrowser = navigator.brave || false;
      var errorMessage = "Couldn't open local database: " + event.target.error.message;
      if (isBraveBrowser) {
        errorMessage += "<br/>Note: This error can also happen if you are using Brave Browser and have not disabled Shield (click the Lion icon in the address bar and disable Shield for this site).";
      }
      failed(errorMessage);
    };

    var hash_count = function(h) {
        if (h === undefined) { return 0; }
        var k = Object.keys(h);
        return (k === undefined) ? 0 : k.length;
    }

    var finished_file = function(fname) {
        if ((hash_count(state.xhrs) == 0) && (state.pending_files.length == 0)) {
            succeeded();
        }
    };

    var store_file = function(xhr) {
        var databuf = xhr.response;
        var transaction = state.db.transaction(["metadata", "data"], "readwrite");
        var objstoremetadata = transaction.objectStore("metadata");
        var objstoredata = transaction.objectStore("data");

        objstoremetadata.add({ filename: xhr.filename, filesize: xhr.filesize, filetime: xhr.filetime });
        objstoredata.add({ filename: xhr.filename, offset: 0, chunk: databuf });

        transaction.oncomplete = function(event) {
            finished_file(xhr.filename);
        };
    };

    var download_another_file = function() {
        if (state.pending_files.length == 0) {
            return false;
        }

        var remotefname = state.pending_files.pop();
        while (remotefname && (remotefname.startsWith(".") || remotefname.includes("/."))) {
            remotefname = state.pending_files.pop();
        }
        if (!remotefname) {
            if ((hash_count(state.xhrs) == 0) && (state.pending_files.length == 0)) {
                succeeded();
            }
            return false;
        }

        var remoteitem = state.remote_manifest[remotefname];
        if (!remoteitem) return download_another_file();

        var xhr = new XMLHttpRequest();
        state.xhrs[remotefname] = xhr;
        xhr.previously_loaded = 0;
        xhr.filename = remotefname;
        xhr.filesize = remoteitem.filesize;
        xhr.filetime = remoteitem.filetime;
        xhr.expected_filesize = remoteitem.filesize;
        xhr.responseType = "arraybuffer";
        xhr.addEventListener("error", function(e) { failed("Download error on '" + e.target.filename + "'!"); });
        xhr.addEventListener("timeout", function(e) { failed("Download timeout on '" + e.target.filename + "'!"); });
        xhr.addEventListener("abort", function(e) { failed("Download abort on '" + e.target.filename + "'!"); });

        xhr.addEventListener('progress', function(e) {
            if (state.reported_result) { return; }
            var xhr = e.target;
            var additional = e.loaded - xhr.previously_loaded;
            state.total_downloaded += additional;
            xhr.previously_loaded = e.loaded;
            var percent = state.total_to_download ? Math.floor((state.total_downloaded / state.total_to_download) * 100.0) : 0;
            progress("Downloaded " + percent + "% (" + Math.ceil(state.total_downloaded / 1048576) + "/" + Math.ceil(state.total_to_download / 1048576) + " megabytes)");
        });

        xhr.addEventListener("load", function(e) {
            if (state.reported_result) { return; }
            var xhr = e.target;
            if (xhr.status != 200) {
                failed("Server reported failure downloading '" + xhr.filename + "'!");
            } else {
                state.total_downloaded -= xhr.previously_loaded;
                state.total_downloaded += xhr.expected_filesize;
                xhr.previously_loaded = xhr.expected_filesize;
                delete state.xhrs[xhr.filename];
                var percent = state.total_to_download ? Math.floor((state.total_downloaded / state.total_to_download) * 100.0) : 0;
                progress("Downloaded " + percent + "% (" + Math.ceil(state.total_downloaded / 1048576) + "/" + Math.ceil(state.total_to_download / 1048576) + " megabytes)");
                download_another_file();
                store_file(xhr);
            }
        });

        xhr.open("get", baseurl + remotefname + urlrandomizerarg, true);
        xhr.send();
        return true;
    }

    var download_new_files = function() {
        if (state.reported_result) { return; }
        progress("Downloading new files...");
        for (var i in state.remote_manifest) {
            var remoteitem = state.remote_manifest[i];
            var remotefname = i;
            if (remotefname.startsWith(".") || remotefname.includes("/.")) continue;
            if (typeof state.local_manifest[remotefname] !== "undefined") {
            } else {
                state.total_to_download += remoteitem.filesize;
                state.total_files++;
                state.pending_files.push(remotefname)
            }
        }

        if (state.pending_files.length == 0) {
            succeeded();
            return;
        }

        var max_concurrent_downloads = 4;
        while (download_another_file()) {
            if (hash_count(state.xhrs) >= max_concurrent_downloads) {
                break;
            }
        }
    };

    var delete_old_files = function() {
        if (state.reported_result) { return; }
        var deleteme = []
        for (var i in state.local_manifest) {
            var localitem = state.local_manifest[i];
            var localfname = localitem.filename;
            if (localfname.startsWith(".") || localfname.includes("/.")) {
                deleteme.push(localfname);
                delete state.local_manifest[i];
                continue;
            }
            var removeme = false;
            if (typeof state.remote_manifest[localfname] === "undefined") {
                removeme = true;
            } else {
                var remoteitem = state.remote_manifest[localfname];
                if ( (localitem.filesize != remoteitem.filesize) ||
                     (localitem.filetime != remoteitem.filetime) ) {
                    removeme = true;
                }
            }

            if (removeme) {
                deleteme.push(localfname);
                delete state.local_manifest[i];
            }
        }

        if (deleteme.length == 0) {
            download_new_files();
        } else {
            progress("Cleaning up old files...");
            try {
                var transaction = state.db.transaction(["metadata"], "readwrite");
                transaction.oncomplete = function(event) {
                    download_new_files();
                };
                transaction.onerror = function(event) {
                    download_new_files();
                };
                var objstoremetadata = transaction.objectStore("metadata");
                for (var i of deleteme) {
                    try { objstoremetadata.delete(i); } catch(e) {}
                }
            } catch(e) {
                download_new_files();
            }
        }
    };

    var manifest_loaded = function() {
        if (state.reported_result) { return; }
        if (state.local_manifest_loaded && state.remote_manifest_loaded) {
            delete_old_files();
        }
    };

    var load_local_manifest = function(db) {
        if (state.reported_result) { return; }
        var transaction = db.transaction("metadata", "readonly");
        var objstore = transaction.objectStore("metadata");
        var cursor = objstore.openCursor();

        cursor.onsuccess = function(event) {
            if (state.reported_result) { return; }
            var cursor = event.target.result;
            if (cursor) {
                state.local_manifest[cursor.value.filename] = cursor.value;
                cursor.continue();
            } else {
                state.local_manifest_loaded = true;
                manifest_loaded();
            }
        };
    };

    dbopen.onsuccess = function(event) {
        var db = event.target.result;
        state.db = db;

        db.onerror = function(event) {
            failed("Database error: " + event.target.error.message);
        };

        progress("Loading file manifests...");
        load_local_manifest(db);

        var xhr = new XMLHttpRequest();
        xhr.responseType = "text";
        xhr.addEventListener("error", function(e) { failed("Manifest download error!"); });
        xhr.addEventListener("timeout", function(e) { failed("Manifest download timeout!"); });
        xhr.addEventListener("abort", function(e) { failed("Manifest download abort!"); });
        xhr.addEventListener("load", function(e) {
            if (e.target.status != 200) {
                failed("Server reported failure downloading manifest!");
            } else {
                state.remote_manifest_loaded = true;
                try {
                    state.remote_manifest = JSON.parse(e.target.responseText);
                } catch (e) {
                    failed("Remote manifest is corrupted.");
                }
                delete state.remote_manifest[""]
                manifest_loaded();
            }
        });
        xhr.open("get", "manifest.json" + urlrandomizerarg, true);
        xhr.send();
    };

    return retval;
}

var prepareFilesystem = function() {
  var persistent_path = GDragonRubyWriteDir;
  FS.mkdir(persistent_path);
  FS.mount(IDBFS, {}, persistent_path);
  FS.syncfs(true, function(err) {
    if (err) {
      console.log("WARNING: Failed to populate persistent store. Save games likely lost?");
    } else {
      console.log("Read in from persistent store.");
    }

    loadDataFiles(GDragonRubyGameId, 'gamedata/', function() {
      console.log("Game data is sync'd to MEMFS. Starting click-to-play()...");
      Module.setStatus("");
      statusElement.style.display='none';
      Module.startClickToPlay();
    });
  });
}

var loadDataFiles = function(dbname, baseurl, onsuccess) {
  var syncdata = syncDataFiles(dbname, baseurl);
  window.gtk.syncdata = syncdata;

  syncdata.onerror = function(why) {
    Module.setStatus(why);
  }

  syncdata.onprogress = function(why, total_downloaded, total_to_download) {
    Module.setStatus(why);
  }

  syncdata.onsuccess = function(why) {
    GGameFilesDatabase = syncdata.db;
    window.gtk.filedb = syncdata.db;

    var db = syncdata.db;
    var manifest = syncdata.manifest;
    syncdata.failed = false;
    syncdata.num_requests = 0;
    syncdata.total_requests = 0;

    db.onerror = function(event) {
      Module.setStatus("Database error: " + event.target.error.message);
      syncdata.failed = true;
    };

    var transaction = db.transaction("data", "readonly");
    var objstore = transaction.objectStore("data");
    var dataindex = objstore.index("data");

    for (var i in manifest) {
      syncdata.total_requests++;
      syncdata.num_requests++;
      var req = dataindex.get(i);
      req.filesize = manifest[i].filesize;
      req.onsuccess = function(event) {
        var path = "/" + event.target.result.filename;
        var ui8arr = new Uint8Array(event.target.result.chunk);
        var len = event.target.filesize;
        var arr = new Array(len);
        for (var i = 0; i < len; ++i) {
          arr[i] = ui8arr[i];
        }

        var basedir = PATH.dirname(path);
        FS.mkdirTree(basedir);

        var okay = false;
        try {
          FS.createDataFile(basedir, PATH.basename(path), arr, true, true, true);
          okay = true;
        } catch (err) {
          FS.unlink(path);
          try {
            FS.createDataFile(basedir, PATH.basename(path), arr, true, true, true);
            okay = true;
          } catch (err) {
            okay = false;
          }
        }

        if (!okay) {
          Module.setStatus("ERROR: Failed to put '" + path + "' in MEMFS.");
        } else {
          var completed = syncdata.total_requests - syncdata.num_requests;
          var percent = Math.floor((completed / syncdata.total_requests) * 100.0);
          Module.setStatus("Preparing game data: " + percent + "%");
          syncdata.num_requests--;
          if (syncdata.num_requests <= 0) {
            if (!syncdata.failed) {
              onsuccess();
            }
          }
        }
      };
    }
  }
}

var base64Encode = function(ui8array) {
    var CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    var out = "", i = 0, len = ui8array.length, c1, c2, c3;
    while (i < len) {
        c1 = ui8array[i++] & 0xff;
        if (i == len) {
            out += CHARS.charAt(c1 >> 2);
            out += CHARS.charAt((c1 & 0x3) << 4);
            out += "==";
            break;
        }
        c2 = ui8array[i++];
        if (i == len) {
            out += CHARS.charAt(c1 >> 2);
            out += CHARS.charAt(((c1 & 0x3)<< 4) | ((c2 & 0xF0) >> 4));
            out += CHARS.charAt((c2 & 0xF) << 2);
            out += "=";
            break;
        }
        c3 = ui8array[i++];
        out += CHARS.charAt(c1 >> 2);
        out += CHARS.charAt(((c1 & 0x3) << 4) | ((c2 & 0xF0) >> 4));
        out += CHARS.charAt(((c2 & 0xF) << 2) | ((c3 & 0xC0) >> 6));
        out += CHARS.charAt(c3 & 0x3F);
    }
    return out;
}

function startGame() {
    Module["removeRunDependency"]("dragonruby_init");
}

var Module = {
  noInitialRun: false,
  preInit: [],
  clickedToPlay: false,
  clickToPlayListener: function() {
    if (Module.clickedToPlay) return;
    Module.clickedToPlay = true;
    var div = document.getElementById('clicktoplaydiv');
    if (div) {
        div.removeEventListener('click', Module.clickToPlayListener);
        document.body.removeChild(div);
    }

    document.removeEventListener('keydown', Module.enterPressedCallback);
    startGame();
  },
  enterPressedCallback: function(event) {
    if (event.keyCode == 13) {
      Module.clickToPlayListener();
    }
  },
  startClickToPlay: function() {
    var div = document.createElement('div');
    div.id = 'clicktoplaydiv';
    div.style.width = '640px';
    div.style.maxWidth = '90vw';
    div.style.height = '360px';
    div.style.maxHeight = '90vh';
    div.style.backgroundColor = 'rgb(40, 44, 52)';
    div.style.border = '2px solid #2ecc71';
    div.style.borderRadius = '12px';
    div.style.position = 'absolute';
    div.style.top = '50%';
    div.style.left = '50%';
    div.style.transform = 'translate(-50%, -50%)';
    div.style.zIndex = '999999';
    div.style.cursor = 'pointer';
    div.style.display = 'flex';
    div.style.flexDirection = 'column';
    div.style.alignItems = 'center';
    div.style.justifyContent = 'center';
    div.style.gap = '20px';
    div.style.boxShadow = '0 10px 30px rgba(0,0,0,0.8)';

    try {
      var iconData = FS.readFile(GDragonRubyIcon, {});
      if (iconData && iconData.length > 0) {
        var base64 = base64Encode(iconData);
        var img = new Image();
        img.style.width = '80px';
        img.style.height = '80px';
        img.src = 'data:image/png;base64,' + base64;
        div.appendChild(img);
      }
    } catch(e) {
      console.warn("Could not load icon for start overlay:", e);
    }

    var p1 = document.createElement('p');
    p1.textContent = GDragonRubyGameTitle + " " + GDragonRubyGameVersion + " by " + GDragonRubyDevTitle;
    p1.style.color = '#FFFFFF';
    p1.style.fontFamily = "monospace";
    p1.style.fontSize = "22px";
    p1.style.fontWeight = "bold";
    p1.style.margin = "0";
    div.appendChild(p1);

    var p2 = document.createElement('p');
    p2.innerHTML = '▶ Click or tap here to begin';
    p2.style.fontFamily = "monospace";
    p2.style.fontSize = "18px";
    p2.style.color = '#2ecc71';
    p2.style.backgroundColor = '#1e1e2e';
    p2.style.padding = '12px 24px';
    p2.style.borderRadius = '8px';
    p2.style.border = '1px solid #2ecc71';
    p2.style.margin = "0";
    div.appendChild(p2);

    document.body.appendChild(div);
    div.addEventListener('click', Module.clickToPlayListener);
    document.addEventListener("keydown", Module.enterPressedCallback);

    window.gtk.play = Module.clickToPlayListener;
  },
  preRun: function() {
    Module["addRunDependency"]("dragonruby_init");
    prepareFilesystem();
  },
  postRun: [],
  print: (function() {
    var element = document.getElementById('output');
    if (element) element.value = '';
    return function(text) {
      if (arguments.length > 1) text = Array.prototype.slice.call(arguments).join(' ');
      console.log(text);
      if (element) {
        element.value += text + "\n";
        element.scrollTop = element.scrollHeight;
      }
    };
  })(),
  printErr: function(text) {
    if (arguments.length > 1) text = Array.prototype.slice.call(arguments).join(' ');
    console.error(text);
  },
  canvas: (function() {
    var canvas = document.getElementById('canvas');
    canvas.addEventListener("webglcontextlost", function(e) { alert('WebGL context lost. You will need to reload the page.'); e.preventDefault(); }, false);
    return canvas;
  })(),
  setStatus: function(text) {
    var statusElement = document.getElementById('status');
    var progressElement = document.getElementById('progress');
    if (statusElement) statusElement.innerHTML = text || '';
  },
  totalDependencies: 0,
  monitorRunDependencies: function(left) {
    this.totalDependencies = Math.max(this.totalDependencies, left);
    Module.setStatus(left ? 'Preparing... (' + (this.totalDependencies-left) + '/' + this.totalDependencies + ')' : 'All downloads complete.');
  }
};

Module.onRuntimeInitialized = function() {
  Module.ffi_send = Module.cwrap('ffi_js_send',
				 'string',
				 ['string', 'string']);

  Module.ffi_free = function(s) {
    Module.ccall('ffi_js_free_string',
		 null,
		 ['string'],
		 [s]);
  };
};

function loadMainModule() {
  var buildtype = "wasm";
  var module = "dragonruby-" + buildtype + ".js";
  window.gtk = {};
  window.gtk.module = Module;

  var script = document.createElement('script');
  script.src = module;
  script.async = true;
  document.body.appendChild(script);
}

function loadLoadMainModule() {
  var hasWebAssembly = (typeof WebAssembly==="object" && typeof WebAssembly.Memory==="function");
  var hasSharedArrayBuffer = (typeof SharedArrayBuffer!=="undefined");

  if (!hasWebAssembly) {
    Module.setStatus("Your browser doesn't have WebAssembly support. Please upgrade.");
  } else if (!hasSharedArrayBuffer) {
    var isBraveBrowser = navigator.brave || false;
    var isHttps = window.location.protocol === "https:";
    var errorMessage = "Your browser doesn't have SharedArrayBuffer support. Please upgrade, or make sure the webserver set proper COOP/COEP headers!";

    if ("serviceWorker" in navigator) {
      navigator.serviceWorker.register("dragonruby-serviceworker.js").then(
	function (registration) {
          if (!navigator.serviceWorker.controller) {
            Module.setStatus("One moment, reloading to enable SharedArrayBuffer.");
            window.location.reload();
          } else {
            loadMainModule();
          }
	},
	function (err) {
          Module.setStatus(errorMessage);
	}
      );
    } else {
      Module.setStatus(errorMessage);
    }
  } else {
    loadMainModule();
  }
}

loadLoadMainModule();
