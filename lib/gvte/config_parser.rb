module Gvte
  class ConfigParser
    def initialize(text)
      @config_hash = Psych::load(text)
    end

    def config
      #@config_hash
      config = Gvte::Config.new
      config.shortcuts = keyboard_shortcuts
      config
    end

    private
    def keyboard_shortcuts
      @config_hash['shortcuts'].map { |item|
        Gvte::KeyboardShortcutFactory.get_shortcut(
          item['action'],
          item['key'],
          item['ctrl'],
          item['alt'],
          item['shift'])
      }
    end
  end
end
