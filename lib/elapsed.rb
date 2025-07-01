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
# @param [String] good The message to print on success finish
# @param [String] bad The message to print on failure finish
# @param [Integer] level The level of logging to use
def elapsed(log = nil, good: 'Finished', level: Logger::DEBUG, bad: 'Failed')
  start = Time.now
  print_it = lambda do |m|
    m += " in #{start.ago}"
    if log.nil?
      puts m
    elsif level == Logger::DEBUG
      log.debug(m)
    elsif level == Logger::INFO
      log.info(m)
    else
      log.warn(m)
    end
  end
  begin
    ret = yield
    print_it.call(good.to_s)
    ret
  rescue UncaughtThrowError => e
    tag = e.tag
    throw e unless tag.is_a?(Symbol)
    print_it.call(tag.to_s)
  rescue StandardError => e
    print_it.call(bad.to_s)
    raise e
  end
end
