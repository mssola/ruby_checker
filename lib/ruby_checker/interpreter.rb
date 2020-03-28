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

module RubyChecker
  ANY     = 0
  MRI     = 1
  JRUBY   = 2
  MRUBY   = 3
  TRUFFLE = 4

  # Interpreter adds checking capabilities for interpreters.
  class Interpreter
    def initialize(required)
      @required = required
    end

    # check! performs checks for interpreter, ruby engines, etc. It might raise
    # the following exceptions:
    #
    # - NotSupportedError: if the current interpreter does not match with the
    #   expectation.
    # - RubyEngineNotAvailableError: if the RUBY_ENGINE constant has not been
    #   defined.
    def check!
      return true if @required == ANY

      raise NotSupportedError, stringify(@required) if current_interpreter != @required

      true
    end

    # Returns the constant representing the current ruby interpreter. It will
    # return nil if the interpreter is not supported by this gem and it will
    # raise a RubyEngineNotAvailableError if the RUBY_ENGINE constant has not
    # been defined.
    def current_interpreter
      raise RubyEngineNotAvailableError if ruby_engine.nil?

      case ruby_engine
      when "ruby"
        MRI
      when "jruby"
        JRUBY
      when "mruby"
        MRUBY
      when "truffleruby"
        TRUFFLE
      end
    end

    # ruby_engine returns the value for RUBY_ENGINE, or nil if this constant is
    # not defined.
    #
    # This method lives mainly so it can be stubbed in tests.
    def ruby_engine
      defined?(RUBY_ENGINE) ? RUBY_ENGINE : nil
    end

    # Returns a string representation for the given interpreter.
    def stringify(interpreter)
      return "unknown interpreter" unless interpreter.is_a?(Integer)

      %w[MRI JRuby mruby truffleruby][interpreter - 1] || "unknown interpreter"
    end
  end
end
