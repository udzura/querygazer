# Querygazer

Repeated Query Runner - for monitoring, operation and CI.

This gem has a query definition DSL using RSpec.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'querygazer'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install querygazer

## Usage

```ruby
describe dataset("example_database") do
  describe query("SELECT count(*) FROM mytable1") do
    it { should be_successful }
    its(:result) { should be_more_than(100) }
  end

  describe assert("(SELECT count(*) FROM mytable2) > 5",
                  as: "mytable2 has more than 5 records") do
    it { should be_successful }
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/udzura/querygazer.

