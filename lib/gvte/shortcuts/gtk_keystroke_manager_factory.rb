module Gvte
  # Responsible for creating a KeystrokeManager and attaching it to a given widget.
  # The idea here is to move the GTK-specific signal handling out from the manager.
  class GTKKeystrokeManagerFactory
    # Constructs the manager with the given config instance and target widget.
    def self.get_manager(config, widget)
      manager = KeystrokeManager.new(config.shortcuts)

      widget.signal_connect("key-press-event") do |widget, keyevent|
        keyval = Gdk::Keyval.to_lower(keyevent.keyval) #XXX: This seems useless. 
        state = keyevent.state
        Gdk::Keymap.default.get_entries_for_keyval(keyval).each { |entry|
          manager.send_key(entry[0],
                           state.control_mask?,
                           state.mod1_mask?,
                           state.shift_mask?)
        }
        false # false for success.
      end

      manager
    end
  end
end

