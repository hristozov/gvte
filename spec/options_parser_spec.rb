describe "OptionsParser::parse" do
  def get_config(argv)
    config = Gvte::Config.new
    Gvte::OptionsParser.parse(argv, config)
    config
  end

  it "has appropriate default values" do
    config = get_config([])
    config.sh.should eq "/bin/bash"
    config.config.should eq "~/.gvterc"
  end

  it "can parse the shell path" do
    config = get_config(["--sh=/bin/zsh"])
    config.sh.should eq "/bin/zsh"
  end

  it "can parse the location of the start dir" do
    config = get_config(["--dir=/home/gh"])
    config.dir.should eq "/home/gh"
  end

  it "can parse the config file location" do
    config = get_config(["--config=/home/gh/lolrc"])
    config.config.should eq "/home/gh/lolrc"
  end

  it "can fail on malformed arguments" do
    argtest = lambda {|args|
      lambda {
        config = Gvte::Config.new
        STDERR.should_receive(:puts).exactly(2).times
        Gvte::OptionsParser.parse(args, config)
      }.should raise_error SystemExit
    }

    argtest.call(["--foo"])
    argtest.call(["-sh=/bin/zsh"])
    argtest.call(["--sh"])
    argtest.call(["--dir"])
    argtest.call(["--config"])
  end
end
