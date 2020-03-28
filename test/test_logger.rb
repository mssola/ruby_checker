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

class TestLogger < Minitest::Test
  include ::RubyChecker::TestHelpers

  def setup
    @logger = ::RubyChecker::Logger.new
  end

  def test_warn_without_rails
    out = capture_output { @logger.warn "message" }
    assert_equal out, "[ruby_checker] Warning: message"
  end
end
