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

require "ruby_checker/logger"
require "rubygems/version"

module RubyChecker
  # Versions performs checks on the given versions (current and supported).
  class Versions
    def initialize(current:, supported:)
      @current   = current
      @supported = supported
      @logger    = Logger.new
    end

    # check! performs tests for the current and the supported versions of
    # ruby. It returns true if nothing bad is happening, false if there was a
    # warning, and it will raise an OutdatedRubyError if the version mismatch
    # is unbearable.
    def check!
      if @current > @supported
        check_newer_versions
      elsif @current < @supported
        check_older_versions!
      else
        true
      end
    end

    protected

    # check_newer_versions performs checks by assuming that the supported
    # version is older than the current one.
    #
    # Returns true if the difference is on the patch level, false otherwise.
    def check_newer_versions
      return true if same_major_minor?

      @logger.warn "Using #{@current}, but #{@supported} is the one supported."
      false
    end

    # check_older_versions! performs checks by assuming that the supported
    # version is newer than the current one.
    #
    # It returns false if the mismatch is only on the patch level, otherwise it
    # will raise an OutdatedRubyError.
    def check_older_versions!
      # Raise an error if this is not a patch-level release mistake, but a major
      # or minor version difference.
      raise OutdatedRubyError, @supported unless same_major_minor?

      # Recommend an upgrade of a patch-level version.
      @logger.warn "Using #{@current}, but #{@supported} is the one supported."
      false
    end

    # same_major_minor returns true of the supported and the current versions
    # match by the major and the minor numbers of the version.
    def same_major_minor?
      if RUBY_ENGINE == "truffleruby"
        @current.to_s.split(".")[0..1] == @supported.to_s.split(".")[0..1]
      else
        @current.canonical_segments[0..1] == @supported.canonical_segments[0..1]
      end
    end
  end
end
