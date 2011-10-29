module Gvte
  class ShellNotebook < Gtk::Notebook
    def initialize options
      super()
      @options = options
      signal_connect("page-added", &toggle_tab_bar)
      signal_connect("page-removed", &toggle_tab_bar)
    end

    def add_shell(move_focus=true)
      term = Vte::Terminal.new().show_all
      term.signal_connect("window-title-changed", &update_tab_title(term))
      term.signal_connect("eof", &handle_eof(term))
      pid = term.fork_command(@options[:sh], nil, nil, @options[:dir])

      append_page term
      self.page = page_num term if move_focus
      set_tab_label_text(term, @options[:sh])

      $stderr.puts "Spawned shell (#{pid}) with options #{@options}"
    end

    def remove_current_shell
      remove_page page
    end

    def update_tab_title term
      Proc.new do
        set_tab_label_text(term,term.window_title)
      end
    end

    def handle_eof term
      Proc.new do
        remove_page(page_num term)
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
  end
end

