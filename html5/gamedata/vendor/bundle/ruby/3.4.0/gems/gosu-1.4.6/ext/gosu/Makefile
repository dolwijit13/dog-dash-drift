
SHELL = /bin/sh

# V=0 quiet, V=1 verbose.  other values don't work.
V = 0
V0 = $(V:0=)
Q1 = $(V:1=)
Q = $(Q1:0=@)
ECHO1 = $(V:1=@ :)
ECHO = $(ECHO1:0=@ echo)
NULLCMD = :

#### Start of system configuration section. ####

srcdir = ../../src
topdir = /Users/bumpdolwijit/.rbenv/versions/3.4.9/include/ruby-3.4.0
hdrdir = $(topdir)
arch_hdrdir = /Users/bumpdolwijit/.rbenv/versions/3.4.9/include/ruby-3.4.0/arm64-darwin25
PATH_SEPARATOR = :
VPATH = $(srcdir):$(arch_hdrdir)/ruby:$(hdrdir)/ruby
prefix = $(DESTDIR)/Users/bumpdolwijit/.rbenv/versions/3.4.9
rubysitearchprefix = $(rubylibprefix)/$(sitearch)
rubyarchprefix = $(rubylibprefix)/$(arch)
rubylibprefix = $(libdir)/$(RUBY_BASE_NAME)
exec_prefix = $(prefix)
vendorarchhdrdir = $(vendorhdrdir)/$(sitearch)
sitearchhdrdir = $(sitehdrdir)/$(sitearch)
rubyarchhdrdir = $(rubyhdrdir)/$(arch)
vendorhdrdir = $(rubyhdrdir)/vendor_ruby
sitehdrdir = $(rubyhdrdir)/site_ruby
rubyhdrdir = $(includedir)/$(RUBY_VERSION_NAME)
vendorarchdir = $(vendorlibdir)/$(sitearch)
vendorlibdir = $(vendordir)/$(ruby_version)
vendordir = $(rubylibprefix)/vendor_ruby
sitearchdir = $(sitelibdir)/$(sitearch)
sitelibdir = $(sitedir)/$(ruby_version)
sitedir = $(rubylibprefix)/site_ruby
rubyarchdir = $(rubylibdir)/$(arch)
rubylibdir = $(rubylibprefix)/$(ruby_version)
sitearchincludedir = $(includedir)/$(sitearch)
archincludedir = $(includedir)/$(arch)
sitearchlibdir = $(libdir)/$(sitearch)
archlibdir = $(libdir)/$(arch)
ridir = $(datarootdir)/$(RI_BASE_NAME)
modular_gc_dir = $(DESTDIR)
mandir = $(datarootdir)/man
localedir = $(datarootdir)/locale
libdir = $(exec_prefix)/lib
psdir = $(docdir)
pdfdir = $(docdir)
dvidir = $(docdir)
htmldir = $(docdir)
infodir = $(datarootdir)/info
docdir = $(datarootdir)/doc/$(PACKAGE)
oldincludedir = $(DESTDIR)/usr/include
includedir = $(SDKROOT)$(prefix)/include
runstatedir = $(localstatedir)/run
localstatedir = $(prefix)/var
sharedstatedir = $(prefix)/com
sysconfdir = $(prefix)/etc
datadir = $(datarootdir)
datarootdir = $(prefix)/share
libexecdir = $(exec_prefix)/libexec
sbindir = $(exec_prefix)/sbin
bindir = $(exec_prefix)/bin
archdir = $(rubyarchdir)


CC_WRAPPER = 
CC = clang
CXX = clang++
LIBRUBY = $(LIBRUBY_SO)
LIBRUBY_A = lib$(RUBY_SO_NAME)-static.a
LIBRUBYARG_SHARED = -l$(RUBY_SO_NAME)
LIBRUBYARG_STATIC = -l$(RUBY_SO_NAME)-static -framework CoreFoundation $(MAINLIBS)
empty =
OUTFLAG = -o $(empty)
COUTFLAG = -o $(empty)
CSRCFLAG = $(empty)

