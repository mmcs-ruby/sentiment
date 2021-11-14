# Sentiment

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/sentiment`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sentiment'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install sentiment

## Usage

To tokenize list words you need to use function tokenization. As parameters of the function, you must pass: the text that you want to tokenize, a boolean value indicating whether you want to bring all words to the same case (lower), and an integer value - the minimum length of the words that you want to include in the result. The function will return an array of words.

Example:
tokenization('Классификация текстов (документов) (англ. Document classification)
— задача компьютерной лингвистики 1888-1907', false, 3)

function return ["Классификация", "текстов", "документов", "англ", "Document", "classification", "задача", "компьютерной", "лингвистики"]


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/sentiment. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/sentiment/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Sentiment project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/sentiment/blob/master/CODE_OF_CONDUCT.md).
