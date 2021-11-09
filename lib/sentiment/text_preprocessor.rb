module Sentiment

  # module which processes tokenized text (list of list of words in their initial form)
  module Text_preprocessor

    # function which gets corpus (tokenized text) and counts word frequency in it
    # returns dictionary where each word is matched with it frequency in corpus
    def words_in_corpus_frequency(corpus)
      # creation of dictionary
      dictionary_frequency = Hash.new(0)

      # finding of frequency of each word in corpus
      corpus.each { 
        |text| text.each {
          |word| dictionary_frequency[word] = dictionary_frequency[word] + 1
        }
      }

      # return res
      dictionary_frequency
    end

    # count quantity of words in corpus and find how many times the most frequent word is found in text
    def count_words_in_corpus_and_most_freq_word(dictionary_frequency,quantity_words_in_corpus,max_freq_quantity_of_word)
      dictionary_frequency.each{
        |hash,value|
        quantity_words_in_corpus = quantity_words_in_corpus + value
        if value > max_freq_quantity_of_word
          max_freq_quantity_of_word = value
        end
      }
      res=[quantity_words_in_corpus,max_freq_quantity_of_word]
      #return 2 values
      res
    end

    # first happening : function deleting word with very low frequency < min_freq
    def delete_word_with_low_frequency(corpus,word)
      corpus.each{
        |text|
        text.each{
          |word2| if word2==word
                    text.delete(word2)
                  end
        }
      }
      #return changed corpus
      corpus
    end

    # second happening : function deleting some of entries of word with highest frequency
    def delete_word_with_high_frequency(corpus,word,count_delete)
      corpus.each{
        |text|
        i=0
        while(i<text.size)
          if text[i] == word
            text.delete_at(i)
            # after we delete word we dec the num of words that should be deleted
            count_delete = count_delete - 1
            i=i-1
          end
          i = i+1
          break if count_delete <= 0 # finish to delete and return res (out corpus)
        end
        break if count_delete <= 0 # finish to delete and return res (out corpus)
      }
      #return changed corpus
      corpus
    end

    # function which deletes words with very high and very low frequency
    # gets dictionary from last function , corpus of texts and two other arguments:
    # min_freq: (determine bottom border of word frequency in corpus,
    # (words with lower freq must be deleted))
    # max_freq:
    # (border of most frequent word in percent
    # (for example if max_freq == 0.9 we should delete 10% of most frequent word in out corpus))
    def delete_words_with_high_and_low_frequency(dictionary_frequency,corpus,min_freq = 0.1,max_freq = 0.9)
      quantity_words_in_corpus = 0.0 # stores how many words in corpus
      max_freq_quantity_of_word = 0 # how many times the most frequent word is found in text
      # count quantity of words in corpus and find how many times the most frequent word is found in text
      values=count_words_in_corpus_and_most_freq_word(dictionary_frequency,quantity_words_in_corpus,max_freq_quantity_of_word)
      # find how many entries the most frequent word we should delete from corpus
      count_delete = (1-max_freq)*values[1]
      # flag that we have already deleted one word
      flag = false

      corpus.each{
        |text| text.each{
          |word|
          # first : we delete word with very low frequency < min_freq
          if dictionary_frequency[word]/values[0] < min_freq
            corpus = delete_word_with_low_frequency(corpus,word)
            # second : we delete some of entries of word with highest frequency
          elsif dictionary_frequency[word] == values[1] and not flag
            corpus = delete_word_with_high_frequency(corpus,word,count_delete)
            flag = true
          end
        }
      }
      # return res (out corpus without words with very high and low frequency)
      corpus
    end
  end
end