RUBY_EXTCONF_H = 
cflags   = $(hardenflags) -fdeclspec  $(optflags) $(debugflags) $(warnflags)
cxxflags = 
optflags = -O3 -fno-fast-math
debugflags = -ggdb3
warnflags = -Wall -Wextra -Wextra-tokens -Wdeprecated-declarations -Wdivision-by-zero -Wdiv-by-zero -Wimplicit-function-declaration -Wimplicit-int -Wpointer-arith -Wshorten-64-to-32 -Wwrite-strings -Wold-style-definition -Wmissing-noreturn -Wno-cast-function-type -Wno-constant-logical-operand -Wno-long-long -Wno-missing-field-initializers -Wno-overlength-strings -Wno-parentheses-equality -Wno-self-assign -Wno-tautological-compare -Wno-unused-parameter -Wno-unused-value -Wunused-variable -Wmisleading-indentation -Wundef
cppflags = 
CCDLFLAGS = -fno-common
CFLAGS   = $(CCDLFLAGS) -I/opt/homebrew/include -DGOSU_DEPRECATED= -DNDEBUG -I/opt/homebrew/include/SDL2 -D_THREAD_SAFE $(ARCH_FLAG)
INCFLAGS = -I. -I$(arch_hdrdir) -I$(hdrdir)/ruby/backward -I$(hdrdir) -I$(srcdir) -I../../include -I../../dependencies/stb -I../../dependencies/utf8proc -I../../dependencies/SDL_sound -I../../dependencies/mojoAL/AL
DEFS     = 
CPPFLAGS =  -D_XOPEN_SOURCE -D_DARWIN_C_SOURCE -D_DARWIN_UNLIMITED_SELECT -D_REENTRANT $(DEFS) $(cppflags)
CXXFLAGS = $(CCDLFLAGS) -fdeclspec -std=gnu++17 -Dregister= -x objective-c++ -fobjc-arc -DNDEBUG -stdlib=libc++ -Wno-reserved-user-defined-literal -I/opt/homebrew/include/SDL2 -D_THREAD_SAFE $(ARCH_FLAG)
ldflags  = -L/opt/homebrew/lib -lSDL2 -framework AppKit -framework Foundation -framework OpenGL  -framework OpenGL -framework Metal
dldflags = -Wl,-undefined,dynamic_lookup 
ARCH_FLAG = -arch arm64
DLDFLAGS = $(ldflags) $(dldflags) $(ARCH_FLAG)
LDSHARED = $(CC) -dynamic -bundle
LDSHAREDXX = $(CXX) -dynamic -bundle
POSTLINK = dsymutil $@ 2>/dev/null; { test -z '$(RUBY_CODESIGN)' || codesign -s '$(RUBY_CODESIGN)' $@; }
AR = ar
LD = ld
EXEEXT = 

RUBY_INSTALL_NAME = $(RUBY_BASE_NAME)
RUBY_SO_NAME = ruby.3.4
RUBYW_INSTALL_NAME = 
RUBY_VERSION_NAME = $(RUBY_BASE_NAME)-$(ruby_version)
RUBYW_BASE_NAME = rubyw
RUBY_BASE_NAME = ruby

arch = arm64-darwin25
sitearch = $(arch)
ruby_version = 3.4.0
ruby = $(bindir)/$(RUBY_BASE_NAME)
RUBY = $(ruby)
BUILTRUBY = $(bindir)/$(RUBY_BASE_NAME)
ruby_headers = $(hdrdir)/ruby.h $(hdrdir)/ruby/backward.h $(hdrdir)/ruby/ruby.h $(hdrdir)/ruby/defines.h $(hdrdir)/ruby/missing.h $(hdrdir)/ruby/intern.h $(hdrdir)/ruby/st.h $(hdrdir)/ruby/subst.h $(arch_hdrdir)/ruby/config.h

RM = rm -f
RM_RF = rm -fr
RMDIRS = rmdir -p
MAKEDIRS = mkdir -p
INSTALL = /usr/bin/install -c
INSTALL_PROG = $(INSTALL) -m 0755
INSTALL_DATA = $(INSTALL) -m 644
COPY = cp
TOUCH = exit >

#### End of system configuration section. ####

preload = 
libpath = . $(libdir)
LIBPATH = -L. -L$(libdir)
DEFFILE = 

CLEANFILES = mkmf.log
DISTCLEANFILES = 
DISTCLEANDIRS = 

