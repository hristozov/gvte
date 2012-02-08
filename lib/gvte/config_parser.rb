module Gvte
  class ConfigParser
    def self.parse(text, config)
      config_hash = Psych::load(text)
      config.shortcuts = keyboard_shortcuts(config_hash)
    end

    private
    def self.keyboard_shortcuts(hash)
      hash['shortcuts'].map { |item|
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
