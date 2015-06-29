


ON LOCAL GPG KEY/SIG GENERATION
================================

Those intrested in creating a 'official-like' repository may be curious about the "Key-Master" system used...

I had only created my first GPG-key the other day for the first time.
No knowledge of using and/setting up a keyring can be obtained here, but perhaps the following will point those of you interested into the proper direction...

- **GPG** key/sig lookups
    - List gpg keys: `gpg --list-keys`
    - List gpg sigs: `gpg --list-sigs`
    - List pacman-keys: `pacman-key --list-keys` (pacman)
    - List pacman-sigs: `pacman-key --list-sigs` (pacman)
- Generate and sign a key.  Once you create the key, it has been added to a local gpg-database.
    - **Generate**: `gpg --gen-key` will walk you through the creation of a key.
    - **Sign**: `gpg --sign-key ["key-name"]`
    - **Export**: `gpg --export [*key-name*]`
- Import to pacman: (me no remember--it was easy)
    - Once you import a key, it may be necessary to refresh pacman's key/sig database.
    - see `pacman-key --help`
- Keys can be added one or both of two ways once added to pacman 'trust'.
    1. `makepkg-mingw64 -L --force --key "[*key-name*]"`
    2. `repo-add -s --key [*key-signature*] ../packages/${group}/${larch}/${dbname}${tag}.db.tar.gz ../packages/${group}/${larch}/*.pkg.tar.xz`
- Make changes to you `/etc/pacman.conf` (instruction therein) aswellas (any) added or imported `/etc/pacman.d/[file]`.