extout = 
extout_prefix = 
target_prefix = 
LOCAL_LIBS = 
LIBS = $(LIBRUBYARG_SHARED)  -lpthread  
ORIG_SRCS = SDL_sound.c SDL_sound_aiff.c SDL_sound_au.c SDL_sound_coreaudio.c SDL_sound_flac.c SDL_sound_modplug.c SDL_sound_mp3.c SDL_sound_raw.c SDL_sound_shn.c SDL_sound_voc.c SDL_sound_vorbis.c SDL_sound_wav.c fastmix.c load_669.c load_amf.c load_ams.c load_dbm.c load_dmf.c load_dsm.c load_far.c load_gdm.c load_it.c load_mdl.c load_med.c load_mod.c load_mt2.c load_mtm.c load_okt.c load_psm.c load_ptm.c load_s3m.c load_stm.c load_ult.c load_umx.c load_xm.c mmcmp.c modplug.c mojoal.c snd_dsp.c snd_flt.c snd_fx.c sndfile.c sndmix.c utf8proc.c RubyGosu.cxx Audio.cpp AudioFileAudioToolbox.cpp AudioFileSDLSound.cpp AudioImpl.cpp Bitmap.cpp BitmapIO.cpp BlockAllocator.cpp Channel.cpp Color.cpp DirectoriesApple.cpp DirectoriesUnix.cpp DirectoriesWin.cpp FileUnix.cpp FileWin.cpp Font.cpp GosuGLView.cpp GosuViewController.cpp Graphics.cpp IO.cpp Image.cpp Input.cpp InputUIKit.cpp Inspection.cpp LargeImageData.cpp Macro.cpp MarkupParser.cpp Math.cpp OffScreenTarget.cpp Resolution.cpp TexChunk.cpp Text.cpp TextBuilder.cpp TextInput.cpp Texture.cpp TimingApple.cpp TimingUnix.cpp TimingWin.cpp Transform.cpp TrueTypeFont.cpp TrueTypeFontApple.cpp TrueTypeFontUnix.cpp TrueTypeFontWin.cpp Utility.cpp Version.cpp WinUtility.cpp Window.cpp WindowUIKit.cpp
SRCS = $(ORIG_SRCS) 
OBJS = SDL_sound.o SDL_sound_aiff.o SDL_sound_au.o SDL_sound_coreaudio.o SDL_sound_flac.o SDL_sound_modplug.o SDL_sound_mp3.o SDL_sound_raw.o SDL_sound_shn.o SDL_sound_voc.o SDL_sound_vorbis.o SDL_sound_wav.o fastmix.o load_669.o load_amf.o load_ams.o load_dbm.o load_dmf.o load_dsm.o load_far.o load_gdm.o load_it.o load_mdl.o load_med.o load_mod.o load_mt2.o load_mtm.o load_okt.o load_psm.o load_ptm.o load_s3m.o load_stm.o load_ult.o load_umx.o load_xm.o mmcmp.o modplug.o mojoal.o snd_dsp.o snd_flt.o snd_fx.o sndfile.o sndmix.o utf8proc.o RubyGosu.o Audio.o AudioFileAudioToolbox.o AudioFileSDLSound.o AudioImpl.o Bitmap.o BitmapIO.o BlockAllocator.o Channel.o Color.o DirectoriesApple.o DirectoriesUnix.o DirectoriesWin.o FileUnix.o FileWin.o Font.o GosuGLView.o GosuViewController.o Graphics.o IO.o Image.o Input.o InputUIKit.o Inspection.o LargeImageData.o Macro.o MarkupParser.o Math.o OffScreenTarget.o Resolution.o TexChunk.o Text.o TextBuilder.o TextInput.o Texture.o TimingApple.o TimingUnix.o TimingWin.o Transform.o TrueTypeFont.o TrueTypeFontApple.o TrueTypeFontUnix.o TrueTypeFontWin.o Utility.o Version.o WinUtility.o Window.o WindowUIKit.o
HDRS = $(srcdir)/RubyGosu.h $(srcdir)/AudioFile.hpp $(srcdir)/AudioImpl.hpp $(srcdir)/BlockAllocator.hpp $(srcdir)/ClipRectStack.hpp $(srcdir)/DrawOp.hpp $(srcdir)/DrawOpQueue.hpp $(srcdir)/EmptyImageData.hpp $(srcdir)/GosuGLView.hpp $(srcdir)/GosuViewController.hpp $(srcdir)/GraphicsImpl.hpp $(srcdir)/Iconv.hpp $(srcdir)/LargeImageData.hpp $(srcdir)/Log.hpp $(srcdir)/Macro.hpp $(srcdir)/MarkupParser.hpp $(srcdir)/OffScreenTarget.hpp $(srcdir)/RenderState.hpp $(srcdir)/TexChunk.hpp $(srcdir)/TextBuilder.hpp $(srcdir)/Texture.hpp $(srcdir)/TransformStack.hpp $(srcdir)/TrueTypeFont.hpp $(srcdir)/WinUtility.hpp
LOCAL_HDRS = 
TARGET = gosu
TARGET_NAME = gosu
TARGET_ENTRY = Init_$(TARGET_NAME)
DLLIB = $(TARGET).bundle
EXTSTATIC = 
STATIC_LIB = 

TIMESTAMP_DIR = .
BINDIR        = $(bindir)
RUBYCOMMONDIR = $(sitedir)$(target_prefix)
RUBYLIBDIR    = $(sitelibdir)$(target_prefix)
RUBYARCHDIR   = $(sitearchdir)$(target_prefix)
HDRDIR        = $(sitehdrdir)$(target_prefix)
ARCHHDRDIR    = $(sitearchhdrdir)$(target_prefix)
TARGET_SO_DIR =
TARGET_SO     = $(TARGET_SO_DIR)$(DLLIB)
CLEANLIBS     = $(TARGET_SO) $(TARGET_SO:=.dSYM)
CLEANOBJS     = $(OBJS) *.bak
TARGET_SO_DIR_TIMESTAMP = $(TIMESTAMP_DIR)/.sitearchdir.time

