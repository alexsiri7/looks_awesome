require "looks_awesome"

RSpec.configure do |config|
  config.extend LooksAwesome::DSL, :type => :feature
end