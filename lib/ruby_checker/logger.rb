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

module RubyChecker
  # Logger handles logging by delegating the task:
  #
  # - If we are in Rails, use the default Rails logger.
  # - If we are not in Rails, simply use the `puts` method.
  class Logger
    # warn logs the given message as a warning.
    def warn(msg)
      if defined?(Rails)
        Rails.logger.tagged("ruby_checker") { Rails.logger.warn(msg) }
      else
        puts "[ruby_checker] Warning: #{msg}"
      end
    end
  end
end
