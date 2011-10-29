require './notebook.rb'

module Gvte
  class MainWindow < Gtk::Window
    def initialize(options)
      super("gvte")

      signal_connect("destroy", &quit)
      @nb = ShellNotebook.new(options)
      @nb.add_shell
      add(@nb)

      @ctrl = false
      @alt = false
      @shift = false

      signal_connect("key-press-event") do |widget, keyevent|
        keyval = keyevent.keyval
        @ctrl = true if keyval == Gdk::Keyval::GDK_Control_L or keyval == Gdk::Keyval::GDK_Control_R
        @alt = true if keyval == Gdk::Keyval::GDK_Alt_L or keyval == Gdk::Keyval::GDK_Alt_R
        @shift = true if keyval == Gdk::Keyval::GDK_Shift_L or keyval == Gdk::Keyval::GDK_Shift_R

        #ctrl + t
        if (keyval == 116 and @ctrl and not @alt)
          @nb.add_shell
        end

        #ctrl + w
        if (keyval == 119 and @ctrl and not @alt)
          @nb.remove_current_shell
        end

        #ctrl + tab / ctrl + shift + tab
        if (keyval == 65289 and @ctrl and not @alt)
          if @shift
            @nb.prev_page
          else
            @nb.next_page
          end
        end
      end

      signal_connect("key-release-event") do |widget, keyevent|
        keyval = keyevent.keyval
        @ctrl = false if keyval == Gdk::Keyval::GDK_Control_L or keyval == Gdk::Keyval::GDK_Control_R
        @alt = false if keyval == Gdk::Keyval::GDK_Alt_L or keyval == Gdk::Keyval::GDK_Alt_R
        @shift = false if keyval == Gdk::Keyval::GDK_Shift_L or keyval == Gdk::Keyval::GDK_Shift_R
      end

    end

    def quit
      Proc.new do
        destroy
        Gtk.main_quit
      end
    end
  end
end

