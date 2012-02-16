module Gvte
  # Responsible for parsing the configuration file.
  class ConfigParser
    # Parses the text contents of the config file and puts them in the given
    # config object.
    def self.parse(text, config)
      config_hash = Psych::load(text)
      # we'll get a FalseClass with an empty config
      #return unless config_hash.is_a? Hash
      #config.shortcuts = keyboard_shortcuts(config_hash)
      #if shell = sh(config_hash) then
      #  config.sh = shell
      #end
      #if directory = dir(config_hash) then
      #  config.dir = directory
      #end
      
      return unless config_hash.is_a? Hash
      Config::variables.each { |variable|
        value = config_hash[variable.to_s]
        next unless value
        parsed_value = if self.respond_to?(variable) then
                         self.send(variable, value)
                       else
                         type = Config::variable_type variable
                         type = Object unless type
                         unless value.is_a? type
                           raise "Invalid type given for variable " + variable.to_s
                         end
                         value
                       end
        config.send(variable.to_s + "=", parsed_value)
      }
    end

    private
    def self.config_warning(text)
      STDERR.puts "WARNING: (config) " + text
    end

    def self.transparent(value)
      raise "transparent should be a true/false flag" unless value == !!value
      value
    end

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
