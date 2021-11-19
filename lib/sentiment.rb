# frozen_string_literal: true

require_relative "sentiment/version"
require_relative 'sentiment/tfidf'
require_relative "sentiment/text_preprocessor"
require_relative 'sentiment/Base_model'
require_relative 'sentiment/simple_model/simple_model'

module Sentiment
  class Error < StandardError; end
  # Your code goes here...
end
