$TESTING=true

$:.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

SPEC_ROOT = File.dirname(__FILE__)

require 'rspec'
require 'nokogiri'
require 'rubalto'

RSpec.configure do |config|
end

def fixtures_path
  File.join(SPEC_ROOT, 'fixtures')
end

def alto_fixture(name)
  File.read(File.join(fixtures_path, "#{name}.xml"))
end
