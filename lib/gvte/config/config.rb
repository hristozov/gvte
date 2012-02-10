module Gvte
  # Holds the configuration options (given either by a config file or
  # command-line options). Here we have some default values.
  class Config
    # The location of the config file.
    attr_accessor :config
    # The working directory for the newly created shells.
    attr_accessor :dir
    # The location of the command interpreter.
    attr_accessor :sh
    # A list with the keyboard shortcuts.
    attr_accessor :shortcuts

    def initialize
      @sh = "/bin/bash"
      @shortcuts = []
      @config = "~/.gvterc"
    end

    def ==(other_config)
      @sh  == other_config.sh &&
        @shortcuts == other_config.shortcuts &&
        @dir == other_config.dir &&
        @config == other_config.config
    end
  end
end
