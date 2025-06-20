# frozen_string_literal: true

# SPDX-FileCopyrightText: Copyright (c) 2024-2025 Yegor Bugayenko
# SPDX-License-Identifier: MIT

require 'English'

Gem::Specification.new do |s|
  s.required_rubygems_version = Gem::Requirement.new('>= 0') if s.respond_to? :required_rubygems_version=
  s.required_ruby_version = '>=3.2'
  s.name = 'elapsed'
  s.version = '0.0.0'
  s.license = 'MIT'
  s.summary = 'A simple Ruby function to measure the time elapsed by the execution of a block'
  s.description =
    'You simply pass a code block to the elapsed() function and it will ' \
    'print the summary of execution to the log with the time it took'
  s.authors = ['Yegor Bugayenko']
  s.email = 'yegor256@gmail.com'
  s.homepage = 'https://github.com/yegor256/elapsed'
  s.files = `git ls-files`.split($RS)
  s.executables = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.rdoc_options = ['--charset=UTF-8']
  s.extra_rdoc_files = ['README.md', 'LICENSE.txt']
  s.add_dependency 'loog', '>0'
  s.add_dependency 'tago', '>0'
  s.metadata['rubygems_mfa_required'] = 'true'
end
