module Gvte
  # Holds the configuration options (given either by a config file or
  # command-line options). Here we have some default values.
  class Config
    CONFIG_VARIABLES = {
      # Column 1 -> The type of the argument. This is the type that should be
      # provided by the user (via command line options or config), but it can
      # be different after parsing the actual values. If nil, no type checking
      # will be done on parsing.
      # Column 2 -> The description of the argument.
      # Column 3 -> The default value. Will be ignored if not given.
      :background_color => [String , "The background color."],
      :background_image => [String , "The background image for the terminal."],
      :columns =>          [Integer, "The number of columns of newly created shells"],
      :config =>           [String , "The location of the config file.", "~/.gvterc"],
      :dir =>              [String , "The working directory for the newly created shells."],
      :font =>             [String , "A description of the font to be used (e.g., \"monospace 8\")"],
      :foreground_color => [String , "The foreground color for the terminal."],
      :rows =>             [Integer, "The number of rows of newly created shells."],
      :scrollback_lines => [Integer, "The size of the line buffer."],
      :sh =>               [String , "The location of the command interpreter.", "/bin/bash"],
      :shortcuts =>        [Array  , "A list with the keyboard shortcuts.", []],
      :termtype =>         [String , "The type of the terminal that will be emulated."],
      :transparent =>      [nil , "Whether the background should be transparent"]
    }

    def initialize
      # Creating the accessors
      metaclass = class << self; self; end;
      metaclass.send :attr_accessor, *CONFIG_VARIABLES.keys

      # Default values
      Config.variables.each { |k|
        default_value = Config.variable_default k
        instance_variable_set "@" + k.to_s, default_value if default_value
      }
    end

    # A list with the variables (array of symbols).
    def self.variables
      CONFIG_VARIABLES.keys
    end

    # Returns the type of a variable.
    def self.variable_type(variable_name)
      raise "No such variable #{variable_name.to_s}" unless CONFIG_VARIABLES[variable_name]
      CONFIG_VARIABLES[variable_name.to_sym][0]
    end

    # Returns the description of a variable.
    def self.variable_description(variable_name)
      raise "No such variable #{variable_name.to_s}" unless CONFIG_VARIABLES[variable_name]
      CONFIG_VARIABLES[variable_name.to_sym][1]
    end

    # Returns the default value for a given variable.
    def self.variable_default(variable_name)
      raise "No such variable #{variable_name.to_s}" unless CONFIG_VARIABLES[variable_name]
      CONFIG_VARIABLES[variable_name.to_sym][2]
    end

    # Creates a copy of the current config variable-by-variable.
    def copy
      result = Config.new
      Config.variables.each { |v|
        our_value = instance_variable_get("@" + v.to_s)
        result.send(v.to_s + "=", our_value)
      }
      result
    end

    # Compares config objects variable-by-variable.
    def ==(other_config)
      Config.variables.map { |v|
        instance_variable_get("@" + v.to_s) == other_config.send(v)
      }.inject(true, :&)
    end

    # "Merges" the current config with the given. This means that if the other
    # config has non-empty and non-default variables, they should override the
    # ones from the current instance. This has no side-effects, the method
    # returns a copy with the new configuration.
    def +(other_config)
      result = self.copy
      Config.variables.each { |v|
        other_value = other_config.send(v.to_s)
        next unless other_value != nil and other_value != Config.variable_default(v)
        result.send(v.to_s + "=", other_value)
      }
      result
    end
  end
end
