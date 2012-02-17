module Gvte
  # Responsible for constructing a config object from the command-line
  # arguments and the contents of a config file, if it exists.
  class ConfigBuilder
    # Initializes the builder with the given command-line options.
    def initialize(argv)
      @argv = argv
    end

    # Returns the config object for the current builder instance.
    def config
      result = Gvte::Config.new
      OptionsParser::parse(@argv, result)
      config_file = result.config
      if config_file and File.exists?(config_file) and File.readable?(config_file) then
        config_file_options = Gvte::Config.new
        ConfigParser::parse(File.open(config_file).read, config_file_options)
        # Override the options in the config file with the ones from the command
        # line.
        result = config_file_options + result
      end
      result
    end
  end
end
