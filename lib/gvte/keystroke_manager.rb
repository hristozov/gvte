module Gvte
  # The KeystrokeManager is responsible for holding lists of handlers for
  # specific actions and invoking the handlers upon receiving a keyboard
  # combination which matches the action of an appropriate KeyboardShortcut.
  class KeystrokeManager
    def initialize(shortcuts=[])
      @shortcuts = shortcuts.clone
      @actions = {}
    end

    # Adds a shortcut. If the specified (in the shortcut) keyboard combination
    # is pressed, the handlers for the action will be invoked.
    def add_shortcut(shortcut)
      @shortcuts.push(shortcut) unless @shortcuts.index(shortcut)
    end

    # Registers a handler for a specified action.
    def register_handler(action, &handler)
      @actions[action] = [] if @actions[action].nil?
      @actions[action] << handler
    end

    # Receives a keyboard combination from the GUI. Searches the shortcuts
    # for a matching shortcut and invokes the handlers for its actions.
    def send_key(keycode, ctrl=false, alt=false, shift=false)
      matchingshortcuts = @shortcuts.select { |shortcut|
        shortcut.keycode == keycode && shortcut.ctrl == ctrl &&
         shortcut.alt == alt && shortcut.shift == shift
      }
      counter = 0
      matchingshortcuts.each { |shortcut|
        action = shortcut.action
        @actions[action].each { |handler|
          handler.call(shortcut)
          counter+=1
        }
      }
      counter
    end
  end
end
