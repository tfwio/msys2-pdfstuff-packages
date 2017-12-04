README
======

STARTING POINT
-----------------------------

My starting point was two-tiered where I had attempted to familiarize
with PKGBUILD scripts and GCC compilation 'standards' (through PKGBUILD
semantics), and eventually when autotools started making enough sense
to me, I started taking a look at the fontforge-builds project which
buils up a X11/Glib foundation with some build-scripting.

- Study existing GCC build configuration patterns
    - Auto-Tools Semantics
    - Package-Config Semantics
- See if we can 'absorb' a larger framework of packages under a PKGCONFIG
  build configuration...
- Prior to that (years ago) I had toyed around with compiling FFmpeg.

Now, when studying the fontforge-BUILD script, I'm not quite sure how far
I'd gotten or even if I was able to get everything set up and green-lighted
for running/installing and such...

Perhaps its time to take another look at font-forge and getting that ported
to pure (as can be) PKGCONFIG scripts.

SOME LINKS
-----------

1. https://project-renard.github.io/doc/development/meeting-log/posts/2016/05/03/windows-build-with-msys2/

   This helped generally point out some tools you might not have thought of such as the few entailed here...

2. https://metacpan.org/pod/ExtUtils::Liblist
   
   ExtUtils::Liblist - determine libraries to use and how to use them
   
   **Description**

   This utility takes a list of libraries in the form -llib1 -llib2 -llib3 and returns lines suitable for inclusion in an extension Makefile. Extra library paths may be included with the form -L/another/path this will affect the searches for all subsequent libraries.

3. ???

