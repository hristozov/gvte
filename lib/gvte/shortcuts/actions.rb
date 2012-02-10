module Gvte
  # Keeps the names of the actions specified in the config file.
  class Actions
    # Adds a tab with new terminal.
    ADD_TAB = "add_tab"
    # Closes the currently focuse tab.
    CLOSE_CURRENT_TAB = "close_current_tab"
    # Copies the text selected in the current terminal.
    COPY = "copy"
    # Moves to the next (right) tab.
    NEXT_TAB = "next_tab"
    # Pastes any clipboard contents into the current terminal.
    PASTE = "paste"
    # Moves to the previous (left) tab.
    PREVIOUS_TAB = "previous_tab"
  end
end
