#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'adobe_io'

# Exit cleanly from an early interrupt
Signal.trap("INT") { exit 1 }

AdobeIO.configure do |config|
  config.client_secret = ENV['ADOBE_IO_CLIENT_SECRET']
  config.api_key = ENV['ADOBE_IO_API_KEY']
  config.ims_host = ENV['ADOBE_IO_IMS_HOST']
  config.private_key = ENV['ADOBE_IO_PRIVATE_KEY']
  config.iss = ENV['ADOBE_IO_ISS']
  config.sub = ENV['ADOBE_IO_SUB']
  config.scope = ENV['ADOBE_IO_SCOPE']
  config.logger.level = ARGV.include?('-v') ? Logger::DEBUG : Logger::INFO
end

puts AdobeIO::AccessToken.new.generate
