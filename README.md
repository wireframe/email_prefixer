[![Build Status](https://travis-ci.org/wireframe/email_prefixer.svg?branch=master)](https://travis-ci.org/wireframe/email_prefixer)
[![Coverage Status](https://coveralls.io/repos/wireframe/email_prefixer/badge.png?branch=master)](https://coveralls.io/r/wireframe/email_prefixer?branch=master)
[![Code Climate](https://codeclimate.com/github/wireframe/email_prefixer/badges/gpa.svg)](https://codeclimate.com/github/wireframe/email_prefixer)

# EmailPrefixer
Automatically prefix all delivered emails with the application name
and Rails environment.  A helpful configuration for setting up email
filters for non-production emails and ensuring consistency across
all email deliveries.

Examples:
```
[MyApp] Forgot Password
[MyApp STAGING] Forgot Password
```

[Based upon this coderwall protip](https://coderwall.com/p/qtsxug/prefix-all-emails-with-application-name-and-rails-env)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'email_prefixer'
```

## Configuration
All EmailPrefixer configuration can be customized using
a standard Rails config initializer.

```ruby
# config/initializers/email_prefixer.rb
EmailPrefixer.configure do |config|
  # custom configuration goes here
end
```

Some of the more common configuration options are listed here.
See the source code and test suite for a full list of options.

#### application_name - Customize Application Name
The application name is automatically inferred from the Rails application class name
and can be overridden via the `application_name` setting.

Example:
```ruby
# config/initializers/email_prefixer.rb
EmailPrefixer.configure do |config|
  config.application_name = 'MyApp'
end
```

#### stage_name - Customize Environment Stage Name
The application environment/stage name is automatically
inferred from the running Rails.env and it can be overridden
via the `stage_name` setting.

Example:
```ruby
# config/initializers/email_prefixer.rb
EmailPrefixer.configure do |config|
  config.stage_name = 'demo'
end
```

## Contributing

1. Fork it ( https://github.com/wireframe/email_prefixer/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
