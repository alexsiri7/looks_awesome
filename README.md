# LooksAwesome

Looks Awesome helps you write regression tests for the UI of your application.

You only need to add, to your rspec capybara features, `it_looks_awesome`. Looks awesome will take a screenshot the first time you run it, and ask you if it, actually, looks awesome. If it does, you add it to your version control, and following runs check that the page still renders the same way. If anything changes, it shows you the differences and asks if it still looks awesome.

## Installation

Add this line to your application's Gemfile:

    gem 'looks_awesome'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install looks_awesome

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
