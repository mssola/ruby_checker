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

require "minitest/autorun"
require "ruby_checker"
require "ruby_checker/errors"

module RubyChecker
  module TestHelpers
    # Capture the output for the given block.
    def capture_output(&blk)
      original = $stdout
      msg = StringIO.new
      $stdout = msg

      yield blk

      str = $stdout.string.strip
      $stdout = original

      str
    end
  end
end
