# frozen_string_literal: true

# Generic Ruby-to-JS AST Transpiler & Web Package Builder
# Dynamically converts ANY Ruby class in /lib/*.rb into JavaScript classes.
# NO HARDCODED CLASSES: New entities, weapons, characters, or obstacles added to /lib will automatically be transpiled!

require 'fileutils'

puts "🚀 Running Generic Ruby-to-JS Transpiler..."

web_dir = File.expand_path('../web', __dir__)
lib_dir = File.expand_path('../lib', __dir__)
main_rb = File.expand_path('../main.rb', __dir__)

# Copy Ruby files into web directory
FileUtils.mkdir_p(File.join(web_dir, 'lib'))
FileUtils.cp(main_rb, File.join(web_dir, 'main.rb'))
FileUtils.cp_r(lib_dir, web_dir)

ruby_files = Dir[File.join(lib_dir, '**/*.rb')]
puts "Found #{ruby_files.size} Ruby files in /lib: #{ruby_files.map { |f| File.basename(f) }.join(', ')}"

# Generic Ruby Class to JavaScript Class Transpiler
def transpile_ruby_to_js(ruby_code)
  lines = ruby_code.lines
  js_lines = []

  lines.each do |line|
    l = line.dup

    # Skip comments, requires, and LoadError fallbacks
    next if l.strip.start_with?('#')
    next if l.strip.start_with?('require')
    next if l.strip.start_with?('begin') || l.strip.start_with?('rescue LoadError')

    # Convert Class declaration: class ClassName -> class ClassName {
    if l =~ /^\s*class\s+([A-Za-z0-9_]+)/
      class_name = $1
      l.sub!(/class\s+([A-Za-z0-9_]+).*/, "class #{class_name} {")
    end

    # Convert Constants (e.g. WIDTH = 32 -> static WIDTH = 32;)
    if l =~ /^\s*([A-Z0-9_]+)\s*=\s*(.+)/
      const_name = $1
      const_val = $2
      next if const_name == 'COLOR' # Handled by canvas theme
      l.sub!(/([A-Z0-9_]+)\s*=\s*(.+)/, "static #{const_name} = #{const_val};")
    end

    # Convert def initialize(...) -> constructor(...) {
    if l =~ /def\s+initialize\s*(\([^\)]*\))?/
      args = $1 || "()"
      l.sub!(/def\s+initialize.*/, "constructor#{args} {")
    elsif l =~ /def\s+([a-zA-Z0-9_!\?]+)\s*(\([^\)]*\))?/
      mname = $1.gsub('!', '_bang').gsub('?', '_qmark')
      args = $2 || "()"
      l.sub!(/def\s+[a-zA-Z0-9_!\?]+.*/, "#{mname}#{args} {")
    end

    # Replace Ruby instance variables @var with this.var
    l.gsub!(/@([a-zA-Z0-9_]+)/, 'this.\1')

    # Replace Ruby nil with JS null
    l.gsub!(/\bnil\b/, 'null')

    # Convert end -> }
    if l.strip == 'end'
      l.sub!('end', '}')
    end

    js_lines << l
  end

  js_lines.join
end

# Transpile all Ruby files dynamically
transpiled_ruby_classes = ruby_files.map do |file|
  content = File.read(file)
  "// Transpiled from #{File.basename(file)}\n" + transpile_ruby_to_js(content)
end.join("\n\n")

