module Gvte
  # Responsible for parsing the command-line arguments.
  class OptionsParser
    # Parses the arguments given in the argv given and puts them in the config
    # object given.
    def self.parse(argv, config)
      options = Trollop::options(argv) do
        version "gvte 0.0.0"
        banner <<BANNER
A highly minimalistic terminal emulator. Based on VTE.

  gvte [options]

where [options] are:
BANNER
        opt :bgcolor, "Background color", :type=>String
        opt :bgimage, "Background image", :type=>String
        opt :config, "Location of config file", :type=>String, :default=>Config.new.config
        opt :dir, "Directory to spawn the shell in", :type=>String
        opt :fgcolor, "Foreground color", :type=>String
        opt :font, "Font to be used", :type=>String
        opt :scrollback, "Scrollback size", :type=>Integer
        opt :sh, "Shell to use", :type=>String, :default=>Config.new.sh
        opt :term, "Terminal type to use", :type=>String
      end
      config.background_color = ColorUtil::parse_hex_color options.bgcolor if options.bgcolor_given
      config.background_image = options.bgimage if options.bgimage_given
      config.config = options.config if options.config_given
      config.dir = options.dir if options.dir_given
      config.foreground_color = ColorUtil::parse_hex_color options.fgcolor if options.fgcolor_given
      config.font = options.font if options.font_given
      config.scrollback_lines = options.scrollback if options.scrollback_given
      config.sh = options.sh if options.sh_given
      config.termtype = options.font if options.term_given
    end
  end
end

