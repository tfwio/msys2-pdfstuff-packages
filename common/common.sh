#!/bin/sh
# ------------------------------------------------------------------------
. ../common/colourize.sh
. ../common/packages.sh
. ../common/common-pkg-util.sh
. ../common/common-pkg.sh

# ------------------------------------------------------------------------
is_offline=true
# ------------------------------------------------------------------------
if [[ -z ${is_offline} ]]; then is_offline=false; fi
if [[ -z ${_auto_}     ]]; then _auto_="autoreconf -i && automake --foreign -Wall"; fi
if [[ -z ${_msg_auto_} ]]; then _msg_auto_="autoreconf+automake"; fi

# fontforge-builds specific
# http://sourceforge.net/projects/vcxsrv/files/vcxsrv/

if [[ -z $CARCH ]]; then
  msg_r '==>' No architecture detected '(in MSYS mode)'
else
  msg_r '==>' $CARCH
fi

if [[ $CARCH == 'i686' ]]; then
  msg_r $CARCH Just saying...
  V_POTRACE=http://potrace.sourceforge.net/download/potrace-1.11.win32.tar.gz
  V_POTRACE=potrace-1.11.win32.tar.gz
  # V_VCXSRV=http://sourceforge.net/projects/fontforgebuilds/files/build-system-extras/VcXsrv-1.14.2-minimal.tar.bz2/download
  V_VCXSRV=VcXsrv-1.14.2-minimal.tar.bz2
  VCXSRV="VcXsrv-1.14.2-minimal.tar.bz2"
  POTRACE_DIR="potrace-1.11.win32"
elif [[ $CARCH == 'x86_64' ]]; then
  msg_r $CARCH Just saying...
  V_POTRACE=http://potrace.sourceforge.net/download/potrace-1.11.win64.tar.gz
  V_POTRACE=potrace-1.11.win64.tar.gz
  # V_VCXSRV=http://sourceforge.net/projects/fontforgebuilds/files/build-system-extras/VcXsrv-1.15.0.2-x86_64-minimal.tar.bz2/download
  V_VCXSRV=VcXsrv-1.15.0.2-x86_64-minimal.tar.bz2
  VCXSRV="VcXsrv-1.15.0.2-x86_64-minimal.tar.bz2"
  POTRACE_DIR="potrace-1.11.win64"
fi

# fontforge-builds specific
V_FREETYPE=http://download.savannah.gnu.org/releases/freetype/freetype-2.5.3.tar.bz2
V_FREETYPE=freetype-2.5.3.tar.bz2
POTRACE_ARC="$POTRACE_DIR.tar.gz"
# ------------------------------------------------------------------------
options=(!zipman !strip !docs libtool staticlibs !emptydirs !zipman !purge !upx !debug)

