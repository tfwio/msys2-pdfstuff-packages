

mingw_mode='i686 x86_64'
gpg_kname="Thomas F Wroble"

## 
## depends on definitions in...
## depends: ./w64/common/packages.sh
## ./w64/common/common-pkg-util.sh
## 

get_barch ()
{
    if   [[ $1 == i686   ]]; then barch=32;
    elif [[ $1 == x86_64 ]]; then barch=64;
    fi
}
# functions (used) private
# ------------------------------------------------------------------------
# Clean the package (if ${_f_clean}==true), delete src directory and pkg directory
# (no longer) Make mingw-w64-[package-name].pkg.tar.xz
# Install it using pacman.
# (no longer) Move the package to package-repository.
mk32 () # full path # _f_clean = false
{
  if [[ -z ${1} ]]; then _pkg_id=${PWD}; else _pkg_id=${1}; fi
  _f_clean=$2
  msg_y "building pkg:" ${_pkg_id}
  pushd ${_pkg_id} > /dev/null
    
    if [[ ${_cleanfirst} == true || ${_f_clean} == true ]]; then msg_g ' ->' Removing src and pkg directory...; rm -rdf src pkg; fi
    rm -f *.log *.log.[1-9] logpipe*
    msg_g ' ->' makepkg-mingw32 '(logging)...'
    makepkg-mingw32 -L --force --key ${gpg_kname}  || msg_r ¡F! error
    rm -f logpipe*
    pacman -U --force --noconfirm mingw-w64-i686*.pkg.tar.xz
    func_move mingw

  popd > /dev/null
}
# Clean the package (if ${_f_clean}==true)
# Make mingw-w64-[package-name].pkg.tar.xz
# Install it using pacman.
# (no longer) Move the package to package-repository.
mk64 () # full path # _f_clean = false
{
  if [[ -z ${1} ]]; then _pkg_id=${PWD}; else _pkg_id=${1}; fi
  msg_y "building pkg:" ${_pkg_id}
  pushd ${_pkg_id} > /dev/null

    if [[ ${_cleanfirst} == true || ${_f_clean} == true ]]; then msg_g ' ->' Removing src and pkg directory...; rm -rdf src pkg; fi
    rm -f *.log *.log.[1-9] logpipe*
    msg_g ' ->' makepkg-mingw64 '(logging)...'
    makepkg-mingw64 -L --force --key ${gpg_kname}  || msg_r ¡F! error
    rm -f logpipe*
    pacman -U --force --noconfirm mingw-w64-i686*.pkg.tar.xz
    func_move mingw

  popd > /dev/null
}

## THIS FUNCTION IS TO BE REMOVED

# Clean the package (if ${_f_clean}==true)
# Make mingw-w64-[package-name].pkg.tar.xz
# Install it using pacman.
# (no longer) Move the package to package-repository.
mkall () # full path # _f_clean = false
{

  barch=i686;   mk32 ${@}
  barch=x86_64; mk64 ${@}
}

## always use mingw package group
function mv_pkg ()
{
  pkg_group=mingw
  for i in ${_mv_pkg}; do
    cd ${i}
    func_move ${pkg_group}
  done
}

# ------------------------------------------------------------------------

makeall ()
{
  for i in ${_pkg_all}; do mkall $i ${@}; done
}
make32 ()
{
  msg_g '==>' building 32-bit packages
  for i in ${_pkg_all}; do barch=i686; mk32 $i ${@}; done
}
make64 ()
{
  msg_g '==>' building 64-bit packages
  for i in ${_pkg_all}; do barch=x86_64; mk64 $i ${@}; done
}

build32 ()
{
  make32 ${@}
  gendb32 tfw mingw
}

build64 ()
{
  make64 ${@}
  gendb64 tfw mingw
}
# ------------------------------------------------------------------------

## 
## The following three functions are abstracted by
## files: mkp, xin, xun
## 
## param 1 : package-group; such as 'mingw'
## 32 or 64 is appended automatically so that we end up
## with .../packages/mingw32/mingw-w64-[package-name].pkg.tar.xz
## 

func_move () #1 package-group
{
  # msg_r 'obsolete function call' We have made changes to repository layout.
  # exit 1
  if [[ -z ${1} ]]; then msg_r 'error' 'Group (#1) parameter required'; exit 1; fi
  if [[ ! -d ../packages/${1} ]]; then msg_r 'error' No group with that name exists; exit 1; fi
  for i in ${mingw_mode}; do
    get_barch $i
    # local mycmd="mv -f mingw-w64-${i}*.pkg.tar.xz ../packages/${1}${barch}/${i}"
    local mycmd="mv -f mingw-w64-${i}*.pkg.tar.xz ../packages/${1}/${i}"
    msg_r '->' ${mycmd}
    ${mycmd} &> /dev/null
  done
}

# - semi-obsolete-note: ${_fi}=mingw-w64-x86_64-fontforge-
func_inst ()
{
  msg_r 'obsolete function call' We have made changes to repository layout.
  exit 1

  xfx=/d/dev/g/msys/w64/packages
  
  for i in ${fpackages}; do
    msg_y '==>' package: ${i}
    pacman -U ${xfx}/${_fi}${i}*.pkg.tar.xz --force --noconfirm > /dev/null
  done
  for i in ${xpackages}; do
    msg_y '==>' package: ${i}
    pacman -U ${xfx}/${_ri}${i}*.pkg.tar.xz --force --noconfirm > /dev/null
  done
}
func_unin ()
{
  msg_r 'obsolete function call' We have made changes to repository layout.
  exit 1
  
  for i in ${fpackages}; do
    msg_y '==>' package: ${i}
    pacman -R --noconfirm ${_fu}${i}
  done
  for i in ${xpackages}; do
    msg_y '==>' package: ${i}
    pacman -R --noconfirm ${_ru}${i}
  done
}


