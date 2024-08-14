# frozen_string_literal: true

# Copyright (c) 2024 Yegor Bugayenko
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the 'Software'), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

require 'logger'
require 'tago'

# The function measures the time taked by a block to execute and then prints
# it to the log.
#
#  require 'elapsed'
#  elapsed(log) do
#    do_something_slow
#    throw 'It was completed'
#  end
#
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2024 Yegor Bugayenko
# License:: MIT
#
# @param [Object] log The log to send .debug() to
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
