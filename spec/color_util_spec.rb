describe "ColorUtil::parse_hex_color" do
  it "can parse a hex color with leading 0x" do
    result = Gvte::ColorUtil.parse_hex_color "0xCD5418"
    result.size.should eq 3
    result[0].should eq 205
    result[1].should eq 84
    result[2].should eq 24
  end

  it "can parse a hex color" do
    result = Gvte::ColorUtil.parse_hex_color "1337FF"
    result.size.should eq 3
    result[0].should eq 19
    result[1].should eq 55
    result[2].should eq 255
  end
  
  it "can parse an empty color string to black" do
    result = Gvte::ColorUtil.parse_hex_color ""
    result.size.should eq 3
    result[0].should eq 0
    result[1].should eq 0
    result[2].should eq 0
  end

  it "can parse black" do
    result = Gvte::ColorUtil.parse_hex_color "0"
    result.size.should eq 3
    result[0].should eq 0
    result[1].should eq 0
    result[2].should eq 0
  end
end
