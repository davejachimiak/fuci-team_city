# Fuci::TeamCity

Run TeamCity failures locally. A [Fuci](https://github.com/davejachimiak/fuci) server extension.

## Installation

Add this line to your application's Gemfile:

    gem 'fuci-team_city', '~> 0.1'

And then execute:

    $ bundle

Bundling the binstub is highly recommended:

    $ bundle binstubs fuci-team_city

## Configuration file
To configure itself, fuci-team_city looks for a file called
".fuci-team_city.rb" in your project's root directory. You should create
that file and configure fuci-team_city there. The configuration must
include your TeamCity username and password. **Therefore, you should
include ./.fuci-team_city.rb in .gitignore.**

Configure your TeamCity host, username, and password in the
configuration file:

```ruby
Fuci::TeamCity.configure do |fu|
  fu.host     = 'http://teamcity.myserver.com:8111/'
  fu.username = '<user name>'
  fu.password = '<password>'
end
```

### Default branch

Declare the default branch that you push to:

```ruby
Fuci::TeamCity.configure do |fu|
  fu.default_branch = 'my-ci'
end
```

## Usage

See the
[base Fuci repo](https://github.com/davejachimiak/fuci#native-command-line-options)
for command-line options native to Fuci.

Run your latest ci failures locally:
```sh
$ fuci
```

Call `fuci` with a branch name to run a specific branch's failures
branch. For example, this will run the failures from the latest master
build on your local code:
```sh
$ fuci master
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
