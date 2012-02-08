describe "ConfigParser::parse" do
  def get_config(config_text)
    config = Gvte::Config.new
    Gvte::ConfigParser.parse(config_text, config)
    config
  end

  it "can parse a plain keystroke" do
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
end
