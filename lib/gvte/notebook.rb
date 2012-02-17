module Gvte
  class ShellNotebook < Gtk::Notebook
    def initialize(config, main_window, keystroke_manager)
      super()
      @config = config
      @bolded_tabs = {}
      @keystroke_manager = keystroke_manager
      @main_window = main_window
      register_handlers
      signal_connect("page-added", &toggle_tab_bar)
      signal_connect("page-removed", &toggle_tab_bar)
      signal_connect("switch-page", &handle_switch_page)
    end

    def register_handlers
      @keystroke_manager.register_handler(Actions::ADD_TAB) { |k|
        add_shell
      }

      @keystroke_manager.register_handler(Actions::CLOSE_CURRENT_TAB) { |k|
        remove_current_shell
      }

      @keystroke_manager.register_handler(Actions::COPY) { |k|
        @main_window.signal_emit_stop("key-press-event")
        copy
      }

      (1..10).each { |n|
        action = Actions.const_get("GO_TO_TAB_#{n}".to_sym)
        @keystroke_manager.register_handler(action) { |k|
          @main_window.signal_emit_stop("key-press-event")
          if n <= n_pages
            self.page = n-1
          end
        }
      }

      @keystroke_manager.register_handler(Actions::NEXT_TAB) { |k|
        @main_window.signal_emit_stop("key-press-event")
        next_page
      }

      @keystroke_manager.register_handler(Actions::PASTE) { |k|
        @main_window.signal_emit_stop("key-press-event")
        paste
      }

      @keystroke_manager.register_handler(Actions::PREVIOUS_TAB) { |k|
        @main_window.signal_emit_stop("key-press-event")
        prev_page
      }

      @keystroke_manager.register_handler(Actions::RESET) { |k|
        current_term.reset(true, true)
      }
    end

    def add_shell(move_focus=true)
      term = Term.new(@config).show_all
      term.signal_connect("window-title-changed", &update_label(term))
      term.signal_connect("eof", &handle_eof(term))
      term.signal_connect("contents-changed", &handle_contents_changed(term))

      append_page term
      self.page = page_num term if move_focus
      set_tab_label_text term, @config.sh
    end

    def remove_current_shell
      remove_page page
    end

    def update_label term
      Proc.new do
        title = term.window_title
        if title != nil
          if @bolded_tabs[term]
            (get_tab_label term).set_markup "<b>#{title}</b>"
          else
            set_tab_label_text term, title
          end
        end
      end
    end

    def handle_eof term
      Proc.new do
        remove_page(page_num term)
      end
    end

    def handle_contents_changed term
      Proc.new do
        if term != current_term
          @bolded_tabs[term] = true
          update_label term
        end
      end
    end

    def handle_switch_page
      Proc.new do
        term = current_term
        @bolded_tabs[term] = nil
        #update_label(current_term).call()
        pro = update_label(term)
        pro.call()
      end
    end

    def toggle_tab_bar
      Proc.new do
        self.show_tabs = n_pages > 1
      end
    end

    def next_page
      self.page = ((page + 1)%n_pages)
    end

    def prev_page
      self.page = ((page - 1)%n_pages)
    end

    def current_term
      self.get_nth_page(page)
    end

    def copy
      #TODO: sanity checks
      current_term.copy_clipboard
    end

    def paste
      current_term.paste_clipboard
    end
  end
end

