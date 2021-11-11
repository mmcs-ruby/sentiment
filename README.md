[![Build](https://github.com/AKGRif/sentiment/actions/workflows/ci.yml/badge.svg?branch=master)](https://github.com/AKGRif/sentiment/actions/workflows/ci.yml)
<a href="https://codeclimate.com/github/AKGRif/sentiment/maintainability"><img src="https://api.codeclimate.com/v1/badges/1b6e3e773b5f04bc7231/maintainability" /></a>
<a href="https://codeclimate.com/github/AKGRif/sentiment/test_coverage"><img src="https://api.codeclimate.com/v1/badges/1b6e3e773b5f04bc7231/test_coverage" /></a>
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

TODO: 

1)to count frequency of each word in corpus you should use the first function -
words_in_corpus_frequency

Example : 

    input corpus is [%w[кот собак кот],%w[лаб контрольн контрольн семинар]]

    output value : dictionary_frequency ( or hash )

    dictionary_frequency = words_in_corpus_frequency(corpus)
    
    dictionary_frequency is {
      'кот' => 2,'собак' => 1,'лаб' => 1,'контрольн' => 3,
      'семинар' => 1 }

2)to delete words with low (their frequency is lower than min_freq - the third argument) and
high (their frequency is higher than max_freq - the fourth argument) frequency from input corpus 
(the first argument) using dictionary_frequency (the second argument) you should use second function -
delete_words_with_high_and_low_frequency

Example:
    
    input corpus is [%w[рыбак актёр крокодил],%w[крокодил крокодил крокодил актёр],
    %w[актёр рыбак крокодил крокодил],%w[крокодил крокодил актёр],%w[крокодил актёр крокодил],
    %w[крокодил крокодил крокодил]]

    dictionary_frequency = words_in_corpus_frequency(corpus) ( look the first function )

    min_freq = 0.2 (the words with frequency < 0.2 should be deleted)

    max_freq = 0.9 ( we should delete 1-0.9 = 0.1 = 10 % part of word with highest frequency - only one word )

    output value : changed corpus
    
    corpus = delete_words_with_high_and_low_frequency(corpus,dictionary_frequency,min_freq,max_freq)

    changed corpus is   [%w[актёр],
                        %w[крокодил крокодил актёр],
                        %w[актёр крокодил крокодил],
                        %w[крокодил крокодил актёр],
                        %w[крокодил актёр крокодил],
                        %w[крокодил крокодил крокодил]]
    
    
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/sentiment. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/sentiment/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Sentiment project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/sentiment/blob/master/CODE_OF_CONDUCT.md).
