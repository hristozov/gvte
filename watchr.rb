watch( '(bin|lib|spec)/.*\.rb' ) { do_rspec }

def do_rspec
  system "rspec"
end
