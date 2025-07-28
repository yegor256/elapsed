# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2024-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'loog'
require_relative 'test__helper'
require_relative '../lib/elapsed'

# Test.
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2024-2025 Yegor Bugayenko
# License:: MIT
class TestElapsed < Minitest::Test
  def test_simple
    loog = Loog::Buffer.new
    r =
      elapsed(loog, good: 'Everything was good') do
        4 + 5
      end
    assert_equal(9, r)
    assert_includes(loog.to_s, 'was good')
  end

  def test_with_failure
    loog = Loog::Buffer.new
    assert_raises(StandardError) do
      elapsed(loog, bad: 'Failed miserably') do
        raise 'oops'
      end
    end
  end

  def test_with_throw
    loog = Loog::Buffer.new
    elapsed(loog) do
      throw :'Perfectly works'
    end
    assert_includes(loog.to_s, 'works')
  end

  def test_to_stdout
    elapsed do
      4 + 5
    end
  end

  def test_with_over_threshold_reports
    loog = Loog::Buffer.new
    elapsed(loog, over: 0.001) do
      sleep(0.01)
    end
    assert_includes(loog.to_s, 'Finished')
  end

  def test_with_over_threshold_does_not_report
    loog = Loog::Buffer.new
    elapsed(loog, over: 1.0) do
      4 + 5
    end
    assert_equal('', loog.to_s)
  end

  def test_with_over_threshold_on_error_reports
    loog = Loog::Buffer.new
    assert_raises(StandardError) do
      elapsed(loog, over: 0.001, bad: 'Error occurred') do
        sleep(0.01)
        raise 'error'
      end
    end
    assert_includes(loog.to_s, 'Error occurred')
  end

  def test_with_over_threshold_on_error_does_not_report
    loog = Loog::Buffer.new
    assert_raises(StandardError) do
      elapsed(loog, over: 1.0, bad: 'Error occurred') do
        raise 'error'
      end
    end
    assert_equal('', loog.to_s)
  end

  def test_with_over_threshold_on_throw_reports
    loog = Loog::Buffer.new
    elapsed(loog, over: 0.001) do
      sleep(0.01)
      throw :done
    end
    assert_includes(loog.to_s, 'done')
  end

  def test_with_over_threshold_on_throw_does_not_report
    loog = Loog::Buffer.new
    elapsed(loog, over: 1.0) do
      throw :done
    end
    assert_equal('', loog.to_s)
  end
end
