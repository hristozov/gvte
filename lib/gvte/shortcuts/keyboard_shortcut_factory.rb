module Gvte
  # Responsible for creating KeyboardShortcut instances.
  class KeyboardShortcutFactory
    # Returns a shortcut for the given arguments.
    def self.get_shortcut(action, key=nil, ctrl=false, alt=false, shift=false)
      # We'll try to do an ASCII code -> X11 hardware code lookup.
      if key.is_a? String then
        ascii = key.downcase.bytes.to_a[0] if key.is_a? String
        lookup_result = Gdk::Keymap.default.get_entries_for_keyval(ascii)
        raise "Invalid key code in config -> " + key if lookup_result.empty?
        key = lookup_result[0][0]
      end
      KeyboardShortcut.new(action, key, ctrl, alt, shift)
    end
  end
end
