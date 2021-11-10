# frozen_string_literal: true

require_relative 'test_helper'

class TfIdfTest < Minitest::Test
  include Sentiment
  include Sentiment::TfIdf

  def test_do_nothing
    assert true
  end

  def test_simpleTf
     assert_equal clcTF([1, 2, 3]), {1 => 0, 2 => 0, 3 => 0};
  end

  def test_simpleIdf
    assert_equal clcIDF([1, 2, 3]), {1 => 0, 2 => 0, 3 => 0};
  end

  def test_simpleTfIdf
    assert_equal clcTFIDF([1, 2, 3]), {1 => 0, 2 => 0, 3 => 0};
  end
end
