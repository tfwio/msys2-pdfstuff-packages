MSYS2 repository sandbox for PDF 'stuff'
==============

Package (study) scripts for MinGW-w64 targets to build under MSYS2.

    20150629 : INITIAL SCRIPT DUMP

      THE SCRIPTS STILL REQUIRE A SMALL AMOUNT OF TESTING UNTIL THE CONTENT
      HERE IS 'RELEASE' WORTHY.
      
      MOSTLY, THE PROJECT IS LACKING ADEQUATE DOCUMENTATION (INSTRUCTION).
      
      THIS NOTE WILL BE REMOVED WHEN ALL IS WELL ;)

> **Be aware**: Is instruction for getting started with *experimental* package repository.  However insightful, this source and documentation is not intended as reference for archlinux or MSYS2---provided as-is in the hope that it may be useful.

> This repository is not yet, however intends to be "NewB" friendly---and perhaps may be one way to get to know msys2-package build-script development---some time in the future.

Always read official source documentation,
------------------------------------------

...and note that there are several build scripts to learn from in the official [package-script repository](https://github.com/Alexpux/MINGW-packages).

- http://msys2.github.io/ (download installer here)
- https://sf.net/p/msys2
- https://wiki.archlinux.org/index.php/PKGBUILD
- https://wiki.archlinux.org/index.php/makepkg
- https://github.com/Alexpux/MINGW-packages
- https://github.com/Alexpux/MSYS2-packages (msys2 shell related build scripts)

BUILD SCRIPTS ARE FOR
-----------------------

...using msys2 to build the following:

- https://podofo.sourceforge.net (svn r1673)
- http://mupdf.com/ (v1.6)
- https://github.com/xiangxw/mupdf-qt (sha1: `f61a5f7d88dd9ca728d47cebe6ac790f0c1c43ba`)


NOTE
-----------------------

- ALL THESE PACKAGES HAVE BEEN TESTED AND ARE WORKING.  I have yet to test from a new, bare msys2 installation (hence the documentation here is lacking).  For now, if you run into an issue,
    1. figure out what dependency package is missing and install it + try again.
    2. these scripts are only known to be working for **i686** (32-bit) binary target hosts---perhaps you are targeting `x86_64`?
- This project does not release packages or binaries---just these few build scripts.
- This repository contains several PDF related build scripts from my personal collection of 'MSYS2-packages' (build scripts); Or, in other words: from a larger set of build scripts.
    - Last phase of development on these build scripts was aimed at building FontForge under MSYS2 using such (`MAKEPKG`/`PKGBUILD`) build-scripts, with a great deal of help provided by the fontforge-builds project's sources and 'footprints'---only targeting x86,..
    - PDF-related scripts were recently 'refurbished' and migrated to a separate workspace, here.
    - In this (source-dump revision) repository, you will find several artifacts which have not yet been consolidated out, particularly in the scripts contained in the `./common` directory.
- **The build process here is personalized slightly**--- I've added two scripts in my `/usr/bin/` copied from `makepkg-mingw` named `makepkg-mingw32` and `makepkg-mingw64` where each of the scripts builds binaries for either (only) targeting 32-bit binaries (which I do often) or 64-bit (not so often).  Using these scripts rather then then original `makepkg-mingw` can be handy when making `PKGBUILD` scripts and targeting only x86 (as an example).
-   The particular build here of MuPDF links MuJS (as opposed to linking NodeJS for javascript support).

HOWTO
=============

TODO: I still need to provide *adequate* step-by-step instructions...

[temporary instructions until more time can be put to this...]

KNOWN PACKAGE DEPENDENCIES
---------------------------

These are some of the package dependencies worth noting.

* cmake
* cppunit
* curl
* freetype
* gcc
* git
* libjpeg
* libpng
* libtiff
* lua
* make (or particularly `mingw32/mingw-w64-i686-make`)
* openjpeg2
* openssl
* patch
* pkg-config
* qt5
* svn
* clib

GETTING STARTED
-------------------

- Install MSYS2
- Either install GIT using pacman under msys2 or the one you may have installed in windows, you may want to clone this repository&mdash;so that you can then place the two files found in this repo: `./common/makepkg-artifacts`.   Copy the two files into your (starting from installation path) `./usr/bin` directory.
    -   `makepkg-mingw32`
    -   `makepkg-mingw64`
-   Load up **msys shell** (command-prompt)
-   Using Pacman, install all those dependencies that you'll need.
    -   I would start with the main Qt5 package, as this installs just about all the dependencies you'll need---unless you're merely interested in building only podofo and mupdf (without qt-mupdf).
    -   Dependencies I can think off the top of my mind: `git, svn, qt5, patch`.
    -   There will be much more specific instructions and dependencies listed here in the future.


TO BUILD THE PACKAGES
---------------------

To build a package for msys2, you need to navigate to a build-directory (a directory containing a `PKGBUILD` script), and run `makepkg-mingw32`.

The build script (makepkg-...) should inform you if you are missing any particular dependencies.  If all fails, read into the project's (home) documentation or makefiles to see what dependencies have not yet been included.

For mupdf-qt, you need to build in proper sequence: (1) mujs, (1.1) install-mujs, (2) mupdf, (2.1) install mupdf *(see below)*, (3) mupdf-qt, (3.1) install it.

-   load up **msys-mingw32 shell** (command-prompt)
-   Navigate to the project's directory you intend to build: EG: `cd ~/msys2-pdfstuff-packages/[project-name]` (if you git-cloned into your home directory)
-   execute: `makepkg-mingw32` or if you are attempting to rebuild, `makepkg-mingw32 --force`.  **If there was an error reported or dependency missing**---should be fairly obvious.
    -   Install any missing packages
    -   try again

TO INSTALL A PACKAGE
---------------------------------

Note that packages always have the extension `pkg.tar.xz`.

```bash
# first of course navigate to the directory your package is in
pacman -U [yourpackage].pkg.tar.xz

# (trusting) if only one *.pkg.tar.xz is in the current directory
pacman -U *.pkg.tar.xz
```

THIS IS NOT 'OFFICIAL', CLAIMING NO PARTICULAR LICENSE OR AFFILIATION NOR OWNERSHIP OF ANY OF THE RELATED PROJECTS, TEAMS OR SOURCE-CODE.  ANY BINARIES AND/OR SOURCES SUSTAIN THEIR RESPECTIVE LICENCES AS SUPPLIED BY THE OWNING PARTIES AND/OR DEVELOPMENT TEAM(S).  USE AT YOUR OWN RISK.
