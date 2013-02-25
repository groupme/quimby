# Adapted from work by Tyler Jennings

# --------------------------------------------------
# Watchr Rules
# --------------------------------------------------
def run(cmd)
  puts(cmd)
  system("time #{cmd}")
end

def focus_str(focus)
  return "" if focus.nil?
  return "-l #{focus.to_i}" rescue nil
  return "-e '#{focus}"
end

def pick_script
  to_watch = ARGV[1]
  focus = ARGV[2]
  spec_cmd = "rspec"
  if (to_watch.match ".rb")
    focus_str = focus_str(focus)
    run( "#{spec_cmd} -c -b -fs %s %s" % [to_watch, focus_str] )
  else
    run( "#{spec_cmd} -c -b -fs %s" % to_watch)
  end
end

to_watch = ARGV[1]
watch( "^#{to_watch}") { |m| pick_script }
watch( "^#{to_watch}/.*_spec\.rb"   )   { |m| pick_script }
watch( "^app/.*\.rb"   ) { |m| pick_script }
watch( "^app/.*\.prawn"   ) { |m| pick_script }
watch( "^lib/.*\.rb"   ) { |m| pick_script }

pick_script() # run once to start us off

# --------------------------------------------------
# Signal Handling
# --------------------------------------------------
# Ctrl-C
Signal.trap('INT') { abort("\n") }

