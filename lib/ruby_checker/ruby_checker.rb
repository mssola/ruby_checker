# frozen_string_literal: true

# Copyright (C) 2020 Miquel Sabaté Solà <mikisabate@gmail.com>
#
# This file is part of ruby_checker.
#
# ruby_checker is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# ruby_checker is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with ruby_checker.  If not, see <http://www.gnu.org/licenses/>.

require "ruby_checker/errors"
require "ruby_checker/interpreter"
require "ruby_checker/logger"
require "ruby_checker/versions"

require "rubygems/version"

module RubyChecker
  # RubyChecker is the main class for this gem. See the README.md on how to use it.
  class RubyChecker
    def initialize(interpreter: ::RubyChecker::ANY, supported: nil)
      @interpreter = interpreter
      @supported   = supported
      @current     = Gem::Version.new(RUBY_VERSION)
    end

    # check! performs all the checks that are required.
    def check!
      @supported = parsed_supported_version
      raise MissingSupportedVersionError if @supported.nil?

      res = perform_checks!
      Logger.new.debug "OK!" if res
      res
    end

    protected

    # parsed_supported_version normalizes the @supported instance variable so it
    # can be passed to the different checkers.
    def parsed_supported_version
      return Gem::Version.new(@supported) if @supported.is_a?(String) && @supported != ""

      file = ruby_version_file
      return nil if file.nil? || !File.file?(file)

      Gem::Version.new(File.read(file).strip)
    end

    # perform_checks! does the actual calls to the diferent checkers.
    def perform_checks!
      Interpreter.new(@interpreter).check!
      Versions.new(current: @current, supported: @supported).check!
    end

    # ruby_version_file returns the path to the .ruby-version file if it can be
    # guessed. Otherwise it returns nil.
    def ruby_version_file
      return nil unless defined?(Rails)

      Rails.root.join(".ruby-version")
    end
  end
end
