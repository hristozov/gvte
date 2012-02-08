module Gvte
  class OptionsParser
    def self.parse(argv, config)
      options = Trollop::options (argv) do
        version "gvte 0.0.0"
        banner <<BANNER
A highly minimalistic terminal emulator. Based on VTE.

  gvte [options]

where [options] are:
BANNER
        opt :sh, "Shell to use", :type=>String, :default=>"/bin/sh"
        opt :dir, "Directory to spawn the shell in", :type=>String
        opt :config, "Location of config file", :type=>String, :default=>"~/.gvterc"
      end
      config.sh = options.sh
      config.dir = options.dir
      config.config = options.config
    end
  end
end

