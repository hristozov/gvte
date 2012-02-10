gvte
====

A minimalistic VTE-based terminal emulator. Inspired by [evilvte](http://www.calno.com/evilvte/).

The bad sides
-------------
* It is an univeristy project in alpha phase.
* Fat dependencies. gvte relies on the native VTE libraries, so it will work only on UNIX-like systems with vte (a.k.a. libvte) installed (which itself depends on GTK+).
* Windows? Theoretically possible, but only under Cygwin. :)

The big feature list
--------------------
* Command line options for setting the shell location and the directory to spawn the shell in.
* Multiple tabs. Ctrl+T creates new tab ; Ctrl+W closes the current tab ; Ctrl+(Shift)+Tab selects the next (previous) tab.

Ruby prerequisites
-------------
* gtk2
* vte
* trollop

Contributing
------------
Pull requests are welcome. :)

TODO
----
* Add tests wherever possible.
* Customization of the VTE look - fonts/backgrounds/etc.
* Accept ASCII characters for keyboard shortcuts in the config.
* yakuake/guake mode :)
* Make gvte a gem :)
