ARCH=i686
CARCH=mingw-w64-${ARCH}
MINGW_PREFIX=mingw-w64-${CARCH}
PKGNAME=mupdf

workdir=src/work-${ARCH}
pkgdir=pkg/mingw-w64-i686-${PKGNAME}/mingw32

if [ ! -d ${dest} ]; then mkdir -p ${dest}; fi
fname=${workdir}/build/release/libjbig2dec.a
fdest=${pkgdir}/lib

echo "workdir: ${workdir}"
echo "pkgdir:  ${pkgdir}"


echo "file:    ${fname}"
echo "dest:    ${fdest}"
echo -------------------

cp $fname $fdest