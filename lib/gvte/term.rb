module Gvte
  class Term < Vte::Terminal
    def initialize(config)
      super()
      @config = config

      pid = self.fork_command(@config.sh, nil, nil, @config.dir)
      $stderr.puts "Spawned shell (#{pid}) with options #{@config}"

      set_appearance_settings
    end

    def set_appearance_settings
      if @config.foreground_color != nil then
        color = Gdk::Color.new *@config.foreground_color
        color_foreground = color
      end
      if @config.background_color != nil then
        bgcolor = Gdk::Color.new *@config.background_color
        color_background = bgcolor
      end
      set_scrollback_lines @config.scrollback_lines if @config.scrollback_lines != nil
      set_font @config.font if @config.font != nil
      set_emulation @config.termtype if @config.termtype != nil
    end
  end
end
