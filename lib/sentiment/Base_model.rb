# frozen_string_literal: true

module Sentiment

  module Base

    def open_file(fn, key)
      text = Hash.new
      File.open(fn).each do |line|
        line.split.each do |n|
          text[n.downcase] = key
        end
      end
      text
    end

    def base_analysis(fn)
      text = open_file(fn, "norm")
      hap_h = open_file("happy.txt", "hap")
      agr_h = open_file("agr.txt", "agr")
      sad_h = open_file("sad.txt", "sad")
      emotions = [*hap_h, *agr_h, *sad_h].to_h
      text_em = text.select { |key, value| emotions.has_key?(key) }
      res = Hash.new
      res["hap"] = 0
      res["agr"] = 0
      res["sad"] = 0
      relax = 0
      emotions.each_pair { |key, value| text_em.key?(key) ? res[value] += 1 : relax += 1 }
      res.each_pair { |key, value| puts "#{key} => #{value}" }
       res
    end
  end
end
