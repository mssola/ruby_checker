<p align="center">
  <a href="https://travis-ci.org/mssola/ruby_checker" title="Travis CI status for the master branch"><img src="https://travis-ci.org/mssola/ruby_checker.svg?branch=master" alt="Build Status for master branch" /></a>
  <a href="https://badge.fury.io/rb/ruby_checker" title="Gem version"><img src="https://badge.fury.io/rb/ruby_checker.svg" alt="Gem version" /></a>
  <a href="http://www.gnu.org/licenses/lgpl-3.0.txt" rel="nofollow"><img alt="License LGPL 3" src="https://img.shields.io/badge/license-LGPL_3-blue.svg" style="max-width:100%;"></a>
</p>

---

`ruby_checker` provides a simple framework to enforce a specific ruby version and interpreter to be used. This is useful for projects that want to support only a sigle ruby version/interpreter.

## Basic usage

Using it is as easy as follows:

```ruby
require "ruby_checker"

RubyChecker::RubyChecker.new.check!(supported: "2.6.5")
```

This will enforce the `2.6.5` version for your application. Note though that it
is not restricting the interpreter being used. In order to do this, just
instantiate the object as follows:

```ruby
require "ruby_checker"

RubyChecker::RubyChecker.new.check!(interpreter: RubyChecker::MRI, supported: "2.6.5")
```

This gem supports the major ruby vendors by using the following constants:
`RubyChecker::MRI`, `RubyChecker::JRUBY`, `RubyChecker::MRUBY` and
`RubyChecker::TRUFFLE`.

## Ruby on Rails integration

If you are using this gem from within a Ruby on Rails project, you will notice the following:

- This gem will use the `Rails.logger` for logging purposes instead of printing
  everything on the standard output.
- You don't have to provide the `support` argument for the `RubyChecker` class,
  since it will be guessed from the `.ruby-version` file from the root of your
  project.

Moreover, this gem also implements a railtie with an initializer. This means
that if you require this gem on your Gemfile, you won't have to write any code
in order to get this gem up and running. That is if you are on this situation:
you have a `.ruby-version` file and you are using
[MRI](https://en.wikipedia.org/wiki/Ruby_MRI). If you are using another
interpreter you can write in your `config/application.rb` the following:

```ruby
config.ruby_checker.interpreter = ::RubyChecker::JRUBY  # or any other interpreter, even ANY.
```

## Contributing

Read the [CONTRIBUTING.md](./CONTRIBUTING.md) file.

## [Changelog](https://pbs.twimg.com/media/DJDYCcLXcAA_eIo?format=jpg&name=small)

Read the [CHANGELOG.md](./CHANGELOG.md) file.

## License

This project is based on work I did for the
[Portus](https://github.com/SUSE/Portus) project. I've extracted my code into a
gem so it can be also used for other projects that might be interested in this.

```
Copyright (C) 2020 Miquel Sabaté Solà <mikisabate@gmail.com>

ruby_checker is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

ruby_checker is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with ruby_checker.  If not, see <http://www.gnu.org/licenses/>.
```
