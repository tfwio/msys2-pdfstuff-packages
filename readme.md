msys2-pdfstuff
==============
a few un-official PDF related `PKGBUILD` scripts for msys2

<!-- mujs: 872cef584db8fdb766f03e7cc5df8e6ea5c7ebdc -->

[mupdf-1.11]:https://github.com/ArtifexSoftware/mupdf/tree/1.11
[mupdf]:https://github.com/ArtifexSoftware/mupdf
[mujs]:https://github.com/ArtifexSoftware/mujs
[mujs-872cef5]:https://github.com/ArtifexSoftware/mujs/commit/872cef584db8fdb766f03e7cc5df8e6ea5c7ebdc
[jbig2dec]:https://github.com/ArtifexSoftware/jbig2dec
[mupdf-git-commit]:https://github.com/ArtifexSoftware/mujs/commit/4792d16f17b15a1eca3c2a9c856dc13fda1d23c5
[v1.0.1]:https://github.com/ArtifexSoftware/mujs/releases/tag/1.0.1


| mingw-w64-* | SOURCE @ COMMIT| ~TAG | EMBEDS |
| -------- | -------- | -------- | -------- |
| mujs-git     | [mujs] @ [872cef5][mujs-872cef5] | ~[v1.0.1](https://github.com/ArtifexSoftware/mujs/releases/tag/1.0.1) ||
| mupdf-git | [mupdf] @ [4792d16][mupdf-git-commit] | [mupdf-1.11] | [jbig2dec]


- SEE: [.doc/tmi.md](.doc/tmi.md) for some build/install instructions.
- Other: mingw-w64-mupdf & mingw-w64-mujs are compiled against tar packages via curl ~mupdf-v1.8
- PoDoFo is supported by official msys2 archive (so no longer needed here)