$LOAD_PATH.unshift 'lib'
require "openkvk-wrapper/version"

Gem::Specification.new do |s|
  s.name              = "openkvk-wrapper"
  s.version           = OpenKVK::VERSION
  s.date              = Time.now.strftime('%Y-%m-%d')
  s.summary           = "A simple OpenKVK wrapper."
  s.homepage          = "http://github.com/StephanMeijer/openkvk-wrapper"
  s.email             = "me@stephanmeijer.com"
  s.authors           = [ "Stephan Meijer" ]
  s.has_rdoc          = true

  s.files             = %w( LICENSE )
  s.files            += Dir.glob("lib/**/*")
  s.description       = <<desc
  Simple OpenKVK API wrapper.
desc
end
