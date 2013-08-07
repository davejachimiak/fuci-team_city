# Fuci::TeamCity

Run TeamCity failures locally. A [Fuci](https://github.com/davejachimiak/fuci) server extension.

## Installation

Add this line to your application's Gemfile:

    gem 'fuci-team_city', '~> 0.1'

And then execute:

    $ bundle

Bundling the binstub is highly recommended:

    $ bundle binstubs fuci-team_city

## Configuration
### Configuration file
To configure itself, fuci-team_city looks for a file called
".fuci-team_city.rb" in your project's root directory. You should create
that file and configure fuci-team_city there. The configuration must
include your TeamCity username and password. **Therefore, you should
include ./.fuci-team_city.rb in .gitignore.**

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
