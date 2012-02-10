module Gvte
  class KeystrokeManager
    def initialize(shortcuts=[])
      @shortcuts = shortcuts.clone
      @actions = Hash.new([])
    end

    def add_keystroke(keystroke)
      @shortcuts.push(keystroke) unless @shortcuts.index(keystroke)
    end

    def register_handler(action, &handler)
      @actions[action].push(handler)
    end

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
