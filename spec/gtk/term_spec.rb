describe "Gvte::term" do
  def get_term(config_text)
    config = Gvte::Config.new
    Gvte::ConfigParser.parse(config_text, config)
    Gvte::Term.new(config)
  end

  it "can set the scrollback lines correctly" do
    raw_config = <<-END
scrollback_lines : 1337
END
    term = get_term(raw_config)
    term.scrollback_lines.should eq 1337
  end

  it "can set the font correctly" do
    raw_config = <<-END
font : monospace 8
END
    term = get_term(raw_config)
    term.font.should eq Pango::FontDescription.new("monospace 8")
  end

  it "can set the termtype correctly" do
    raw_config = <<-END
termtype : trololo
END
    term = get_term(raw_config)
    term.emulation.should eq "trololo"
  end

end
