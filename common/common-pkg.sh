##
## [dev]/w64/common/common-pkg.sh
## 
## - no dependencies aside from `/bin/repo-add`
# 
# Usage
# ---------------
# 
# gendb32 tfw mingw
# 
##
## PACMAN REPOSITORY DATABASE GENERATION FUNCTIONS
## -----------------------------------------------------------------------
##
## - Designed to run 'gendb' function,
##   generating pacman repository database file(s).
## - How it works
##   - We run through the two architectures, i686 and x86_64.
##   - When executing 'gendb' we send two parameters, db-name and group-name.
## - 20150131
##   - There are only junk packages that need to be reformulated
##     and/or regenerated before this script can be of service.
## 
# 
# - Generate a directory (mkdir -p) for provided group name
#   if one does not already exist, per architecture.
# 
gen_init_test () #1 group #2 architecture
{
  if [[ ! -d ../packages/${group}/${larch} ]]; then mkdir -p ../packages/${group}/${larch}; fi
}

gen_pkg_db () #1 db-name #2 architecture (i686 or x86_64) #3 group
{
  if [ -z ${1} ]; then msg_r 'error' No database-name was specified; exit 1
  elif [ -z ${2} ]; then msg_r 'error' No architecture was specified; exit 1
  elif [ -z ${3} ]; then msg_r 'error' No group was specified; exit 1
  fi
  dbname=${1}; larch=${2}; group=${3}
  gen_init_test ${group} ${larch}
  if [[ $larch == 'x86_64' ]]; then tag=64; elif [ $larch == i686 ]; then tag=32; fi
  msg_b '==>' generating ${2}/${1} database
  repo-add -s --key A474B1EA ../packages/${group}/${larch}/${dbname}${tag}.db.tar.gz ../packages/${group}/${larch}/*.pkg.tar.xz
}

gendb () #1 database-name #2 group-name
{
  gen_pkg_db ${1} x86_64 ${2}
  gen_pkg_db ${1} i686   ${2}
}

gendb32 () #1 database-name #2 group-name
{
  if [ -z ${1} ]; then msg_r 'error' No database-name was specified; return 1; exit
  elif [ -z ${2} ]; then msg_r 'error' No group was specified; return 1; exit
  fi
  gen_pkg_db ${1} i686 ${2}
}

gendb64 () #1 database-name #2 group-name
{
  if [ -z ${1} ]; then msg_r 'error' No database-name was specified; return 1; exit
  elif [ -z ${2} ]; then msg_r 'error' No group was specified; return 1; exit
  fi
  gen_pkg_db ${1} x86_64 ${2}
}