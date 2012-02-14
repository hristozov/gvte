module Gvte
  # Holds the configuration options (given either by a config file or
  # command-line options). Here we have some default values.
  class Config
    # The background color.
    attr_accessor :background_color
    # The background image for the terminal.
    attr_accessor :background_image
    # The location of the config file.
    attr_accessor :config
    # The working directory for the newly created shells.
    attr_accessor :dir
    # A description of the font to be used (e.g., "monospace 8")
    attr_accessor :font
    # The foreground color for the terminal.
    attr_accessor :foreground_color
    # The size of the line buffer.
    attr_accessor :scrollback_lines
    # The location of the command interpreter.
    attr_accessor :sh
    # A list with the keyboard shortcuts.
    attr_accessor :shortcuts
    # The type of the terminal that will be emulated.
    attr_accessor :termtype

    def initialize
      @sh = "/bin/bash"
      @shortcuts = []
      @config = "~/.gvterc"
    end

    def ==(other_config)
      @background_color == other_config.background_color &&
        @background_image == other_config.background_image &&
        @config == other_config.config &&
        @dir == other_config.dir &&
        @font == other_config.font &&
        @foreground_color == other_config.foreground_color &&
        @scrollback_lines == other_config.scrollback_lines &&
        @sh  == other_config.sh &&
        @shortcuts == other_config.shortcuts &&
        @termtype == other_config.termtype
    end
  end
end
