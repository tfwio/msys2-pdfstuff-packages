#!/bin/sh
# pkg-helper.sh

has_pkg_helper=true

# insert the following method into prepare(), buid()
# and package() functions in PKGBUILD.
# > then you can call 'prepare_init 1' where omitting '1' will prrevent
# > paths from being displayed as they had been set.
# 
# prepare_init ()
# {
#   if [[ ! "x${has_pkg_helper}" == "true" ]]; then
#     . ${startdir}/../common/pkg-helper.sh
#   fi
#   local_paths $1
# }

plain() {
  local mesg=$1; shift
  printf "${BOLD}    ${mesg}${ALL_OFF}\n" "$@" >&2
}

print_warning() {
  local mesg=$1; shift
  printf "${YELLOW}=> WARNING:${ALL_OFF}${BOLD} ${mesg}${ALL_OFF}\n" "$@" >&2
}

print_msg1() {
  local mesg=$1; shift
  printf "${GREEN}==> ${ALL_OFF}${BOLD} ${mesg}${ALL_OFF}\n" "$@" >&2
}

print_msg2() {
  local mesg=$1; shift
  printf "${BLUE}  ->${ALL_OFF}${BOLD} ${mesg}${ALL_OFF}\n" "$@" >&2
}

print_error() {
  local mesg=$1; shift
  printf "${RED}==> ERROR:${ALL_OFF}${BOLD} ${mesg}${ALL_OFF}\n" "$@" >&2
}

local_paths ()
{
  # . ${startdir}/helper.sh
  print_msg1 "setting local paths"
  print_msg2 "CARCH: $CARCH"
  print_msg2 "CHOST: $CHOST"
  print_msg2 "MINGW_PREFIX: $MINGW_PREFIX"
  print_msg2 "MINGW_CHOST: $MINGW_CHOST"
  
  pushd $MINGW_PREFIX/bin > /dev/null; ifix=`pwd -W`; popd > /dev/null
  pushd $MINGW_PREFIX > /dev/null; WMD=`pwd -W`; popd
  workdir=${startdir}/src/work-${CARCH}
  pkgdir=${startdir}/pkg/${pkgname}
  builddir=${startdir}/src/build-${CARCH}
  pkgdest=${pkgdir}${MINGW_PREFIX}
  prefix=${builddir}

  if [[ "x$1" == "x1" ]]; then
    print_msg2 "builddir   : ${builddir}"
    print_msg2 "ifix       : ${ifix}"
    print_msg2 "pkgdest    : ${pkgdest}"
    print_msg2 "pkgdir     : ${pkgdir}"
    print_msg2 "prefix     : ${prefix}"
    print_msg2 "srcdir     : ${srcdir}"
    print_msg2 "startdir   : ${startdir}"
    print_msg2 "workdir    : ${workdir}"
    print_msg2 "WMD        : ${WMD}"
  fi
  pathsloaded=true
}

prepare_dirs ()
{
  if [[ -d ${builddir} ]]; then
    print_msg1 'remove build directory' #green
    rm -drf ${builddir}
  else
    print_warning 'no build directory to remove' # yellow
  fi
  if [[ -d ${workdir} ]]; then
    print_msg1 'remove work directory' #green
    rm -drf ${workdir}
  else
    print_warning 'no work directory to remove' # yellow
  fi
  if [[ -d ${pkgdest} ]]; then
    print_msg1 'remove pkgdest directory' #green
    rm -drf ${pkgdest}
  else
    print_warning 'no work directory to remove' # yellow
  fi
}
