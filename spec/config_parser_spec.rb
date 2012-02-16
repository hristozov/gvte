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

  it "can parse the transparency flag" do
    raw_config = <<-END
transparent : true
END
    config = get_config(raw_config)
    config.transparent.should eq true
  end

  it "can handle malformed transparency flag" do
    raw_config = <<-END
transparent : 1337
END
    expect{get_config(raw_config)}.to raise_error(RuntimeError)
  end

  it "can parse the scrollback lines value" do
    raw_config = <<-END
scrollback_lines : 550
END
    config = get_config(raw_config)
    config.scrollback_lines.should eq 550
  end

  it "can handle malformed scrollback lines value" do
    raw_config = <<-END
scrollback_lines : "boo"
END
    expect{get_config(raw_config)}.to raise_error(RuntimeError)
  end

  it "can parse the font value" do
    raw_config = <<-END
font : "monospace 8"
END
    config = get_config(raw_config)
    config.font.should eq "monospace 8"
  end

  it "can handle malformed font value" do
    raw_config = <<-END
scrollback_lines : 7
END
    expect{get_config(raw_config)}.to raise_error(RuntimeError)
  end

  it "can parse the termtype value" do
    raw_config = <<-END
termtype : "xterm"
END
    config = get_config(raw_config)
    config.termtype.should eq "xterm"
  end

  it "can handle malformed termtype value" do
    raw_config = <<-END
termtype : 7
END
    expect{get_config(raw_config)}.to raise_error(RuntimeError)
  end

  it "can parse the rows value" do
    raw_config = <<-END
rows : 25
END
    config = get_config(raw_config)
    config.rows.should eq 25
  end

  it "can handle malformed rows value" do
    raw_config = <<-END
rows : "bbb"
END
    expect{get_config(raw_config)}.to raise_error(RuntimeError)
  end

  it "can parse the columns value" do
    raw_config = <<-END
columns : 15
END
    config = get_config(raw_config)
    config.columns.should eq 15
  end

  it "can handle malformed columns value" do
    raw_config = <<-END
columns : "aaa"
END
    expect{get_config(raw_config)}.to raise_error(RuntimeError)
  end

  it "can parse the background_image value" do
    raw_config = <<-END
background_image : "/home/gh/1.png"
END
    config = get_config(raw_config)
    config.background_image.should eq "/home/gh/1.png"
  end

  it "can handle malformed background_image value" do
    raw_config = <<-END
background_image : true
END
    expect{get_config(raw_config)}.to raise_error(RuntimeError)
  end

  # TODO: colors

  it "can parse a plain keystroke" do
    #pending "Needs a X11 keycode <-> ASCII code mapping."
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

    target_shortcut = Gvte::KeyboardShortcut.new("open_new_window", 28, true, false, false)
    config.shortcuts[0].should  == target_shortcut
  end

  it "can parse an ascii-coded keystroke" do
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
    #pending "Needs a X11 keycode <-> ASCII code mapping."
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

    target_shortcut = Gvte::KeyboardShortcut.new("open_new_window", 28, true, false, false)
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
    expect{get_config(raw_config)}.to raise_error(RuntimeError)
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
    expect{get_config(raw_config)}.to raise_error(RuntimeError)
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
    expect{get_config(raw_config)}.to raise_error(RuntimeError)
  end

end
