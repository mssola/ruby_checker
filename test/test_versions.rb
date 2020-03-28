# frozen_string_literal: true

# Copyright (C) 2020 Miquel Sabaté Solà <msabate@suse.com>
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
require "rubygems/version"

class TestVersions < Minitest::Test
  include ::RubyChecker::TestHelpers

  # Returns a ::RubyChecker::Versions instance with the given current and
  # supported versions. It's basically a shortcut for properly creating this
  # instance.
  def current_supported_versions(current, supported)
    ::RubyChecker::Versions.new(
      current:   Gem::Version.new(current),
      supported: Gem::Version.new(supported)
    )
  end

  def test_check_true_if_versions_match_exactly
    versions = current_supported_versions("2.6.5", "2.6.5")
    assert versions.check!
  end

  def test_check_true_if_current_is_newer_by_patch_level
    versions = current_supported_versions("2.6.5", "2.6.2")
    assert versions.check!
  end

  def test_check_false_if_current_is_newer_by_minor_level
    versions = current_supported_versions("2.6.5", "2.5.2")
    res = true
    str = capture_output { res = versions.check! }

    refute res
    assert str, "Using 2.6.5, but 2.5.2 is the one supported."
  end

  def test_check_false_if_current_is_newer_by_major_level
    versions = current_supported_versions("2.6.5", "1.9.3")
    res = true
    str = capture_output { res = versions.check! }

    refute res
    assert str, "Using 2.6.5, but 1.9.3 is the one supported."
  end

  def test_check_false_if_current_is_older_by_patch_level
    versions = current_supported_versions("2.6.2", "2.6.5")
    res = true
    str = capture_output { res = versions.check! }

    refute res
    assert str, "Using 2.6.2, but 2.6.5 is the one supported."
  end

  def test_check_raises_error_if_current_is_older_by_minor_level
    versions = current_supported_versions("2.5.2", "2.6.5")
    assert_raises(::RubyChecker::OutdatedRubyError) { versions.check! }
  end
end
