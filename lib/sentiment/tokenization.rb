
module Sentiment

  module Tokenization
    def tokenization(text, lower, min_token_size)
      tokenized_text = []
      text = text.downcase if lower
      text.gsub!(/[^a-zA-Zа-яА-Я\- ]/, '')
      text_split = text.split
      text_split.each do |i|
        tokenized_text.append(i) if i.size >= min_token_size
      end
      tokenized_text
    end
  end
end
