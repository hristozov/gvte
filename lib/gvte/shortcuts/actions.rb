module Gvte
  # Keeps the names of the actions specified in the config file.
  class Actions
    # Adds a tab with new terminal.
    ADD_TAB = "add_tab"
    
    # Closes the currently focuse tab.
    CLOSE_CURRENT_TAB = "close_current_tab"
    
    # Copies the text selected in the current terminal.
    COPY = "copy"
    
    # XXX: HIGHLY RETARDED ACTIONS
    # Go to tab 1
    GO_TO_TAB_1 = "go_to_tab_1"
    # Go to tab 2
    GO_TO_TAB_2 = "go_to_tab_2"
    # Go to tab 3
    GO_TO_TAB_3 = "go_to_tab_3"
    # Go to tab 4
    GO_TO_TAB_4 = "go_to_tab_4"
    # Go to tab 5
    GO_TO_TAB_5 = "go_to_tab_5"
    # Go to tab 6
    GO_TO_TAB_6 = "go_to_tab_6"
    # Go to tab 7
    GO_TO_TAB_7 = "go_to_tab_7"
    # Go to tab 8
    GO_TO_TAB_8 = "go_to_tab_8"
    # Go to tab 9
    GO_TO_TAB_9 = "go_to_tab_9"
    # Go to tab 10
    GO_TO_TAB_10 = "go_to_tab_10"
    
    # Moves to the next (right) tab.
    NEXT_TAB = "next_tab"
   
    # Pastes any clipboard contents into the current terminal.
    PASTE = "paste"
    
    # Moves to the previous (left) tab.
    PREVIOUS_TAB = "previous_tab"
    
    # Resets the currently focused terminal.
    RESET = "reset"
  end
end
