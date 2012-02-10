describe "ConfigParser::parse" do
  def get_config(config_text)
    config = Gvte::Config.new
    Gvte::ConfigParser.parse(config_text, config)
    config
  end

  it "returns the default config on empty config file" do
    get_config("").should eq Gvte::Config.new
  end

  #TODO: Consider outputting warnings in this case.
  it "returns the default config on config file with irrelevant options" do
    raw_config = <<-END
foo: "bar"
aaa: true
moo:
  - 1
  - 2
END
    config = get_config(raw_config)

    config.should eq Gvte::Config.new
  end

  it "can parse a plain keystroke" do
    pending "Needs a X11 keycode <-> ASCII code mapping."
    raw_config = <<-END
shortcuts:
  - action: open_new_window
    ctrl  : true
    alt   : false
    shift : false
    key   : t
END
    config = get_config(raw_config)
   
    config.shortcuts.size.should eq 1

    target_shortcut = Gvte::KeyboardShortcut.new("open_new_window", 116, true, false, false)
    config.shortcuts[0].should  == target_shortcut
  end

  it "can parse a ascii-coded keystroke" do
    raw_config = <<-END
shortcuts:
  - action: open_new_window
    ctrl  : true
    alt   : false
    shift : false
    key   : 116
END
    config = get_config(raw_config)
    
    config.shortcuts.size.should eq 1

    target_shortcut = Gvte::KeyboardShortcut.new("open_new_window", 116, true, false, false)
    config.shortcuts[0].should  == target_shortcut
  end

  it "is not case-sensitive when parsing keystrokes" do
    pending "Needs a X11 keycode <-> ASCII code mapping."
    raw_config = <<-END
shortcuts:
  - action: open_new_window
    ctrl  : true
    alt   : false
    shift : false
    key   : T
END
    config = get_config(raw_config)
    
    config.shortcuts.size.should eq 1

    target_shortcut = Gvte::KeyboardShortcut.new("open_new_window", 116, true, false, false)
    config.shortcuts[0].should  == target_shortcut
  end

  it "assumes false for the missing properties of the keystroke definitions" do
    raw_config = <<-END
shortcuts:
  - action: open_new_window
    key   : 28
END
    config = get_config(raw_config)
    
    config.shortcuts.size.should eq 1

    target_shortcut = Gvte::KeyboardShortcut.new("open_new_window", 28, false, false, false)
    config.shortcuts[0].should  == target_shortcut

  end

  it "can handle malformed keyboard shortcuts definition" do
    raw_config = <<-END
shortcuts: 5
END
    STDERR.should_receive(:puts).exactly(1).times
    config = get_config(raw_config)

    config.shortcuts.size.should eq 0
  end

  it "can parse the shell location" do
    raw_config = <<-END
sh: "/bin/bash"
END
    config = get_config(raw_config)

    config.sh.should eq "/bin/bash"
  end

  it "can handle malformed shell location" do
    raw_config = <<-END
sh: 5
END
    STDERR.should_receive(:puts).exactly(1).times
    config = get_config(raw_config)

    config.sh.should eq Gvte::Config.new.sh
  end

  it "can parse the starting directory location" do
    raw_config = <<-END
dir: "/home/gh"
END
    config = get_config(raw_config)

    config.dir.should eq "/home/gh"
  end

  it "can handle malformed starting directory location" do
    raw_config = <<-END
dir: true
END
    STDERR.should_receive(:puts).exactly(1).times
    config = get_config(raw_config)

    config.dir.should eq Gvte::Config.new.dir
  end

end
