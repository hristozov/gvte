describe "Gvte::ShellNotebook" do
  let(:main_window) {
    Gtk::Window.new()
  }

  let(:shortcuts_config) {
    raw_conf = <<-END
shortcuts :
  - action : add_tab
    ctrl   : true
    key    : 28 #116

  - action : close_current_tab
    ctrl   : true
    key    : 25 #119

  - action : copy
    ctrl   : true
    shift  : true
    key    : 54

  - action : next_tab
    ctrl   : true
    key    : 23 #65289

  - action : previous_tab
    ctrl   : true
    shift  : true
    key    : 23 #65056

  - action : paste
    ctrl   : true
    shift  : true
    key    : 55

  - action : reset
    ctrl   : true
    alt    : true
    key    : 27

  - action : go_to_tab_1
    alt    : true
    key    : 10 #49

  - action : go_to_tab_2
    alt    : true
    key    : 11 #50

  - action : go_to_tab_3
    alt    : true
    key    : 12 #51
END
    config = Gvte::Config.new
    Gvte::ConfigParser.parse(raw_conf, config)
    config
  }

  let(:keystroke_manager) {
    Gvte::GTKKeystrokeManagerFactory.get_manager(shortcuts_config, main_window)
  }

  def get_nb(config_text="")
    config = Gvte::Config.new
    Gvte::ConfigParser.parse(config_text, config)
    Gvte::ShellNotebook.new(config, main_window, keystroke_manager)
  end

  def generate_fake_key_press_event(keycode, ctrl = false, alt = false, shift = false)
    keyevent = Gdk::EventKey.new Gdk::Event::KEY_PRESS
    mask = 0
    mask |= Gdk::Window::CONTROL_MASK if ctrl
    mask |= Gdk::Window::MOD1_MASK if alt
    mask |= Gdk::Window::SHIFT_MASK if shift
    keyevent.state = Gdk::Window::ModifierType.new mask
    keyevent.keyval = keycode
    main_window.signal_emit("key-press-event", keyevent)
  end


  it "can create new terminals and later close some of them" do
    nb = get_nb
    6.times { nb.add_shell }
    nb.n_pages.should eq 6
    3.times { nb.remove_current_shell }
    nb.n_pages.should eq 3
  end

  it "can create new terminals with keyboard shortcut" do
    nb = get_nb
    6.times { generate_fake_key_press_event(116, true) } # add_tab
    nb.n_pages.should eq 6
    3.times { generate_fake_key_press_event(119, true) } # close_current_tab
    nb.n_pages.should eq 3
  end

  it "can handle the close_current_tab when no tabs are open" do
    nb = get_nb
    3.times { generate_fake_key_press_event(119, true) } # close_current_tab
    nb.n_pages.should eq 0
  end

  it "can create new terminals and cycle between tabs" do
    nb = get_nb
    6.times { generate_fake_key_press_event(116, true) } # add_tab
    nb.n_pages.should eq 6
    nb.page.should eq 5

    3.times { generate_fake_key_press_event(65289, true) } # next_tab
    nb.page.should eq 2
    60.times { generate_fake_key_press_event(65289, true) } # next_tab
    nb.page.should eq 2
    2.times { generate_fake_key_press_event(65056, true, false, true) } # previous_tab
    nb.page.should eq 0
    37.times { generate_fake_key_press_event(65056, true, false, true) } # previous_tab
    nb.page.should eq 5
  end

  it "can handle a more complex example of manipulating tabs" do
    nb = get_nb
    6.times { generate_fake_key_press_event(116, true) } # add_tab
    nb.n_pages.should eq 6
    nb.page.should eq 5

    60.times { generate_fake_key_press_event(65289, true) } # next_tab
    nb.page.should eq 5
    3.times { generate_fake_key_press_event(119, true) } # close_current_tab
    nb.page.should eq 2
    nb.n_pages.should eq 3
    6.times { generate_fake_key_press_event(116, true) } # add_tab
    nb.page.should eq 8
    nb.n_pages.should eq 9
    7.times { generate_fake_key_press_event(65056, true, false, true) } # previous_tab
    nb.page.should eq 1
    8.times { generate_fake_key_press_event(119, true) } # close_current_tab
    nb.page.should eq 0
  end

end
