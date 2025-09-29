# Measures the Time Elapsed by a Block

[![DevOps By Rultor.com](https://www.rultor.com/b/yegor256/elapsed)](https://www.rultor.com/p/yegor256/elapsed)
[![We recommend RubyMine](https://www.elegantobjects.org/rubymine.svg)](https://www.jetbrains.com/ruby/)

[![rake](https://github.com/yegor256/elapsed/actions/workflows/rake.yml/badge.svg)](https://github.com/yegor256/elapsed/actions/workflows/rake.yml)
[![PDD status](https://www.0pdd.com/svg?name=yegor256/elapsed)](https://www.0pdd.com/p?name=yegor256/elapsed)
[![Gem Version](https://badge.fury.io/rb/elapsed.svg)](https://badge.fury.io/rb/elapsed)
[![Test Coverage](https://img.shields.io/codecov/c/github/yegor256/elapsed.svg)](https://codecov.io/github/yegor256/elapsed?branch=master)
[![Yard Docs](https://img.shields.io/badge/yard-docs-blue.svg)](https://rubydoc.info/github/yegor256/elapsed/master/frames)
[![Hits-of-Code](https://hitsofcode.com/github/yegor256/elapsed)](https://hitsofcode.com/view/github/yegor256/elapsed)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](https://github.com/yegor256/elapsed/blob/master/LICENSE.txt)

Here is how you can measure and log the time of a block:

```ruby
require 'elapsed'
elapsed do
  run_something_slow
end
```

You can also send the log message to a log, for example to the
[Loog](https://github.com/yegor256/loog):

```ruby
require 'elapsed'
require 'loog'
elapsed(Loog::VERBOSE) do
  # any code
end
```

You can also make the message custom:

```ruby
elapsed(good: 'File saved') do
  File.save(f, 'Hello, world!')
end
```

Or, you can make the message even more custom:

```ruby
elapsed do
  File.save(f, 'Hello, world!')
  throw :"Successfully saved #{File.size(f)} bytes"
end
```

You can also filter out small durations using the `over:` parameter:

```ruby
elapsed(Loog::VERBOSE, over: 0.5) do
  # This message will only be logged if the block takes more than 0.5 seconds
  run_something_that_might_be_fast
end
```

You can change the level of logging
(use `Logger::INFO`, `Logger::DEBUG`, or `Logger::ERROR`), while
the default one is `DEBUG`:

```ruby
elapsed(Loog::VERBOSE, level: Logger::DEBUG) do
  # The procedure
end
```

That's it.

## How to contribute

Read
[these guidelines](https://www.yegor256.com/2014/04/15/github-guidelines.html).
Make sure your build is green before you contribute
your pull request. You will need to have
[Ruby](https://www.ruby-lang.org/en/) 3.0+ and
[Bundler](https://bundler.io/) installed. Then:

```bash
bundle update
bundle exec rake
```

If it's clean and you don't see any error messages, submit your pull request.
