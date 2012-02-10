describe "KeystrokeManager#register_handler" do
  it "can register a basic action" do
    closure_executed = false

    keystoke = Gvte::KeyboardShortcutFactory.get_shortcut("foo", 116, true)
    manager = Gvte::KeystrokeManager.new([keystoke])

    manager.register_handler("foo") { |x|
      closure_executed = true
    }

    manager.send_key(112).should eq 0
    closure_executed.should eq false

    manager.send_key(116, true, true, true).should eq 0
    closure_executed.should eq false

    manager.send_key(116, true, true).should eq 0
    closure_executed.should eq false

    manager.send_key(116).should eq 0
    closure_executed.should eq false

    manager.send_key(116, true).should eq 1
    closure_executed.should eq true
  end

  it "can register multiple handlers" do
    closure1_executed = closure2_executed = closure3_executed = false

    keystroke = Gvte::KeyboardShortcutFactory.get_shortcut("foo", 116, true)
    manager = Gvte::KeystrokeManager.new([keystroke])

    manager.register_handler("foo") { |x|
      closure1_executed = true
    }
    manager.register_handler("foo") { |x|
      closure2_executed = true
    }
    manager.register_handler("foo") { |x|
      closure3_executed = true
    }

    manager.send_key(116, true).should eq 3
    (closure1_executed && closure2_executed && closure3_executed).should eq true
  end
end
