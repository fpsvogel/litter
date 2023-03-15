<h1 align="center">Litter</h1>

Litter is a Ruby gem for avid trash-picker-uppers. It parses a log of collected litter.

### Table of Contents

- [Why?](#why)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Why?

Because I enjoy keeping track of interesting items that I find while picking up litter in my neighborhood. Plus, I wanted to try the Parslet gem, which you can read more about in my blog post ["Parsing a litter log: trying out Parslet over regular expressions"](https://fpsvogel.com/posts/2023/ruby-parslet-vs-regex).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'litter'
```

And then execute:

```
$ bundle install
```

Or install it yourself as:

```
$ gem install litter
```

## Usage

To parse a file containing a litter log, use the `litter` command with a path to the file:

```
$ litter ~/path/to/your/litter.txt
```

Currently this command only shows the raw output of the parser, but in the future I may expand the gem to make it show various statistics about the parser output (most-collected items, locations with the most items, etc.).

Here's the example file that is used in the tests, which you can use as a template.

Key:

- `@` location
- `*` quantity
- `#` tag

```
2023/03/08 @west wildwood
car mat
folding chair *2 #kept
concrete-filled bucket @bridge

2023/4/1
concrete-filled bucket *2 @west wildwood #TODO
shopping cart @bridge
car mat #kept
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fpsvogel/litter.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
