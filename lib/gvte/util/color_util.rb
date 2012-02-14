module Gvte
  # Utility methods for manipulating colors.
  class ColorUtil
    # Converts a color in a hex string format to a list of three components with
    # the RGV values. I know, this is retarded, but I have to use it until the
    # upstream Gdk::Color.parse method is fixed.
    def self.parse_hex_color hex_color
      hex_color = hex_color.hex if hex_color.is_a? String
      blue = hex_color & 0xFF
      green = hex_color >> 8 & 0xFF
      red = hex_color >> 16 & 0xFF
      return [red, green, blue]
    end
  end
end
