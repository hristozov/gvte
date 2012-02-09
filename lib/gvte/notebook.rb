module Gvte
  class ShellNotebook < Gtk::Notebook
    def initialize config
      super()
      @config = config
      @bolded_tabs = {}
      signal_connect("page-added", &toggle_tab_bar)
      signal_connect("page-removed", &toggle_tab_bar)
      signal_connect("switch-page", &handle_switch_page)
    end

    def add_shell(move_focus=true)
      term = Vte::Terminal.new().show_all
      term.signal_connect("window-title-changed", &update_label(term))
      term.signal_connect("eof", &handle_eof(term))
      term.signal_connect("contents-changed", &handle_contents_changed(term))
      pid = term.fork_command(@config.sh, nil, nil, @config.dir)

      append_page term
      self.page = page_num term if move_focus
      set_tab_label_text term, @config.sh

      $stderr.puts "Spawned shell (#{pid}) with options #{@config}"
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

