gvte
====

A highly minimalistic VTE-based terminal emulator. Inspired by [evilvte](http://www.calno.com/evilvte/).

gvte relies on the native VTE libraries, so it will work only on UNIX-like systems with vte (a.k.a. libvte) installed (which itself depends on GTK).

The big feature list
--------------------
* Command line options for setting the shell location and the directory to spawn the shell in.
* Multiple tabs. Ctrl+T creates new tab ; Ctrl+W closes the current tab ; Ctrl+(Shift)+Tab selects the next (previous) tab.


Prerequisites
-------------
* gtk2
* vte
* trollop

TODO
----
* Add tests wherever possible.
* Customization of the VTE look - fonts/backgrounds/etc.
* Customization of the keyboard shortcuts.
* yakuake/guake mode :)
* Make gvte a gem :)
