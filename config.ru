# frozen_string_literal: true

# timeout if taking too long
require 'rack-timeout'
use Rack::Timeout

# Redirect to the custom (canonical) hostname.
use Rack::CanonicalHost, ENV['HOSTNAME'] if ENV['HOSTNAME']

root = ::File.dirname(__FILE__)
require ::File.join(root, 'app')
run App.new
