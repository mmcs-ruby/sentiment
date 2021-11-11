# frozen_string_literal: true

require_relative 'test_helper'

class TfIdfTest < Minitest::Test
  include Sentiment
  include Sentiment::TfIdf

  def test_simpleTf
    assert_equal clcTF([1, 2, 3]), {1 => 1.0/3, 2 => 1.0/3, 3 => 1.0/3};
  end

  def test_simpleIdf
    assert_equal clcIDF([1, 2, 3]), {1 => Math.log(3.0), 2 => Math.log(3.0), 3 => Math.log(3.0)};
  end

  def test_simpleTfIdf
    a = 1.0/3 * Math.log(3.0)
    assert_equal clcTFIDF([1, 2, 3]), {1 => a, 2 => a, 3 => a};
  end

  def test_Tf
    assert_equal clcTF([1, 1, 1, 2, 3, 5]), {1 => 0.5, 2 => 1.0/6, 3 => 1.0/6, 5 => 1.0/6};
  end

  def test_Idf
    assert_equal clcIDF([1, 1, 1]), {1 => Math.log(1)};
  end

  def test_TfIdf
    a = 1.0/6 * Math.log(6)
    assert_equal clcTFIDF([1, 1, 1, 2, 3, 5]), {1 => Math.log(2) * 0.5, 2 => a, 3 => a, 5 => a};
  end

  def test_clcTFIDF_with_TF_and_IDF
    list = [1, 1, 2];
    assert_equal clcTFIDF_with_TF_and_IDF(clcTF(list), clcIDF(list)), clcTFIDF(list)
  end

end
