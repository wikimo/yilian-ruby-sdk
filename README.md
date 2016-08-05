# 易联云打印

*  [易联云](http://www.10ss.net/)打印 ruby sdk

## Installation

Now, Install from github only

Add this line to your application's Gemfile:

```ruby
gem 'yilian'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install yilian

## Usage

```
# usage in test.rb

require 'yilian'

config = {
  api_key: '',
  partner: '',
  username: '',
  machine_code: '',
  msign: '',
  printname: '',
}

print =  Yilian::Print.new(config)

opts ={
  machine_code: config[:machine_code],
  msign: config[:msign],
  content: '打印测试....'
}

p print.print(opts)

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/wikimo/yilian.



