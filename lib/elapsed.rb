# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2024-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'logger'
require 'tago'

# The function measures the time taken by a block to execute and then prints
# it to the log.
#
#  require 'elapsed'
#  elapsed(log) do
#    do_something_slow
#    throw 'It was completed'
#  end
#
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2024-2025 Yegor Bugayenko
# License:: MIT
#
# @param [Object] log The log to send .debug() to
# @param [String] intro The message to start with
# @param [Integer] level The level of logging to use
def elapsed(log = nil, intro: 'Finished', level: Logger::DEBUG)
  start = Time.now
  begin
    ret = yield
    msg = intro.to_s
    msg += " in #{start.ago}"
    if log.nil?
      puts msg
    elsif level == Logger::DEBUG
      log.debug(msg)
    elsif level == Logger::INFO
      log.info(msg)
    else
      log.warn(msg)
    end
    ret
  rescue UncaughtThrowError => e
    tag = e.tag
    throw e unless tag.is_a?(Symbol)
    msg = "#{tag} in #{start.ago}"
    if log.nil?
      puts msg
    elsif level == Logger::DEBUG
      log.debug(msg)
    elsif level == Logger::INFO
      log.info(msg)
    else
      log.warn(msg)
    end
  end
end
