module Gvte
  class KeyboardShortcutFactory
    def self.get_shortcut(action, key=nil, ctrl=false, alt=false, shift=false)
      key = key.bytes.to_a[0] if key.is_a? String
      KeyboardShortcut.new(action, key, ctrl, alt, shift)
    end
  end
end
