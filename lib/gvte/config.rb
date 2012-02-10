module Gvte
  class Config
    attr_accessor :shortcuts, :sh, :dir, :config

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
