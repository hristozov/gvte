describe "Config" do
  it "can create new Config instance" do
    Gvte::Config.new
  end

  it "can compare two Config instances" do
    c1 = Gvte::Config.new
    c2 = Gvte::Config.new

    c1.should eq c2

    c1.sh = "/bin/blah"

    c1.should_not eq c2
  end

  it "can copy config objects" do
    c1 = Gvte::Config.new
    
    c1.sh = "/bin/ksh"
    c1.columns = 1337
    c1.rows = 31337

    c2 = c1.copy
    c2.should eq c1
  end

  it "can override options with the + operator" do
    c1 = Gvte::Config.new
    c2 = Gvte::Config.new

    c1.sh = "/bin/sh"
    c1.rows = 1337
    c1.config = "/lol"
    c2.sh = "/bin/false"
    c2.columns = 31337

    c3 = c1 + c2
    c3.sh.should eq c2.sh
    c3.rows.should eq c1.rows
    c3.columns.should eq c2.columns
    c3.config.should eq c1.config
  end
end

