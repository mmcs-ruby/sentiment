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


To tokenize list words you need to use function tokenization. As parameters of the function, you must pass: the text that you want to tokenize, a boolean value indicating whether you want to bring all words to the same case (lower), and an integer value - the minimum length of the words that you want to include in the result. The function will return an array of words.

Example:
tokenization('Классификация текстов (документов) (англ. Document classification)
— задача компьютерной лингвистики 1888-1907', false, 3)

function return ["Классификация", "текстов", "документов", "англ", "Document", "classification", "задача", "компьютерной", "лингвистики"]

Sentiment Simple Model Module:

This is the list of simple functions, that you can use for preliminary simple sentiment analysis of your text file or input string.

It consists of:

simple_input(inp_text). This function has input string (named inp_text). It returns processed text in hash, that consists of: key and value, where key is word in text and value - frequency of this word. 
Example: input = "My name is Deleted Name". Result = { "my" => 1, "name" => 2, "is" => 1, "deleted" => 1 }
Usage example: ProcessedText = SimpleM.new.simple_input("My name is Deleted Name")

simple_input_file(name). This function works like previous, but it takes name of your text file in input parameter called "name".
Usage example: ProcessedText = SimpleM.new.simple_input_file("text.txt")

read_keywords(name). This function reads groups of your emotional keywords for sentiment analysis from your text file in input parameter called "name". File consists of strings whith different words. One string in this file is one emotional group. Words in every string must be splitted by ' '. It returns hash where key is number of emotional group. And value is array of words from this emotional group. This hash is our database for sentiment analysis of your text.
Example:
keywords.txt
(your file)
Агрессия Злоба гнев
печаЛЬ
радость счастье
(end of your file) ===> { 0 => ["агрессия", "злоба", "гнев"], 1 => ["печаль"], 2 => ["радость", "счастье"] }
Usage example: keys = SimpleM.new.read_keywords("keywords.txt")

simple_sentiment(keys, txt). This function can give us information about keywords in text and about emotions of speaker. It's oversimplified model. Its receive 2 hashes - keys and processed text. This hashes are results of work of our previous functions. Result of this function is... hash! Key of hash is number of emotional group, value is number of emotional point for this key on this text.
Usage example + example:
keys = { 0 => ["агрессия", "злоба", "гнев"], 1 => ["печаль"], 2 => ["радость", "счастье"] }
txt = { "испытываю" => 1, "гнев" => 2, "и" => 2, "печаль" => 1, "меня" => 1, "гложит" => 1, "злоба" => 1 }
res = SimpleM.new.simple_sentiment(keys, txt)
res ===> { 0 => 15, 1 => 5, 2 => 0 }

call_simple_sentiment_default. This function just calls previous function with default parameters.
Usage example: res = SimpleM.new.call_simple_sentiment_default

To vectorize a list of word you need:


• If you want to vectorize by TF, use clcTF(list) method.
list - is list of words from text. Method will return hash, which
look like {word1 => TF(word1), word2 => TF(word2), ... } without duplicate;

• If you want to vectorize by IDF, use clcIDF(list) method.
list - is list of words from text. Method will return hash, which
look like {word1 => IDF(word1), word2 => IDF(word2), ... } without duplicate;

• If you want to vectorize by TF-IDF, use clcTFIDF(list) method.
list - is list of words from text. Method will return hash, which
look like {word1 => TF-IDF(word1), word2 => TF-IDF(word2), ... } without duplicate.

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