# ------------------------------------------------------------------------
## (obsolete)
# ------------------------------------------------------------------------
func_path ()
{
  if [[ ! -d ${1} ]]; then
    mkdir -p ${1}
    msg_g ' ->' Created `basename ${1}`
  else
    msg_g ' ->' "Created `basename ${1}` (prior)"
  fi
}
# ------------------------------------------------------------------------
# FIXME: may be cause for some concern
# - Deletes ${pkg_output} each time its called in
#   prepare function so that sources can be re-packaged.
# Used (only) in func_prepare
func_dirs ()
{
  msg_y '  ->' 'initialize directory-structure...'
  # remove src/source
  # if [[ -d ${pkg_source} ]]; then rm -drf ${pkg_source}; fi
  mkdir -p ${pkg_source}
  # remove pkg/...
  if [[ -d ${pkg_output} ]]; then rm -drf ${pkg_output}; fi
  mkdir -p ${pkg_output}
  # mkdir -p ${pkg_build}
  # if [[ -d ${pkg_build} ]]; then rm -drf ${pkg_build}; fi
}
# Sets custom variables for building xorg projects.
# Used in func_prepare, func_build and func_package
func_varx ()
{
  xproto=X.Org/proto
  xlib=X.Org/lib
  xcb=X.Org/xcb
}
# (describe me)
func_envi ()
{
  # For makepkg 'package' function
  # =================================================
  _sed_="s|${pkgdir}${MINGW_PREFIX}|${MINGW_PREFIX}|g"
  _pfx_="${pkgdir}${MINGW_PREFIX}"
  # =================================================
  # Just in case
  # =================================================
  PATH="$TARGET/bin:$PATH"
  # =================================================
  # Autoconfigure
  # =================================================
  ACLOCAL="aclocal -I $TARGET/share/aclocal -I $MINGW_PREFIX/share/aclocal -I $MINGW_PREFIX/share/aclocal"
  # =================================================
  # Package management
  # =================================================
  PKG_CONFIG_PATH="$TARGET/share/pkgconfig:$TARGET/lib/pkgconfig:$MINGW_PREFIX/share/pkgconfig:$MINGW_PREFIX/lib/pkgconfig:$MINGW_PREFIX/lib/pkgconfig:/usr/local/lib/pkgconfig:/lib/pkgconfig:/usr/local/share/pkgconfig"
  # =================================================
  # Compiler
  # =================================================
  CFLAGS="${CFLAGS} -DWIN32 -I${TARGET}/include -I${MINGW_PREFIX}/include -I/usr/local/include -I/include -g"
  CPPFLAGS="${CFLAGS}"
  LDFLAGS="-L${MINGW_PREFIX}/lib -L/usr/local/lib -L/lib" 
  HOST="--build=${CHOST} --host=${CHOST} --target=${CHOST}"
  TARGET=${pkg_source}
  if [[ -z ${LIBS} ]]; then # Apparently pointless
    LIBS=""
  else
    msg_r ' -->' LIBS variable was set.
  fi
  PMPREFIX="${CHOST}"
  # =================================================
  # Archetecture specific Python
  # =================================================
  if [[ "$CARCH" == "x86_64" ]]; then
    ARCH="64-bit"
    PYINST=${MINGW_PREFIX}/bin/python3
    PYVER=python3.4
  elif [[ "$CARCH" == "i686" ]]; then
    ARCH='32-bit'
    PYINST=${MINGW_PREFIX}/bin/python2
    PYVER=python2.7
  fi
}
# Sets custom variables for building font-forge
# Used in func_prepare, func_build and func_package
# - unused $pkg_build
func_vars ()
{
  # These variables are useful to create 'touch' files
  # which allows for building to skip doing things that
  # have already been done.
  _is_libtooled=$startdir/src/.is_libtoolized-$CARCH
  _is_autoconfd=$startdir/src/.is_autoconfd-$CARCH
  _is_configged=$startdir/src/.is_configured-$CARCH
    _is_patched=$startdir/src/.is_patched-$CARCH

  pkg_nam=${_realname}

  # if git-clone:
  # - based on real name.
  # if archive:
  # - packagename and version based (usually)
  # - manually set pkg_srcarc if this is an archive
  pkg_srcarc=$startdir/${pkg_nam}

  # source
  pkg_source=${srcdir}/${pkg_nam}; 
  pkg_src=${srcdir}/source-$CARCH;

  # pushd ${pkg_source} > /dev/null; PKG_SOURCE=`pwd -W`; popd > /dev/null

  # build
  pkg_build=$srcdir/build-$CARCH;
  pkg_work=$srcdir/work-$CARCH;
  # pushd ${pkg_build} > /dev/null; PKG_BUILD=`pwd -W`; popd > /dev/null

  # install
  pkg_output=${pkgdir}${MINGW_PREFIX}; 
  # pushd ${pkg_output} > /dev/null; PKG_OUTPUT=`pwd -W`; popd > /dev/null
}
# ------------------------------------------------------------------------
# Used in func_prepare
func_patch () #1 patchname.patch #2 directory(default=${pkg_src}) #3 mode=['diff'|'git'(default)]
{
  _patch=$1; _path=$2; _mode=$3
  if [[ -z ${_mode}         ]]; then _mode=git; fi
  if [[ -z ${_path}         ]]; then _path=${pkg_src}; fi
  if [[ ! -f ${_is_patched} ]]; then
    pushd ${_path} > /dev/null
      if [[ "${_mode}" == "git" ]]; then
        msg_m '  ->' 'applying (git) patch...'
        git apply "${_patch}"
        # git apply --check --ignore-whitespace "${_patch}"
        if [[ ${?} == 0 ]]; then touch ${_is_patched}
        else msg_r '------->' ¡WTF?
        fi
      elif [[ "${_mode}" == "diff" ]]; then
        msg_m ' -->' 'applying (diff) patch...'
        msg_r '===!>' 'diff patches not supported *yet*'
        exit 1
      else
        msg_b '==!>' "Applied patch (prior)..." ${_patch}
      fi
    popd > /dev/null
  fi
}
# (possibly unused)
# - It may be that this method is used to bypass
#   setting environment variables used in xorg projects.
# - That isn't likely.  This is probably here
#   simply to abstract or overload func_prepare (below).
function func_prep () #1 patch #2 pkg_source
{
  _auto_="autoreconf -v --install"
  _msg_auto_="${_auto_}"
  func_prepare "$1" "$2" "$3" "$4" "$5"
}
# ------------------------------------------------------------------------
## - The following three functions are why this script exists.
##   We have func_prepare, func_build and func_package.
## - The idea is to use 'touch' in order to flag what needs
##   to actually be done.
# ------------------------------------------------------------------------
# (describe me)
# (o) is optional = '' (if !touch-file)|force=1|skip=2
func_prepare () #1 patch #2 (optional) pkg_source #3 (o) patch #4 (o) libtool #5 (o) autotools
{
  # Required variables
  # =================================================
  _patch=$1; _pname=$2
  # =================================================
  # Optional variables
  # =================================================
  _f_patch=$3; _f_lt=$4; _f_auto=$5 
  # =================================================
  func_vars; func_varx; func_envi
  # =================================================
  # Override pkg_source in leu of ${_pname}
  # =================================================
  if [[ ! -z ${_pname} ]]; then
    msg_r ' -->' Override pkg_source=${_pname}
    pkg_source=${_pname}
  fi
  # =================================================
  # remove build directory if exists
  # =================================================
  func_dirs
  # 
  cd $startdir
  # =================================================
  # Copy sources to common build-directory (source-i686 or source-x86_64)
  # $pkg_source becomes $pkg_src
  # =================================================
  if [[ ! -d ${pkg_src} ]]; then
    msg_y ' -->' "move source-tree..."
    mv -f ${pkg_source} ${pkg_src} > /dev/null
  else
    msg_y ' -->' "move source-tree (prior; skipping)"
  fi
  # =================================================
  # Patch if a patch is provided
  # todo: support multiple patches
  # =================================================
  echo check-_patch
  if [[ ! -z ${_patch} || ${_f_patch} == 1 && ${_f_patch} != 2 ]]; then func_patch ${_patch} ${pkg_src}; fi

  msg_m '  ->' "prepareing build (${pkg_src})..."
  
  cd ${pkg_src}
  # =================================================
  # Libtoolize by default
  # This can be turned off, forced or allowed provoded
  # no present ${_is_libtooled} file.
  # =================================================
  echo check-_is_libtooled
  if [[ ! -f ${_is_libtooled} || ${_f_lt} == 1 ]]; then
    if [[ ${_f_lt} != 2 ]]; then
      msg_y ' -->' "libtoolize..."
      libtoolize -i --force && touch ${_is_libtooled}
    fi
  else
    msg_y ' -->' "libtoolize (done prior)"
  fi
  cd ${pkg_src}
  # =================================================
  # Autoconfiguration
  # This can be turned off, forced or allowed provoded
  # no present ${_is_libtooled} file.
  # =================================================
  echo check-_is_autoconfd
  if [[ ! -f ${_is_autoconfd} ]] || [[ ${_f_auto} == 1 ]]; then
    if [[ ! ${_f_auto} == 2 ]]; then
      msg_y '  ->' "${_msg_auto_} (${_auto_})"
      ${_auto_} && touch ${_is_autoconfd}
    fi
    # autoreconf -i || true
    # automake --foreign -Wall || true && touch ${_is_autoconfd}
  else
    msg_b ' -->' "pre-configuration (done prior)"
  fi
}
# (describe me)
func_build () #1 rename pkg_source #2 config-vars #3 force: configure
{
  _pname=$1; _config=$2; _force_config=$3 
  func_varx; func_vars; func_envi

  if [[ ! -z ${_pname} ]]; then pkg_source=${_pname}; fi

  if [[ ! -d ${pkg_output} ]]; then
    msg_r ' ->' Create build directory
    mkdir -p ${pkg_output}
  fi

  if [[ ! -d ${pkg_work} ]]; then
    msg_r ' ->' Create work directory
    mkdir -p ${pkg_work}
  fi

  msg_b ' ->' "Step into work directory (`basename ${pkg_work}`)"

  pushd ${pkg_work} > /dev/null

  if [[ ! -f ${_is_configged} || ${_force_config} == 1 && ${_force_config} != 2 ]]; then
    # msg_g '  -->' "configure help..."
    # $pkg_src/configure --help
    prefix=$MINGW_PREFIX
    msg_g '  -->' "configure..." $pkg_src/configure $HOST --prefix=${pkg_output} ${_config} && touch ${_is_configged}
    $pkg_src/configure $HOST --prefix=${pkg_output} ${_config} && touch ${_is_configged}
  else
    msg_g '  -->' "configure (done prior)"
  fi
  msg_y '===>' $CLAGS
  # make is always performed
  make; make install
  popd > /dev/null

  msg_y 'PACKAGE DIRECTORY: ' $pkgdir
}
# This method is particularly useful for re-writnig
# package-config paths for installing in msys2.
func_package() {
  msg_r '  ->' fixing pkgconfig file
  func_varx; func_vars; func_envi
  sed -i "${_sed_}" ${_pfx_}/lib/pkgconfig/*.pc     2> /dev/null || true
  sed -i "${_sed_}" ${_pfx_}/lib/*.la               2> /dev/null || true
  sed -i "${_sed_}" ${_pfx_}/share/pkgconfig/*.pc   2> /dev/null || true
  sed -i "${_sed_}" ${_pfx_}/share/*.la             2> /dev/null || true
  # pushd "${pkg_output}" > /dev/null
  # popd > /dev/null
}
