module Gvte
  class OptionsParser
    def self.parse_argv(argv)
      options = Trollop::options (ARGV) do
        version "gvte 0.0.0"
        banner <<BANNER
A highly minimalistic terminal emulator. Based on VTE.

  gvte [options]

where [options] are:
BANNER
      opt :sh, "Shell to use", :type=>String, :default=>"/bin/sh"
      opt :dir, "Directory to spawn the shell in", :type=>String
      opt :config, "Location of config file", :type=>String, :default="~/.gvterc"
      end
    end
  end
end

