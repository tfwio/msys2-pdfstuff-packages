#!/usr/bin/env bash

#taken from https://bbs.archlinux.org/viewtopic.php?id=131666 by falconindy
# https://gist.githubusercontent.com/nandub/04f1f049a5e55476b642/raw/02c13a02fb7e9121d1390b3a4f5f6fca5d11e07b/pkgsum.sh
awk -v newsums="$(makepkg -g)" '
BEGIN {
  if (!newsums) exit 1
}

/^[[:blank:]]*(md|sha)[[:digit:]]+sums=/,/\)[[:blank:]]*$/ {
  if (!i) print newsums; i++
  next
}

1
' PKGBUILD > PKGBUILD.new && mv PKGBUILD{.new,}