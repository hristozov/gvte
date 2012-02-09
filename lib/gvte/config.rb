module Gvte
  class Config
    attr_accessor :shortcuts, :sh, :dir, :config

    def initialize
      @sh = "/bin/sh"
      @shortcuts = []
      @config = "~/.gvterc"
    end
  end
end
