# DISCLAIMER: The tests here are very sensitive to the environment.
# They will pass only on X11 with standard keyboard configuration and a decent
# version of GTK.
describe "GTKKeystrokeManagerFactory::get_manager" do
  def generate_fake_key_press_event(keycode, ctrl = false, alt = false, shift = false)
    keyevent = Gdk::EventKey.new Gdk::Event::KEY_PRESS
    mask = 0
    mask |= Gdk::Window::CONTROL_MASK if ctrl
    mask |= Gdk::Window::MOD1_MASK if alt
    mask |= Gdk::Window::SHIFT_MASK if shift
    keyevent.state = Gdk::Window::ModifierType.new mask
    keyevent.keyval = keycode
    keyevent
  end

  it "can create a manager responding to simple keystrokes sent to a GTK window" do
    widget = Gtk::Window.new
    config = Gvte::Config.new
    config.shortcuts = []
    # 28 = "t" (GDK code : 116) ; 29 = "y" (GDK code : 121)
    config.shortcuts << Gvte::KeyboardShortcut.new("foo", 28, true, false, true)
    config.shortcuts << Gvte::KeyboardShortcut.new("bar", 29, false, true, true)

    manager = Gvte::GTKKeystrokeManagerFactory::get_manager config, widget
    foo_handler_called = false
    bar_handler_called = false
    manager.register_handler("foo") {
      foo_handler_called = true
    }
    manager.register_handler("bar") {
      bar_handler_called = true
    }

    widget.signal_emit "key-press-event", generate_fake_key_press_event(116)
    foo_handler_called.should eq false
    bar_handler_called.should eq false

    widget.signal_emit "key-press-event", generate_fake_key_press_event(121)
    foo_handler_called.should eq false
    bar_handler_called.should eq false

    widget.signal_emit "key-press-event", generate_fake_key_press_event(116, true, false, true)
    foo_handler_called.should eq true
    bar_handler_called.should eq false

    foo_handler_called = false

    widget.signal_emit "key-press-event", generate_fake_key_press_event(121, false, true, true)
    foo_handler_called.should eq false
    bar_handler_called.should eq true

  end
end
