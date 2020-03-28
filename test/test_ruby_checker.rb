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

class TestRubyChecker < Minitest::Test
  def test_check_raises_error_on_nil_supported
    checker = ::RubyChecker::RubyChecker.new
    assert_raises(::RubyChecker::MissingSupportedVersionError) { checker.check! }
  end

  def test_check_raises_error_on_empty_supported
    checker = ::RubyChecker::RubyChecker.new(supported: "")
    assert_raises(::RubyChecker::MissingSupportedVersionError) { checker.check! }
  end

  def test_check_has_proper_supported_when_given
    checker = ::RubyChecker::RubyChecker.new(supported: "2.6.5")
    assert_equal checker.instance_variable_get(:@supported).to_s, "2.6.5"
  end

  def test_check_has_proper_supported_by_guessing
    checker = ::RubyChecker::RubyChecker.new
    path    = File.join(File.dirname(__FILE__), "fixtures/ruby-version")

    checker.stub(:ruby_version_file, path) do
      checker.stub(:perform_checks!, nil) { checker.check! }
    end
    assert_equal checker.instance_variable_get(:@supported).to_s, "2.6.5"
  end
end
