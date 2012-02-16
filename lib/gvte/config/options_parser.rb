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
        Config::variables.each { |variable|
          description = Config::variable_description variable
          default = Config::variable_default variable
          type = Config::variable_type variable
          opts = {}
          next unless [nil, String, Integer].index(type) != nil
          opts[:type] = type if type != nil
          opts[:default] = default if default != nil
          opt variable, description, opts
        }
      end
      # TODO: remove the ignore_vars lunacy
      ignore_vars = [:background_color, :foreground_color, :keyboard_shortcuts]
      (Config::variables - ignore_vars).each { |variable|
        if (options[(variable.to_s + "_given").to_sym]) then
          config.send(variable.to_s + "=", options[variable])
        end
      }
      config.background_color = ColorUtil::parse_hex_color options.bgcolor if options.bgcolor_given
      config.foreground_color = ColorUtil::parse_hex_color options.fgcolor if options.fgcolor_given
    end
  end
end