all:    $(DLLIB)
static: $(STATIC_LIB)
.PHONY: all install static install-so install-rb
.PHONY: clean clean-so clean-static clean-rb

clean-static::
clean-rb-default::
clean-rb::
clean-so::
clean: clean-so clean-static clean-rb-default clean-rb
		-$(Q)$(RM_RF) $(CLEANLIBS) $(CLEANOBJS) $(CLEANFILES) .*.time

distclean-rb-default::
distclean-rb::
distclean-so::
distclean-static::
distclean: clean distclean-so distclean-static distclean-rb-default distclean-rb
		-$(Q)$(RM) Makefile $(RUBY_EXTCONF_H) conftest.* mkmf.log
		-$(Q)$(RM) core ruby$(EXEEXT) *~ $(DISTCLEANFILES)
		-$(Q)$(RMDIRS) $(DISTCLEANDIRS) 2> /dev/null || true

realclean: distclean
install: install-so install-rb

install-so: $(DLLIB) $(TARGET_SO_DIR_TIMESTAMP)
	$(INSTALL_PROG) $(DLLIB) $(RUBYARCHDIR)
clean-static::
	-$(Q)$(RM) $(STATIC_LIB)
install-rb: pre-install-rb do-install-rb install-rb-default
install-rb-default: pre-install-rb-default do-install-rb-default
pre-install-rb: Makefile
pre-install-rb-default: Makefile
do-install-rb:
do-install-rb-default:
pre-install-rb-default:
	@$(NULLCMD)
$(TARGET_SO_DIR_TIMESTAMP):
	$(Q) $(MAKEDIRS) $(@D) $(RUBYARCHDIR)
	$(Q) $(TOUCH) $@

site-install: site-install-so site-install-rb
site-install-so: install-so
site-install-rb: install-rb

.SUFFIXES: .c .m .cc .mm .cxx .cpp .o .S

.cc.o:
	$(ECHO) compiling $(<)
	$(Q) $(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) $(COUTFLAG)$@ -c $(CSRCFLAG)$<

.cc.S:
	$(ECHO) translating $(<)
	$(Q) $(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) $(COUTFLAG)$@ -S $(CSRCFLAG)$<

.mm.o:
	$(ECHO) compiling $(<)
	$(Q) $(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) $(COUTFLAG)$@ -c $(CSRCFLAG)$<

.mm.S:
	$(ECHO) translating $(<)
	$(Q) $(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) $(COUTFLAG)$@ -S $(CSRCFLAG)$<

.cxx.o:
	$(ECHO) compiling $(<)
	$(Q) $(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) $(COUTFLAG)$@ -c $(CSRCFLAG)$<

.cxx.S:
	$(ECHO) translating $(<)
	$(Q) $(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) $(COUTFLAG)$@ -S $(CSRCFLAG)$<

.cpp.o:
	$(ECHO) compiling $(<)
	$(Q) $(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) $(COUTFLAG)$@ -c $(CSRCFLAG)$<

.cpp.S:
	$(ECHO) translating $(<)
	$(Q) $(CXX) $(INCFLAGS) $(CPPFLAGS) $(CXXFLAGS) $(COUTFLAG)$@ -S $(CSRCFLAG)$<

.c.o:
	$(ECHO) compiling $(<)
	$(Q) $(CC) $(INCFLAGS) $(CPPFLAGS) $(CFLAGS) $(COUTFLAG)$@ -c $(CSRCFLAG)$<

.c.S:
	$(ECHO) translating $(<)
	$(Q) $(CC) $(INCFLAGS) $(CPPFLAGS) $(CFLAGS) $(COUTFLAG)$@ -S $(CSRCFLAG)$<

.m.o:
	$(ECHO) compiling $(<)
	$(Q) $(CC) $(INCFLAGS) $(CPPFLAGS) $(CFLAGS) $(COUTFLAG)$@ -c $(CSRCFLAG)$<

.m.S:
	$(ECHO) translating $(<)
	$(Q) $(CC) $(INCFLAGS) $(CPPFLAGS) $(CFLAGS) $(COUTFLAG)$@ -S $(CSRCFLAG)$<

$(TARGET_SO): $(OBJS) Makefile
	$(ECHO) linking shared-object $(DLLIB)
	-$(Q)$(RM) $(@)
	$(Q) $(LDSHAREDXX) -o $@ $(OBJS) $(LIBPATH) $(DLDFLAGS) $(LOCAL_LIBS) $(LIBS)
	$(Q) $(POSTLINK)



$(OBJS): $(HDRS) $(ruby_headers)
