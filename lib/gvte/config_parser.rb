module Gvte
  class ConfigParser
    def self.parse(text, config)
      config_hash = Psych::load(text)
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
      return [] if not shortcuts
      if not shortcuts.is_a? Array then
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
      return nil if not sh
      if not sh.is_a? String then
        config_warning("'sh' should be a string. Ignoring the config directive.")
        return nil
      end
      sh
    end

    def self.dir(hash)
      dir = hash['dir']
      return nil if not dir
      if not dir.is_a? String then
        config_warning("'dir' should be a string. Ignoring the config directive.")
        return nil
      end
      dir
    end
  end
end
