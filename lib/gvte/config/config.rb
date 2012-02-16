module Gvte
  # Holds the configuration options (given either by a config file or
  # command-line options). Here we have some default values.
  class Config
    CONFIG_VARIABLES = {
      :background_color => [String , "The background color. An array with the three RGB values."],
      :background_image => [String , "The background image for the terminal."],
      :columns =>          [Integer, "The number of columns of newly created shells"],
      :config =>           [String , "The location of the config file.", "~/.gvterc"],
      :dir =>              [String , "The working directory for the newly created shells."],
      :font =>             [String , "A description of the font to be used (e.g., \"monospace 8\")"],
      :foreground_color => [String , "The foreground color for the terminal. An array with the three RGB values."],
      :rows =>             [Integer, "The number of rows of newly created shells."],
      :scrollback_lines => [Integer, "The size of the line buffer."],
      :sh =>               [String , "The location of the command interpreter.", "/bin/bash"],
      :shortcuts =>        [Array  , "A list with the keyboard shortcuts.", []],
      :termtype =>         [String , "The type of the terminal that will be emulated."],
      :transparent =>      [Object , "Whether the background should be transparent"]
    }

    def initialize
      # Creating the accessors
      metaclass = class << self; self; end;
      metaclass.send :attr_accessor, *CONFIG_VARIABLES.keys

      # Default values
      CONFIG_VARIABLES.each_key { |k|
        default_value = CONFIG_VARIABLES[k][2]
        instance_variable_set("@"+k.to_s, default_value) if default_value != nil
      }
    end

    def self.each_variable
      CONFIG_VARIABLES.each
    end

    def self.variables
      CONFIG_VARIABLES.keys
    end

    def ==(other_config)
      @background_color == other_config.background_color &&
        @background_image == other_config.background_image &&
        @columns == other_config.columns &&
        @config == other_config.config &&
        @dir == other_config.dir &&
        @font == other_config.font &&
        @foreground_color == other_config.foreground_color &&
        @rows == other_config.rows &&
        @scrollback_lines == other_config.scrollback_lines &&
        @sh  == other_config.sh &&
        @shortcuts == other_config.shortcuts &&
        @termtype == other_config.termtype &&
        @transparent == other_config.transparent
    end
  end
end
