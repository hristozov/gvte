module Gvte
  class Term < Vte::Terminal
    def initialize(config)
      super()
      @config = config

      signal_connect("eof") {
        signal_emit("destroy")
      }

      pid = self.fork_command(@config.sh, nil, nil, @config.dir)
      $stderr.puts "Spawned shell (#{pid}) with options #{@config}"
    end
  end
end