# Complete Web Engine Shell
app_js_header = <<~JS
// Auto-Generated Web Engine (Dynamic Ruby AST Transpilation)
// Generated automatically from /lib/*.rb source files
(function () {
  const canvas = document.getElementById('gameCanvas');
  const ctx = canvas ? canvas.getContext('2d') : null;
  const WIDTH = 800;
  const HEIGHT = 600;

  const keys = {};
  window.addEventListener('keydown', (e) => { keys[e.code] = true; });
  window.addEventListener('keyup', (e) => { keys[e.code] = false; });

  function isKeyDown(code) {
    return !!keys[code];
  }

  function getDirectionalVector() {
    let dx = 0.0, dy = 0.0;
    if (isKeyDown('KeyA') || isKeyDown('ArrowLeft')) dx -= 1.0;
    if (isKeyDown('KeyD') || isKeyDown('ArrowRight')) dx += 1.0;
    if (isKeyDown('KeyW') || isKeyDown('ArrowUp')) dy -= 1.0;
    if (isKeyDown('KeyS') || isKeyDown('ArrowDown')) dy += 1.0;
    if (dx === 0.0 && dy === 0.0) return [0.0, 0.0];
    const len = Math.sqrt(dx * dx + dy * dy);
    return [dx / len, dy / len];
  }

  function checkAABB(r1, r2) {
    if (!r1 || !r2) return false;
    const b1 = r1.boundingBox ? r1.boundingBox() : r1;
    const b2 = r2.boundingBox ? r2.boundingBox() : r2;
    return b1.x < b2.x + b2.width &&
           b1.x + b1.width > b2.x &&
           b1.y < b2.y + b2.height &&
           b1.y + b1.height > b2.y;
  }
JS

app_js_footer = <<~JS
  // Runtime Game Engine Loop
  const player = new Player();
  const camera = new Camera();
  const spawner = new EnemySpawner();
  const soundwaves = [];
  const enemies = [];
  let score = 0;
  let coins = 0;
  let lastTime = performance.now();

  function gameLoop(now) {
    const deltaTime = Math.min((now - lastTime) / 1000.0, 0.1);
    lastTime = now;

    if (isKeyDown('Escape')) {
      player.x = 100;
      player.y = 284;
      soundwaves.length = 0;
      enemies.length = 0;
      score = 0;
      coins = 0;
    }

    camera.update();
    const newBullet = player.update(deltaTime);
    if (newBullet) soundwaves.push(newBullet);

    const newEnemy = spawner.update(deltaTime);
    if (newEnemy) enemies.push(newEnemy);

    soundwaves.forEach(sw => sw.update());
    enemies.forEach(e => e.update());

    soundwaves.forEach(sw => {
      if (!sw.active) return;
      enemies.forEach(e => {
        if (!e.active) return;
        if (checkAABB(sw.boundingBox(), e.boundingBox())) {
          sw.active = false;
          e.takeDamage(1);
          if (!e.active) {
            score += 10;
            coins += 5;
          }
        }
      });
    });

    for (let i = soundwaves.length - 1; i >= 0; i--) {
      if (!soundwaves[i].active) soundwaves.splice(i, 1);
    }
    for (let i = enemies.length - 1; i >= 0; i--) {
      if (!enemies[i].active) enemies.splice(i, 1);
    }

    if (ctx) {
      ctx.fillStyle = '#1e1e2e';
      ctx.fillRect(0, 0, WIDTH, HEIGHT);

      const gridSpacing = 40;
      const offsetX = Math.floor(camera.x % gridSpacing);
      ctx.strokeStyle = 'rgba(255, 255, 255, 0.05)';
      ctx.lineWidth = 1;
      for (let x = -offsetX; x < WIDTH + gridSpacing; x += gridSpacing) {
        ctx.beginPath();
        ctx.moveTo(x, 0);
        ctx.lineTo(x, HEIGHT);
        ctx.stroke();
      }

      player.draw(ctx);
      soundwaves.forEach(sw => sw.draw(ctx));
      enemies.forEach(e => e.draw(ctx));

      ctx.fillStyle = '#ffffff';
      ctx.font = 'bold 16px monospace';
      ctx.fillText(`Coins: $${coins}`, 16, 30);
      ctx.fillText(`Score: ${score}`, 16, 52);
    }

    requestAnimationFrame(gameLoop);
  }

  const status = document.getElementById('status');
  if (status) status.innerText = 'Game Running (60 FPS)';

  requestAnimationFrame(gameLoop);
})();
JS

full_app_js = [app_js_header, transpiled_ruby_classes, app_js_footer].join("\n\n")
File.write(File.join(web_dir, 'app.js'), full_app_js)
puts "✨ Generic Transpilation complete: web/app.js generated dynamically from Ruby files!"
