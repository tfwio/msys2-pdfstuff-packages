
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

#if /usr/bin/tput setaf 0 &>/dev/null; then
#  ALL_OFF="$(/usr/bin/tput sgr0)"
#  BOLD="$(/usr/bin/tput bold)"
#  BLUE="${BOLD}$(/usr/bin/tput setaf 4)"
#  GREEN="${BOLD}$(/usr/bin/tput setaf 2)"
#  RED="${BOLD}$(/usr/bin/tput setaf 1)"
#  YELLOW="${BOLD}$(/usr/bin/tput setaf 3)"
#else
#  ALL_OFF="\e[1;0m"
#  BOLD="\e[1;1m"
#  BLUE="${BOLD}\e[1;34m"
#  GREEN="${BOLD}\e[1;32m"
#  RED="${BOLD}\e[1;31m"
#  YELLOW="${BOLD}\e[1;33m"
#fi

#readonly ALL_OFF BOLD BLUE GREEN RED YELLOW


#mox=`echo $(pwd ./..)`
#fox=$(cygpath -u "${mox}")
#
#echo "mox: ${mox}"
#echo "fox: ${fox}"