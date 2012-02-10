module Gvte
  # Responsible for parsing the configuration file.
  class ConfigParser
    # Parses the text contents of the config file and puts them in the given
    # config object.
    def self.parse(text, config)
      config_hash = Psych::load(text)
      # we'll get a FalseClass with an empty config
      return unless config_hash.is_a? Hash
      config.shortcuts = keyboard_shortcuts(config_hash)
      if shell = sh(config_hash) then
        config.sh = shell
      end
      if directory = dir(config_hash) then
        config.dir = directory
      end
    end

    private
    def self.config_warning(text)
      STDERR.puts "WARNING: (config) " + text
    end

    def self.keyboard_shortcuts(hash)
      shortcuts = hash['shortcuts']
      return [] unless shortcuts
      unless shortcuts.is_a? Array then
        config_warning("'shortcuts' should be a list. Ignoring the config directive.")
        return []
      end
      shortcuts.map { |item|
        KeyboardShortcutFactory.get_shortcut(
          item['action'],
          item['key'],
          item['ctrl'],
          item['alt'],
          item['shift'])
      }
    end

    def self.sh(hash)
      sh = hash['sh']
      return nil unless sh
      unless sh.is_a? String then
        config_warning("'sh' should be a string. Ignoring the config directive.")
        return nil
      end
      sh
    end

    def self.dir(hash)
      dir = hash['dir']
      return nil unless dir
      unless dir.is_a? String then
        config_warning("'dir' should be a string. Ignoring the config directive.")
        return nil
      end
      dir
    end
  end
end
