module Gvte
  # Responsible for parsing the configuration file.
  class ConfigParser
    # Parses the text contents of the config file and puts them in the given
    # config object. If a class method here is named "foo", the variable named
    # "foo" will be passed to this method instead of parsing it automatically.
    def self.parse(text, config)
      config_hash = Psych::load(text)
      return unless config_hash.is_a? Hash
     
      # Here we'll parse all the variables that do not have a parsing method
      # defined below. If it exists, we'll invoke it.
      Config::variables.each { |variable|
        value = config_hash[variable.to_s]
        next unless value # It does not exist.
        parsed_value = if self.respond_to?(variable) then
                         self.send(variable, value)
                       else
                         type = Config::variable_type variable
                         type = Object unless type # Defaulting to Object.
                         unless value.is_a? type # The type is not "appropriate".
                           raise "Invalid type (#{value.class}) given for variable " + variable.to_s
                         end
                         value
                       end
        # Time for setting the actual value in the config object.
        config.send(variable.to_s + "=", parsed_value)
      }
    end

    private
    # Outputs a warning on the STDERR. Deprecated.
    def self.config_warning(text)
      STDERR.puts "WARNING: (config) " + text
    end

    # Parses the "transparent" flag. It does not a type defined, so can't be
    # handled manually.
    def self.transparent(value)
      raise "transparent should be a true/false flag" unless value == !!value
      value
    end

    # The background_color needs some additional parsing, just copying it
    # is not enough.
    def self.background_color(value)
      ColorUtil::parse_hex_color value
    end

    # We do exactly the same parsing for foreground_color.
    class << self; alias :foreground_color :background_color; end

    # The shortcuts should be created with a factory, so we need to handle
    # them separately.
    def self.shortcuts(shortcuts)
      return [] unless shortcuts
      raise "shortcuts should be a list" unless shortcuts.is_a? Array
      shortcuts.map { |item|
        KeyboardShortcutFactory.get_shortcut(
          item['action'],
          item['key'],
          item['ctrl'],
          item['alt'],
          item['shift'])
      }
    end
  end
end
