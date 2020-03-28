# frozen_string_literal: true

# Copyright (C) 2020 Miquel Sabaté Solà <mikisabate@gmail.com>
#
# This file is part of ruby_checker
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

require "test_helper"

class TestInterpreter < Minitest::Test
  def test_check_fails_for_non_integer
    interpreter = ::RubyChecker::Interpreter.new("thing")
    assert_raises(::RubyChecker::NotSupportedError) { interpreter.check! }
  end

  def test_check_fails_for_out_of_range
    interpreter = ::RubyChecker::Interpreter.new(9000)
    assert_raises(::RubyChecker::NotSupportedError) { interpreter.check! }
  end

  def test_check_succeeds_on_any
    assert ::RubyChecker::Interpreter.new(::RubyChecker::ANY).check!
  end

  def test_check_proper_interpreter
    interpreter = ::RubyChecker::Interpreter.new(::RubyChecker::JRUBY)
    interpreter.stub :ruby_engine, "jruby" do
      assert interpreter.check!
    end
  end

  def test_check_wrong_interpreter
    interpreter = ::RubyChecker::Interpreter.new(::RubyChecker::MRI)
    interpreter.stub :ruby_engine, "jruby" do
      assert_raises(::RubyChecker::NotSupportedError) { interpreter.check! }
    end
  end
end
