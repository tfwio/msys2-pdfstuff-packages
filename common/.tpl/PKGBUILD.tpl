# Maintainer: T. F. Wroble <tfwroble@gmail.com>

_realname=

#groups=(fontforge)

pkgname="${MINGW_PACKAGE_PREFIX}-${_realname}"
pkgver=git
pkgrel=0
pkgdesc='(no description!)'

arch=('any')
url='(no url!!!)'

# important
license=('GPL')

pkg_sha='(optional: for a specific git-revision; manually implement)'

#ource=("git+http://github.com/fontforge/libspiro")
source=('!!! important !!! place url to package here!!!')
md5sums=('SKIP')

# options=(!zipman !strip !docs libtool staticlibs !emptydirs !zipman purge !upx !debug)

makedepends=("${MINGW_PACKAGE_PREFIX}-gcc")

. ../common/common.sh; msg_m '  ->' 'common script initialized...'

# the following is specific to a particular project
# so you probably need to rewrite it.

prepare ()
{
  func_vars

  # remove build directory if exists
  msg_y '  -->' "remove ${pkg_src}"

  msg_m '  ->' 'initialize directory-structure...'

  func_dirs

  cd $startdir

  # msg_y '  -->' "   start=${startdir}"

  if [[ ! -d ${pkg_src} ]]; then
    msg_y '  -->' "move source-tree..."
    mv -f ${pkg_source} ${pkg_src} > /dev/null
  else
    msg_y '  -->' "move source-tree (prior; skipping)"
  fi

  msg_m '  ->' 'prepareing build...'
  
  # exit 1
  cd $pkg_src
  
  if [[ ! -f ${_is_libtooled} ]]; then
    msg_g '  -->' "libtoolize..."
    libtoolize -i --force && touch ${_is_libtooled}
  else
    msg_g '  -->' "libtoolize (done prior)"
  fi
  if [[ ! -f ${_is_autoconfd} ]]; then
    msg_g '  -->' "autoreconf+automake..."
    autoreconf -i && automake --foreign -Wall && touch ${_is_autoconfd}
  else
    msg_g '  -->' "autoreconf+automake (done prior)"
  fi
}

build()
{
  msg_g ' ->' Set variables
  func_vars

  export prefix="${pkg_output}"

  # yields the same as $CHOST: b_machine=`gcc -dumpmachine`
  flags="--build=$CHOST --host=$CHOST --target=$CHOST"

  if [[ ! -d ${pkg_output} ]]; then
    msg_r ' ->' Create build directory
    mkdir -p ${pkg_output}
  fi

  if [[ ! -d ${pkg_work} ]]; then
    msg_r ' ->' Create work directory
    mkdir -p ${pkg_work}
  fi

  msg_g ' ->' Setp into work directory

  pushd ${pkg_work} > /dev/null

  if [[ ! -f ${_is_configged} ]]; then
    msg_g '  -->' "configure..."
    $pkg_src/configure "--prefix=$pkg_output" && touch ${_is_configged}
  else
    msg_g '  -->' "configure (done prior)"
  fi

  make; make install
  popd > /dev/null


  msg_y ' -> pkgdir=' $pkgdir
  #prefix=${pkgdir}${MINGW_PREFIX} \
  # export prefix="${pkgdir}${MINGW_PREFIX}"
  # make prefix=$prefix build=release install

  # mingw32-make || mingw32-make || mingw32-make
}

package() {
  func_vars
  pfx=${pkgdir}${MINGW_PREFIX}
  # msg_g ' ->' fixing pkgconfig file
  # sed -i "s|${pfx}|${MINGW_PREFIX}|g" $pfx/lib/pkgconfig/${_realname}.pc
  # sed -i "s|${pfx}|${MINGW_PREFIX}|g" $pfx/lib/${_realname}.la
  pushd "${pkg_output}" > /dev/null
  msg_g '==>' -------nothing to say...----------------------
  popd > /dev/null
}