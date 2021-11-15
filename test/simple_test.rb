# frozen_string_literal: true

require_relative "test_helper"

class SimpleTest < Minitest::Test
  include Sentiment
  include Sentiment::SimpleModel

  def setup
    @keys = { 0 => ["агрессия", "злоба", "гнев"], 1 => ["печаль"], 2 => ["радость", "счастье"] }
    @txt = { "испытываю" => 1, "гнев" => 2, "и" => 2, "печаль" => 1, "меня" => 1, "гложит" => 1, "злоба" => 1 }
    @res = { 0 => 15, 1 => 5, 2 => 0 }
  end

  def test_do_nothing
    assert true
  end

  def test_reading_keys
    assert SimpleM.new.read_keywords(test_files_path("keys.txt")) == @keys
  end

  def test_reading_text_from_file
    assert SimpleM.new.simple_input_file(test_files_path("input.txt")) == @txt
  end

  def test_simple_input
    assert SimpleM.new.simple_input("") == {}
    assert SimpleM.new.simple_input("испытываю гнев и печаль, меня гложит злоба и гнев") == @txt
    assert SimpleM.new.simple_input("ИспытыВаю гНеВ. И пЕчалЬ!, 88меня гложит зл9оба и гнев))") == @txt
  end

  def test_simple_sentiment
    assert SimpleM.new.simple_sentiment(@keys, @txt) == @res
  end

  def test_call_simple_sentiment_default
    assert SimpleM.new.call_simple_sentiment_default == @res
  end
end
