# Fuci::TeamCity
[![Build Status](https://travis-ci.org/davejachimiak/fuci-team_city.png?branch=master)](https://travis-ci.org/davejachimiak/fuci-team_city)

Run TeamCity failures locally. A
[Fuci](https://github.com/davejachimiak/fuci) server extension.

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

You must configure the following variables in .fuci-team_city.rb:

1. TeamCity host site
2. project name
3. default branch
4. username
5. password

```ruby
Fuci::TeamCity.configure do |fu|
  fu.host           = 'teamcity.myserver.com:8111'
  fu.project        = 'my_app'
  fu.default_branch = 'my-ci'
  fu.username       = 'username'
  fu.password       = 'password'
end
```

### Adding custom tester plugins

Fuci tester plugins should return two things: Whether a failed build has
failed with a specific testing framework (e.g. RSpec, Cucumber) and the
command-line command that runs those specific failures. As of now, Fuci
ships with RSpec and Cucumber tester plugins. If you want to add custom
testers, add them in the configuration:
```ruby
Fuci::Travis.configure do |fu|
  ...
  ...
  fu.add_testers Fuci::Spec, Fuci::AnotherTestingFramework
  ...
  ...
end
```

See the [base Fuci repo](https://github.com/davejachimiak/fuci#creating-tester-extensions)
for more information on custom testers.

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
