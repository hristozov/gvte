gvte
====

A minimalistic VTE-based terminal emulator. Inspired by [evilvte](http://www.calno.com/evilvte/).

Goal
-----
Have your job done without unnecessary distractions and the need to have a PhD in Computer Science to configure your terminal emulator. The latter is not a joke - in order to customize *evilvte* you have to change some poorly-documented "#define"-s in the source code and recompile it.

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
* Customization of the keyboard shortcuts.
* yakuake/guake mode :)
* Make gvte a gem :)
