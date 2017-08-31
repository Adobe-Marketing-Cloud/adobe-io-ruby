# Ruby::Adobe::Io

Create JWT tokens and exchange for IMS access tokens for use with your Adobe I/O integration

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby-adobe-io'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ruby-adobe-io

## Usage

#### Commands
```bash
access_token.rb
access_token.rb -v
```
### For you Rails app
Create an initializer
```ruby
AdobeIo.configure do |config|
  config.client_secret = ENV['IO_CLIENT_SECRET']
  config.api_key = ENV['IO_API_KEY']
  config.ims_host = ENV['IO_IMS_HOST']
  config.private_key = ENV['IO_PRIVATE_KEY']
  config.iss = ENV['IO_ISS']
  config.sub = ENV['IO_SUB']
end
```
You can set the log level to debug if you want more messaging
```ruby
AdobeIo.configure do |config|
  config.logger.level = Logger::WARN
end
```

Generate a new access token:
```ruby
AdobeIo::AccessToken.new.generate
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://git.corp.adobe.com/reactor/ruby-adobe-io. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
