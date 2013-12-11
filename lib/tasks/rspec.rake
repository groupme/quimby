unless Rails.env.production? || Rails.env.staging?
  #required to override/tweak the default rake tasks
  require 'rspec/core'
  require 'rspec/core/rake_task'

  #remove the old spec task

  Rake.application.instance_variable_get( '@tasks' ).delete( "spec" )

  desc "Run all specs in spec , but not the ones in vendor/ ( including extensions )"
  RSpec::Core::RakeTask.new( :"spec" => :"db:test:prepare" )
end
