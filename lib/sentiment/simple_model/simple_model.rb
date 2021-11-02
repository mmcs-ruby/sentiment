# frozen_string_literal: true

module Sentiment
  module SimpleModel
    class SimpleM
      # simple function that receives text and give us splitted to words list of words with their counters
      def simple_input(inp_text)
        inp_text1 = inp_text.downcase.delete "0-9.,;:!?()[]{}''/|"
        text = inp_text1.split
        txt = {} # hash that counts the number of words
        text.each do |word| # counting the number of words
          if txt.key?(word)
            txt[word] += 1 # just one more word
          else txt[word] = 1 # first time for this word
          end
        end
        txt
      end

      # simple function that read text from .txt file by name, for example "example.txt". Works like simple_input
      def simple_input_file(name)
        text = []
        txt = {}

        File.open(name).each do |line| # creating array of all words from text
          line = line.delete "0-9.,;:!?()[]{}''/|"
          lin = line.split
          i = 0
          while i < lin.length
            text << lin[i]
            i += 1
          end
        end

        # all look like simple_input
        text.each do |word|
          word.downcase!
          if txt.key?(word)
            txt[word] += 1
          else txt[word] = 1
          end
        end
        txt
      end

      # this function read list of keywords from .txt file and give as hash with structure as "0: [Hate,Evil,...]",
      # "1: [Sadness]" etc...
      def read_keywords(name)
        keys = Hash.new { |h, k| h[k] = [] }
        i = 0 # i is code of emotion group such as 1: aggressive, 2: sad, 3: happiness
        File.open(name).each do |line|
          keys[i] = line.downcase!.split
          i += 1
        end
        keys
      end

      # this function can give us information about keywords in text and about emotions of speaker. It's oversimplified
      # model. Its receive 2 hashes - keys and processed text
      def simple_sentiment(keys, txt)
        res = {} # there is our result with structure 0:25, 1:5, 2:20... where first value - code of emotion
        # group and second - points of emotion
        i = 0
        while keys.key?(i)
          res[i] = 0
          i += 1
        end
        txt.each_key do |wrd| # for each word in our counted text.split we looking for keyword
          i = 0
          while keys.key?(i)
            j = 0
            while j < keys[i].length
              if keys[i][j] == wrd
                res[i] += 5 * txt[wrd] # i don't know why I multiply points by 5
              end
              j += 1
            end
            i += 1
          end
        end
        res
      end

      # default call procedure for simple sentiment module
      def call_simple_sentiment_default
        keys = read_keywords(File.dirname(__FILE__) + "/keys.txt") # there are results of our keywords and text reading
        txt = simple_input_file(File.dirname(__FILE__) + "/input.txt")

        simple_sentiment(keys, txt)
      end
    end
  end
end
