# Sanitizable

[![Gem Version](https://badge.fury.io/rb/sanitizable.svg)](https://badge.fury.io/rb/sanitizable)

Sanitizable is a Ruby gem that provides a simple way to perform HTML sanitization on attributes in ActiveRecord models.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sanitizable'
```

And then execute:

```bash
bundle install
```

Or install it yourself as:

```bash
gem install sanitizable
```

## Usage

To use Sanitizable in your ActiveRecord model, simply include the Sanitizable module and call the sanitizable class method to specify the attributes to sanitize.

```ruby
class MyModel < ActiveRecord::Base
  include Sanitizable
  sanitizable :attribute_1, :attribute_2
end
```

This will automatically sanitize the specified attributes whenever the model is saved.
Here is an example sanitization :

```ruby
my_object.attribute_1 = "<b>Bold</b> no more!  <a href='more.html'>See more here</a>..."
my_object.save

my_object.attribute_1
# => Bold no more!  See more here..
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/Logora/sanitizable.

## License

The gem is available as open source under the terms of the MIT License.