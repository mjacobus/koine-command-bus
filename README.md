# Koine::CommandBus

Command bus for ruby

[![Build Status](https://travis-ci.org/mjacobus/koine-command-bus.svg)](https://travis-ci.org/mjacobus/koine-command-bus)
[![Code Coverage](https://scrutinizer-ci.com/g/mjacobus/koine-command-bus/badges/coverage.png?b=master)](https://scrutinizer-ci.com/g/mjacobus/koine-command-bus/?branch=master)
[![Code Climate](https://codeclimate.com/github/mjacobus/koine-command-bus/badges/gpa.svg)](https://codeclimate.com/github/mjacobus/koine-command-bus)
[![Scrutinizer Code Quality](https://scrutinizer-ci.com/g/mjacobus/koine-command-bus/badges/quality-score.png?b=master)](https://scrutinizer-ci.com/g/mjacobus/koine-command-bus/?branch=master)
[![Dependency Status](https://gemnasium.com/mjacobus/koine-command-bus.svg)](https://gemnasium.com/mjacobus/koine-command-bus)
[![Gem Version](https://badge.fury.io/rb/koine-command_bus.svg)](https://badge.fury.io/rb/koine-command_bus)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'koine-command_bus'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install koine-command_bus

## Usage

### The command

```ruby
class App::Command::ClearDirectory
  attr_reader :dir

  def initialize(dir)
    @dir = dir
  end
end
```
#### Handler

```ruby
class App::CommandHandler::ClearDirectory
  def handle(command)
    system("rm -rf command.dir/*")
  end
end
```

And if you want to run:

```ruby
command = App::Command::ClearDirectory.new('/tmp')
handler = App::CommandHandler::ClearDirectory.new
handler.handle(command)
```

But if you want a sigle object to be responsible to route to the correct handler
you can use the command bus

#### The command bus

You can create a handler, as follows:

```ruby
class MyCommandHandlerResolver
  def resolve(command)
    handler_class(command).new
  end

  def handler_class(command)
    klass = command.class.to_s.gsub('Command', 'CommandHandler')
    Object.const_get(klass)
  end
end
```

Append the resolver to the command bus

```ruby
command_bus = Koine::CommandBus.new
command_bus.resolvers << MyHandler.new

command = App::Command::ClearDirectory.new('/tmp')
command_bus.handle(command) # dir cleared!
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mjacobus/koine-command_bus. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

