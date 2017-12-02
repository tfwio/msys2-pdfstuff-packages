go_patch ()
{
	file=$1
	name=$2
	cp -f $file $file.old
	pushd src
	  diff -up $file $file.new > ../$name.patch
	  md5sum ../$name.patch
	popd
}

#go_patch mupdf-1.6-source/source/fitz/load-jpx.c 000-fitz-load-jpx_c
go_patch mupdf-1.6-source/Makethird 001-Makethird
# go_patch mupdf-1.6-source/Makethird 002-Makefile

#go_patch mupdf-qt-source/examples/mupdf-qt/simpleviewer/CMakeLists.txt 001-CMakeLists
#go_patch mupdf-qt-source/CMakeLists.txt 002-CMakeLists
