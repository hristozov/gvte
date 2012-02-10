module Gvte
  # Responsible for creating KeyboardShortcut instances.
  class KeyboardShortcutFactory
    # Returns a shortcut for the given arguments.
    def self.get_shortcut(action, key=nil, ctrl=false, alt=false, shift=false)
      #key = key.downcase.bytes.to_a[0] if key.is_a? String
      KeyboardShortcut.new(action, key, ctrl, alt, shift)
    end
  end
end
