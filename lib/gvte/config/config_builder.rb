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
      options = Gvte::Config.new()
      OptionsParser::parse(@argv, options)
      #XXX: check if the config file is readable
      if options.config != nil and File.exists?(options.config) then
        ConfigParser::parse(File.open(options.config).read, options)
      end
      options
    end
  end
end
