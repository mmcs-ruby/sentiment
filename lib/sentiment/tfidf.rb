# frozen_string_literal: true

module Sentiment

  module TfIdf

    # calculates TF of every word in list
    # returns hash {'word' => TF(word)} without duplicate
    def clcTF(list)
      tf = { }
      count = list.length
      list.each { |cur_word|
        cur_cnt = 0
        list.each { |word|
          if cur_word == word
            cur_cnt += 1.0
          end
        }
        tf[cur_word] = cur_cnt / count
      }
      return tf
    end

    # calculates IDF of every word in list
    # returns hash {'word' => IDF(word)} without duplicate
    def clcIDF(list)
      idf = { }
      count = list.length
      list.each { |cur_word|
        cur_cnt = 0
        list.each { |word|
          if cur_word == word
            cur_cnt += 1.0
          end
        }
        idf[cur_word] = Math.log(count / cur_cnt)
      }
      return idf
    end

    # calculates TF-IDF by using TF and IDF
    # returns hash {'word' => TF-IDF(word)} without duplicate
    private def clcTFIDF_with_TF_and_IDF(tf, idf)
      tfidf = { }
      tf.each { |word|
        tfidf[word[0]] = tf[word[0]] * idf[word[0]]
      }
      return tfidf
    end

    # calculates IDF of every word in list
    # returns hash {'word' => TF-IDF(word)} without duplicate
    def clcTFIDF(list)
      tf = clcTF(list)
      idf = clcIDF(list)
      return clcTFIDF_with_TF_and_IDF(tf, idf)
    end

  end

end