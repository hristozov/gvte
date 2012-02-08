module Gvte
  class ConfigBuilder
    def initialize(argv)
      @argv = argv
    end

    def config
      options = Gvte::Config.new()
      OptionsParser::parse(@argv, options)
      #XXX: check if the config file is readable
      if options.config != nil and File.exists?(options.config) then
        ConfigParser::parser(File.open(options.config).read, options)
      end
      options
    end
  end
end
