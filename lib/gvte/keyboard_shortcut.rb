module Gvte
  # Associates a combination of keys with an action. Created by parsing the
  # config file. This will be used later for invoking the handlers for the given
  # action when the specified keys here are pressed.
  class KeyboardShortcut
    # The action for the current shortcut. This is a text string given in the
    # configuration options. When the specified keys are pressed, the
    # application should execute this action.
    attr_accessor :action
    # Whether the ALT key is used in the shortcut.
    attr_accessor :alt
    # Whether the CTRL is used in the shortcut.
    attr_accessor :ctrl
    # The X11 keycode (the one from the "xev" command) of the shortcut.
    attr_accessor :keycode
    # Whether the SHIFT key is used in the shortcut.
    attr_accessor :shift
   
    def initialize(action, keycode=nil, ctrl=false, alt=false, shift=false)
      @action = action
      @keycode = keycode
      #XXX: Ugly :(
      @ctrl = ctrl ? ctrl : false
      @alt = alt ? alt : false
      @shift = shift ? shift : false
    end

    def ==(other_shortcut)
      @action == other_shortcut.action &&
        @keycode == other_shortcut.keycode &&
        @ctrl == other_shortcut.ctrl &&
        @alt == other_shortcut.alt &&
        @shift == other_shortcut.shift
    end
  end
end
