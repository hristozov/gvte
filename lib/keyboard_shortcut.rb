module Gvte
  class KeyboardShortcut
    attr_accessor :action, :ctrl, :alt, :shift, :keycode

    def initialize(action, keycode=nil, ctrl=false, alt=false, shift=false)
      @action = action
      @keycode = keycode
      @ctrl = ctrl
      @alt = alt
      @shift = shift
    end

    def ==(other_shortcut)
      @action == other_shortcut.action
      @keycode == other_shortcut.keycode
      @ctrl == other_shortcut.ctrl
      @alt == other_shortcut.alt
      @shift == other_shortcut.shift
    end
  end
end
