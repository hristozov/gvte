module Gvte
  class MainWindow < Gtk::Window
    def initialize(config)
      super("gvte")

      @ctrl = false
      @alt = false
      @shift = false

      @nb = ShellNotebook.new(config)

      signal_connect("destroy", &quit)
      
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
          signal_emit_stop("key-press-event")
          if @shift
            @nb.prev_page
          else
            @nb.next_page
          end
        end

        #ctrl + shift + c
        if (keyval == 67 and @ctrl and @shift and not @alt)
          signal_emit_stop("key-press-event")
          @nb.copy
        end

        #ctrl + shift + v
        if (keyval == 86 and @ctrl and @shift and not @alt)
          signal_emit_stop("key-press-event")
          @nb.paste
        end
      end

      signal_connect("key-release-event") do |widget, keyevent|
        keyval = keyevent.keyval
        @ctrl = false if keyval == Gdk::Keyval::GDK_Control_L or keyval == Gdk::Keyval::GDK_Control_R
        @alt = false if keyval == Gdk::Keyval::GDK_Alt_L or keyval == Gdk::Keyval::GDK_Alt_R
        @shift = false if keyval == Gdk::Keyval::GDK_Shift_L or keyval == Gdk::Keyval::GDK_Shift_R
      end

      @nb.signal_connect("page-removed") do
        quit.call() if @nb.n_pages == 0
      end
      
      @nb.add_shell
      add(@nb)


    end

    def quit
      Proc.new do
        destroy
        Gtk.main_quit
      end
    end
  end
end

