msys2-pdfstuff
==============
a few un-official PDF related `PKGBUILD` scripts for msys2

**UPDATED 2017-12**

- SEE: [.doc/tmi.md](.doc/tmi.md) for some build/install instructions.
- Other: mingw-w64-mupdf & mingw-w64-mujs are compiled against tar packages via curl ~mupdf-v1.6
- PoDoFo is supported by official msys2 archive (so no longer needed here)

<!-- mujs: 872cef584db8fdb766f03e7cc5df8e6ea5c7ebdc -->

[mupdf-1.11]:https://github.com/ArtifexSoftware/mupdf/tree/1.11
[mupdf]:https://github.com/ArtifexSoftware/mupdf
[mujs]:https://github.com/ArtifexSoftware/mujs
[mujs-872cef5]:https://github.com/ArtifexSoftware/mujs/commit/872cef584db8fdb766f03e7cc5df8e6ea5c7ebdc
[jbig2dec]:https://github.com/ArtifexSoftware/jbig2dec
[mupdf-git-commit]:https://github.com/ArtifexSoftware/mujs/commit/4792d16f17b15a1eca3c2a9c856dc13fda1d23c5
[v1.0.1]:https://github.com/ArtifexSoftware/mujs/releases/tag/1.0.1
[mupdf-1.6]:http://mupdf.com/downloads/archive/mupdf-1.6-source.tar.gz
[mujs-9bc5fec.tar.gz]:http://git.ghostscript.com/?p=mujs.git;a=snapshot;h=9bc5fec0804381d59ef8dc62304ed6892fb7c4ca;sf=tgz "git.ghostscript.com"

**mupdf-1.6** built from tar.gz downloaded from `git.ghostscript.com`.  
*Am fairly certain this one can be appropriated to build static with some modification.*

| mingw-w64-* | SOURCE @ COMMIT| ~TAG | EMBEDS |
| -------- | -------- | -------- | -------- |
| mupdf     | [mupdf-1.6-source.tar.gz][mupdf-1.6]  | 1.6||
| mujs      | [mujs-9bc5fec.tar.gz]                 | *NA* ||

**mupdf-1.11** (shared) — built from github  
Compiles jbig2dec from `<pacage>/thirdparty/jbig2dec/`.  
All other libs are linked shared from existing `mingw-w64-*` packages.

| mingw-w64-* | SOURCE @ COMMIT| ~TAG | EMBEDS |
| -------- | -------- | -------- | -------- |
| mupdf-git | [mupdf] @ [4792d16][mupdf-git-commit] | [mupdf-1.11] | [jbig2dec]
| mujs-git  | [mujs] @ [872cef5][mujs-872cef5]      | *NA* ||