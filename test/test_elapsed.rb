# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2024-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'minitest/autorun'
require 'loog'
require_relative '../lib/elapsed'

# Test.
# Author:: Yegor Bugayenko (yegor256@gmail.com)
# Copyright:: Copyright (c) 2024-2025 Yegor Bugayenko
# License:: MIT
class TestElapsed < Minitest::Test
  def test_simple
    loog = Loog::Buffer.new
    r =
      elapsed(loog, intro: 'Everything was good') do
        4 + 5
      end
    assert_equal(9, r)
    assert(loog.to_s.include?('was good'))
  end

  def test_with_throw
    loog = Loog::Buffer.new
    elapsed(loog) do
      throw :'Perfectly works'
    end
    assert(loog.to_s.include?('works'))
  end

  def test_to_stdout
    elapsed do
      4 + 5
    end
  end
end
