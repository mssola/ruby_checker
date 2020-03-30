# frozen_string_literal: true

# copyright (c) 2020 miquel sabaté solà <mikisabate@gmail.com>
#
# this file is part of ruby_checker.
#
# ruby_checker is free software: you can redistribute it and/or modify
# it under the terms of the gnu lesser general public license as published by
# the free software foundation, either version 3 of the license, or
# (at your option) any later version.
#
# ruby_checker is distributed in the hope that it will be useful,
# but without any warranty; without even the implied warranty of
# merchantability or fitness for a particular purpose.  see the
# gnu general public license for more details.
#
# you should have received a copy of the gnu lesser general public license
# along with ruby_checker.  if not, see <http://www.gnu.org/licenses/>.

require "rails"

module RubyChecker
  # Railtie implements a Ruby on Rails initializer so most Rails apps don't have
  # to do anything in order to setup this gem.
  class Railtie < Rails::Railtie
    railtie_name :ruby_checker

    initializer "ruby_checker" do |app|
      ::RubyChecker::RubyChecker.new(interpreter: app.config.ruby_checker.interpreter).check!
    end

    config.ruby_checker = ActiveSupport::OrderedOptions.new
    config.ruby_checker.interpreter = ::RubyChecker::MRI
  end
end
