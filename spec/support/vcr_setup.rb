require 'vcr'

VCR.config do |c|
  c.cassette_library_dir     = 'fixtures/cassette_library'
  c.stub_with                :typhoeus
  c.ignore_localhost         = true
  c.default_cassette_options = { :record => :once }
  c.allow_http_connections_when_no_cassette = false
end
