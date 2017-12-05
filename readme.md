msys2-pdfstuff
==============

PDF related `PKGBUILD` scripts for msys2

mupdf-1.6 (mujs+mupdf), mupdf-1.11 (mujs-git+mupdf-git)

- SEE: [**.doc/readme.md**](.doc/readme.md) for some build/install instructions.
- PoDoFo is supported by official msys2 archive (so no longer needed here)
- this readme is WIP ;)

<!-- 

**mupdf-1.6** — built from `.tar.gz` on 

| mingw-w64-* | SOURCE                    | COMMIT     | ~TAG         | EMBEDS   |
| --------    | --------                  |--------    | --------     | -------- |
| mujs-git    | [mujs-aba272a.tar.gz]     | @[aba272a] | *NA* ||
| mupdf-git   | [mupdf-1.6-source.tar.gz] | @[9268b59] | [mupdf-1.6-git] | *to be determined* |

**mupdf-1.11** (shared) — 

| mingw-w64-* | SOURCE    | COMMIT     | ~TAG         | EMBEDS   |
| --------    | --------  |--------    | --------     | -------- |
| mujs-git     | [mujs]   | @[872cef5]  | *NA*         ||
| mupdf-git    | [mupdf]  | @[4792d16]  | [mupdf-1.11] | [jbig2dec]
-->

[mupdf]:https://github.com/ArtifexSoftware/mupdf
[mujs]:https://github.com/ArtifexSoftware/mujs
[4792d16]:https://github.com/ArtifexSoftware/mujs/commit/4792d16f17b15a1eca3c2a9c856dc13fda1d23c5
[mujs-aba272a.tar.gz]: http://git.ghostscript.com/?p=mujs.git;a=snapshot;h=aba272ac959329476ce73bc7d69d14ad7779c754;sf=tgz
[mupdf-1.6-git]:https://github.com/ArtifexSoftware/mupdf/tree/1.6
[mupdf-1.6-source.tar.gz]:http://mupdf.com/downloads/archive/mupdf-1.6-source.tar.gz
[mupdf-1.11]:https://github.com/ArtifexSoftware/mupdf/tree/1.11
[9268b59]:https://github.com/ArtifexSoftware/mupdf/tree/9268b59ffcb5e5a276324d692c9d63c0e2f1e3ce
[872cef5]:https://github.com/ArtifexSoftware/mujs/commit/872cef584db8fdb766f03e7cc5df8e6ea5c7ebdc
[jbig2dec]:https://github.com/ArtifexSoftware/jbig2dec
[v1.0.1]:https://github.com/ArtifexSoftware/mujs/releases/tag/1.0.1


<!--
CURL download source package: `mujs-aba272a.tar.gz`  
*isn't `mingw-w64-*` packages*
```bash
# this is the mujs source package
curl -O -J -L 'http://git.ghostscript.com/?p=mujs.git;a=snapshot;h= aba272ac959329476ce73bc7d69d14ad7779c754;sf=tgz'
```
-->
