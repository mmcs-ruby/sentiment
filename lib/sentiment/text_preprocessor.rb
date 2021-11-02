module Sentiment

  # module which processes tokenized text (list of list of words in their initial form)
  module Text_preprocessor

    # function which gets corpus (tokenized text) and counts word frequency in it
    # returns dictionary where each word is matched with it frequency in corpus
    def words_in_corpus_frequency(corpus)
      # creation of dictionary
      dictionary_frequency = {}

      # initialize counting for each word in corpus
      corpus.each {
        |text| text.each {
          |word| dictionary_frequency[word] = 0
        }
      }

      # finding of frequency of each word in corpus
      corpus.each {
        |text| text.each {
          |word| dictionary_frequency[word] = dictionary_frequency[word] + 1
        }
      }

      # return res
      dictionary_frequency
    end

    # function which deletes words with very high and very low frequency
    # gets dictionary from last function , corpus of texts and two other arguments:
    # min_freq: (determine bottom border of word frequency in corpus,
    #     (words with lower freq must be deleted))
    # max_freq:
    # (border of most frequent word in percent
    # (for example if max_freq == 0.9 we should delete 10% of most frequent word in out corpus))
    def delete_words_with_high_and_low_frequency(dictionary_frequency,corpus,min_freq = 0.1,max_freq = 0.9)
      quantity_words_in_corpus = 0.0 # stores how many words in corpus
      max_freq_quantity_of_word = 0 # how many times the most frequent word is found in text

      # count quantity of words in corpus and find how many times the most frequent word is found in text
      dictionary_frequency.each{
        |hash,value|
        quantity_words_in_corpus = quantity_words_in_corpus + value
        if value > max_freq_quantity_of_word
          max_freq_quantity_of_word = value
        end
      }

      # find how many entries the most frequent word we should delete from corpus
      count_delete = (1-max_freq)*max_freq_quantity_of_word

      # flag that we have already deleted one word
      flag = false

      # first : we delete word with very low frequency < min_freq
      corpus.each{
        |text| text.each{
          |word|
          if dictionary_frequency[word]/quantity_words_in_corpus < min_freq
            corpus.each{
              |text2|
              text2.each{
                |word2| if word2==word
                          text2.delete(word)
                        end
              }
            }
            # second : we delete some of entries of word with highest frequency
          elsif dictionary_frequency[word] == max_freq_quantity_of_word and not flag
            corpus.each{
              |text2|
              i=0
              text2.each{
                |word2|
                if word2 == word
                  text2.delete_at(i)
                  # after we delete word we dec the num of words that should be deleted
                  count_delete = count_delete - 1
                  if count_delete <= 0
                    flag = true
                  end
                end
                i = i+1
                break if count_delete <= 0 # finish to delete and return res (out corpus)
              }
              break if count_delete <= 0 # finish to delete and return res (out corpus)
            }
            #break if count_delete<=0 # finish to delete and return res (out corpus)
          end
        }
      }
      # return res (out corpus without words with very high and low frequency)
      corpus
    end
  end
end