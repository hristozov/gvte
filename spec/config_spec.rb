describe "Config" do
  it "can create new Config instance" do
    Gvte::Config.new()
  end

  it "can compare two Config instances" do
    c1 = Gvte::Config.new()
    c2 = Gvte::Config.new()

    (c1==c2).should eq true

    c1.sh = "/bin/blah"

    (c1==c2).should eq false
  end
end

