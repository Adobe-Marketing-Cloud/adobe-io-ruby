#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require "adobe_io"

# Exit cleanly from an early interrupt
Signal.trap("INT") { exit 1 }

options = {}
OptionParser.new do |opts|
  # opts.banner = "Usage: access_token [options]"

  # opts.on("-h", "--host HOST", "[beta production qa staging]") do |h|
  #   options[:ims_host] = h
  # end
  # opts.on("-u", "--username USERNAME", "For username") do |u|
  #   options[:username] = u
  # end
  # opts.on("-p", "--password PASSWORD", "For password") do |p|
  #   options[:password] = p
  # end
end.parse!

puts AdobeIo::AccessToken.new(options).generate