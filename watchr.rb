watch( '(lib|bin)/.*\.rb' ) { do_rspec }

def do_rspec
  system "rspec"
end
