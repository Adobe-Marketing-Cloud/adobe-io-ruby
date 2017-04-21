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

AdobeIo.configure do |config|
  config.client_secret = ENV['IO_CLIENT_SECRET']
  config.api_key = ENV['IO_API_KEY']
  config.ims_host = ENV['IO_IMS_HOST']
  config.private_key = ENV['IO_PRIVATE_KEY']
  config.iss = ENV['IO_ISS']
  config.sub = ENV['IO_SUB']
end

puts AdobeIo::AccessToken.new(options).generate
