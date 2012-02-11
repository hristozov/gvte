describe "KeyboardShortcutFactory::get_shortcut" do

  it "can create shortcuts with one keystroke" do
    shortcut = Gvte::KeyboardShortcutFactory.get_shortcut("foo", 119)
    shortcut.action.should eq "foo"
    shortcut.keycode.should eq 119
    shortcut.ctrl.should eq false
    shortcut.alt.should eq false
    shortcut.shift.should eq false
  end

  it "can handle ASCII keycodes" do
    #pending "Needs a X11 keycode <-> ASCII code mapping."
    shortcut = Gvte::KeyboardShortcutFactory.get_shortcut("foo", "w")
    shortcut.action.should eq "foo"
    shortcut.keycode.should eq 25
    shortcut.ctrl.should eq false
    shortcut.alt.should eq false
    shortcut.shift.should eq false
  end

end
