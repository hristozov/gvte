module Gvte
  # Responsible for parsing the command-line arguments.
  class OptionsParser
    # Parses the arguments given in the argv given and puts them in the config
    # object given.
    def self.parse(argv, config)
      options = Trollop::options (argv) do
        version "gvte 0.0.0"
        banner <<BANNER
A highly minimalistic terminal emulator. Based on VTE.

  gvte [options]

where [options] are:
BANNER
        opt :sh, "Shell to use", :type=>String, :default=>Config.new.sh
        opt :dir, "Directory to spawn the shell in", :type=>String
        opt :config, "Location of config file", :type=>String, :default=>Config.new.config
      end
      config.sh = options.sh if options.sh_given
      config.dir = options.dir if options.dir_given
      config.config = options.config if options.config_given
    end
  end
end

