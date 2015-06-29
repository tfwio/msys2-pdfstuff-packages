#!/sh
# colourize.sh
# https://wiki.archlinux.org/index.php/Color_Bash_Prompt
msg_clr () { #colour #title #message
  clr=$1; shift 1
  title=$1; shift 1
  printf "\e[1;${clr}${title}\e[0m \e[1;37m${*}\e[0m\n"
}

msg_r () { #title #message
  msg=$1; shift 1; msg_clr '31m' "${msg}" "${*}" # red
}
msg_g () { #title #message
  msg=$1; shift 1; msg_clr '32m' "${msg}" "${*}" # green
}
msg_y () { #title #message
  msg=$1; shift 1; msg_clr '33m' "${msg}" "${*}" # yellow
}
msg_b () { #title #message
  msg=$1; shift 1; msg_clr '34m' "${msg}" "${*}" # blue
}
msg_m () { #title #message
  msg=$1; shift 1; msg_clr '35m' "${msg}" "${*}" # magenta
}
msg_c () { #title #message
  msg=$1; shift 1; msg_clr '36m' "${msg}" "${*}" # cyan
}

## as they were
log_error() { # Red text
  title=$1; shift 1; echo -e "\e[31m${title}\e[0m" ${*}
}
log_status() { # Yellow text
  title=$1; shift 1; echo -e "\e[33m${title}\e[0m" ${*}
}
log_note() { # Green text
  title=$1; shift 1; echo -e "\e[32m${title}\e[0m" ${*}
}
warn () { # Red
  title=$1; shift 1; echo -e "\e[31m\e[1m${title}\e[0m" ${*}
}
bail () {
  title=$1; shift 1; echo -e "\e[31m\e[1m!!! Build failed at: ${title}\e[0m" ${*}; exit 1
}
# ------------------------------------------------------------