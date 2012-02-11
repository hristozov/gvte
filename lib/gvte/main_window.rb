module Gvte
  class MainWindow < Gtk::Window
    def initialize(config)
      super("gvte")
      @keystroke_manager = GTKKeystrokeManagerFactory.get_manager(config, self)
      signal_connect("destroy", &quit)
      
      @nb = ShellNotebook.new(config, @keystroke_manager)
      @nb.add_shell
      @nb.signal_connect("page-removed") { 
        signal_emit("destroy") if @nb.n_pages == 0 
      }
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

