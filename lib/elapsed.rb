# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2024-2026 Yegor Bugayenko
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
# Copyright:: Copyright (c) 2024-2026 Yegor Bugayenko
# License:: MIT
#
# @param [Object] log The log to send .debug() to
# @param [String] good The message to print on success finish
# @param [String] bad The message to print on failure finish
# @param [Integer] level The level of logging to use
# @param [Float] over The minimum duration in seconds to report
def elapsed(log = nil, good: 'Finished', level: Logger::DEBUG, bad: nil, over: 0)
  start = Time.now
  print_it = lambda do |m|
    duration = Time.now - start
    return if duration < over

    m += " in #{start.ago}"
    if log.nil?
      puts m
    elsif level == Logger::DEBUG && log.respond_to?(:debug)
      log.debug(m)
    elsif level == Logger::INFO && log.respond_to?(:info)
      log.info(m)
    elsif log.respond_to?(:warn)
      log.warn(m)
    elsif log.respond_to?(:puts)
      log.puts(m)
    else
      raise "The log doesn't accept any logging requests"
    end
  end
  done = false
  begin
    ret = yield
    done = true
    print_it.call(good.to_s)
    ret
  rescue UncaughtThrowError => e
    done = true
    tag = e.tag
    throw e unless tag.is_a?(Symbol)
    print_it.call(tag.to_s)
  rescue StandardError => e
    done = true
    print_it.call((bad || "#{e.message} (#{e.class.name})").to_s)
    raise e
  ensure
    print_it.call(good.to_s) unless done
  end
end
