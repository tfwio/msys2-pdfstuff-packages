##
## ./w64/common/packages.sh
## 
## See common-pkg-util.sh for functions: makeall, make32, make64
## ...and other methods pertaining to these lists.
## 

## 
## Defines package-names for font-forge build.
## This script might be obsolete.
## 
## 

_fu=local/mingw-w64-x86_64-fontforge-
_fi=mingw-w64-x86_64-fontforge-

_ru=local/mingw-w64-x86_64-fontforgeX-
_ri=mingw-w64-x86_64-fontforgeX-

# for duplicating
_m_packages="
"
# these are dll files distributed
# with VcxSrv 1.14
_xorg_dist_114_="
libX11
libXau
libxcb
libXext
libXmu
zlib
"
_xorg_files_="
zlib1.dll
msvcp100.dll
msvcr100.dll
plink.exe
vcxsrv.exe
xkbcomp.exe
system.XWinrc
xkbcomp.exe
"

arch=i686
chost=mingw-w64-${arch}
pyver=python2
# gcc+git+binutils
_pkg32="
diffutils
findutils
gawk
liblzma
m4
make
patch
tar
xz
git
binutils
automake
autoconf
pkg-config
${chost}-${pyver}
${chost}-openssl
${chost}-gcc
${chost}-gmp
${chost}-gettext
${chost}-libiconv
${chost}-libtool
${chost}-zlib
${chost}-libpng
${chost}-giflib
${chost}-libtiff
${chost}-libjpeg-turbo
${chost}-libxml2
${chost}-freetype
${chost}-fontconfig
${chost}-glib2
${chost}-pixman
${chost}-harfbuzz
"

# pre packages
_pkg_pre="
/d/dev/g/msys/w64/mingw-w64-libspiro
/d/dev/g/msys/w64/mingw-w64-libuninameslist
"
# complete package list
_pkg_x="
/d/dev/g/msys/w64/mingw-w64-xorg-macros
/d/dev/g/msys/w64/mingw-w64-x11proto
/d/dev/g/msys/w64/mingw-w64-renderproto
/d/dev/g/msys/w64/mingw-w64-bigreqsproto
/d/dev/g/msys/w64/mingw-w64-kbproto
/d/dev/g/msys/w64/mingw-w64-inputproto
/d/dev/g/msys/w64/mingw-w64-xextproto
/d/dev/g/msys/w64/mingw-w64-xf86bigfontproto
/d/dev/g/msys/w64/mingw-w64-xcb-proto
/d/dev/g/msys/w64/mingw-w64-libXau
/d/dev/g/msys/w64/mingw-w64-libxtrans
/d/dev/g/msys/w64/mingw-w64-libxcb
/d/dev/g/msys/w64/mingw-w64-libX11
/d/dev/g/msys/w64/mingw-w64-libXext
/d/dev/g/msys/w64/mingw-w64-libXrender
/d/dev/g/msys/w64/mingw-w64-libXft
"

# post packages
_pkg_post="
/d/dev/g/msys/w64/mingw-w64-libcairo-xorg
/d/dev/g/msys/w64/mingw-w64-pango-xorg
"

# post packages
_pkg_ff="
/d/dev/g/msys/w64/mingw-w64-fontforge
"

# all packages
_pkg_all="
${_pkg_pre}
${_pkg_x}
${_pkg_post}
${_pkg_ff}
"

xpackages="
  xorg-macros
  x11proto
  renderproto
  bigreqsproto
  kbproto
  inputproto
  xextproto
  xf86bigfontproto
  xcb-proto
  libXau
  libxtrans
  libxcb
  libX11
  libXext
  libXrender
  libXft
"
xsoon="
"