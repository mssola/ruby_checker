# frozen_string_literal: true

# Copyright (C) 2020 Miquel Sabaté Solà <msabate@suse.com>
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

module RubyChecker
  # MissingSupportedVersionError is raised whenever the supported version could
  # not be guessed and it was not given.
  class MissingSupportedVersionError < StandardError
    def initialize
      super("Supported version could not be guessed and it was not provided")
    end
  end

  # RubyEngineNotAvailableError is raised whenever RUBY_ENGINE is detected to
  # not be available.
  class RubyEngineNotAvailableError < StandardError
    def initialize
      super("Apparently your Ruby interpreter does not define the 'RUBY_ENGINE' constant." \
            " This is not supported.")
    end
  end

  # NotSupportedError is raised when the current interpreter is detected to not
  # be supported.
  class NotSupportedError < StandardError
    def initialize(interpreter)
      super("Current interpreter is not supported. You should use '#{interpreter}' instead.")
    end
  end

  # OutdatedRubyError is raised whenever the current Ruby is detected to be too
  # old.
  class OutdatedRubyError < StandardError
    def initialize(supported)
      super("Please, use Ruby #{supported}")
    end
  end
end
