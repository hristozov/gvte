describe "ConfigParser#parse" do
  it "can parse a plain keystroke" do
    raw_config = <<-END
shortcuts:
  - action: open_new_window
    ctrl  : true
    alt   : false
    shift : false
    key   : t
END
    config = Gvte::ConfigParser.new(raw_config).config

    config.shortcuts.size.should eq 1

    target_shortcut = Gvte::KeyboardShortcut.new("open_new_window", 116, true, false, false)
    config.shortcuts[0].should  == target_shortcut

  end
end
