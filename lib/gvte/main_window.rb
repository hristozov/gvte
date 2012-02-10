module Gvte
  class MainWindow < Gtk::Window
    def initialize(config)
      super("gvte")
      @keystroke_manager = KeystrokeManager.new(config.shortcuts)

      @nb = ShellNotebook.new(config)

      signal_connect("destroy", &quit)

      register_handlers

      signal_connect("key-press-event") do |widget, keyevent|
        keyval = keyevent.keyval
        state = keyevent.state
        @keystroke_manager.send_key(keyval,
                                    state.control_mask?,
                                    state.mod1_mask?,
                                    state.shift_mask?)
        false # false for success.
      end

      @nb.signal_connect("page-removed") do
        quit.call() if @nb.n_pages == 0
      end
      
      @nb.add_shell
      add(@nb)
    end

    def register_handlers
      @keystroke_manager.register_handler(Actions::ADD_TAB) { |k|
        @nb.add_shell
      }

      @keystroke_manager.register_handler(Actions::CLOSE_CURRENT_TAB) { |k|
        @nb.remove_current_shell
      }

      @keystroke_manager.register_handler(Actions::COPY) { |k|
        signal_emit_stop("key-press-event")
        @nb.copy
      }

      @keystroke_manager.register_handler(Actions::NEXT_TAB) { |k|
        signal_emit_stop("key-press-event")
        @nb.next_page
      }

      @keystroke_manager.register_handler(Actions::PASTE) { |k|
        signal_emit_stop("key-press-event")
        @nb.paste
      }

      @keystroke_manager.register_handler(Actions::PREVIOUS_TAB) { |k|
        signal_emit_stop("key-press-event")
        @nb.next_page
      }
    end

    def quit
      Proc.new do
        destroy
        Gtk.main_quit
      end
    end
  end
end

