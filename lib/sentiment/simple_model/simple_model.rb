module Sentiment
  module Simple_model

    class Simple_m

      #simple function that read text from console and give us splited to words list of words with their counters
      def simple_input()
        text = gets.chomp.split #reading and splitting text
        txt = Hash.new #hash that counts the number of words
        text.each do |word| #counting the number of words
          word.downcase!
          word.delete!("0-9",".",",",";",":","!","?")
          if txt.has_key?(word)
            txt[word]+=1 #just one more word
          else txt[word] = 1 #first time for this word
          end
        end
        return txt
      end

      #simple function that read text from .txt file by name, for example "example.txt". Works like simple_input
      def simple_input_file(name)
        text = Array.new
        txt = Hash.new

        File.open(name).each do |line| #creating array of all words from text
          lin = line.split
          i = 0
          while i< lin.length
            text<<lin[i]
          end
        end

        #all look like simple_input
        text.each do |word|
          word.downcase!
          word.delete!("0-9",".",",",";",":","!","?")
          if txt.has_key?(word)
            txt[word]+=1
          else txt[word] = 0
          end
        end
        return txt
      end

      #this function read list of keywords from .txt file and give as hash with structure as "1: [Hate,Evil,...]", "2: [Sadness]" etc...
      def read_keywords(name)
        keys = Hash.new
        i = 0 # i is code of emotion group such as 1: aggressive, 2: sad, 3: happiness
        File.open(name).each do |line|
          keys[i] << line.downcase!.split
          i+=1
        end
        return keys
      end

      #this function can give us information about keywords in text and about emotions of speaker. It's oversimplified model
      def simple_sentiment()
        name = "keys.txt" #our file with keywords
        keys = read_keywords(name) #there are results of our keywords and text reading
        txt = simple_input_file("input.txt")

        res = Hash.new #there is our result with structure 1:25, 2:5, 3:20... where first value - code of emotion group and second - points of emotion
        txt.each do |wrd| #for each word in our counted text.split we looking for keyword
          i = 0
          while keys.has_key?(i)
            j = 0
            while j<keys[i].length
              if keys[i][j] == wrd
                res[i]+= 5 * txt[wrd] #i don't know why I multiply points by 5
              end
            end
          end
        end
        return res
      end

      #I hope, it can print results to console...
      def proto_print(res)
        res.each do |rs|
          puts rs
        end
      end
      
    end

  end
end