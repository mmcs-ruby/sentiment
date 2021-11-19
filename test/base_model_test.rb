
require_relative 'test_helper'

class BaseModelTest < Minitest::Test
  include Sentiment
  include Sentiment::Base

  def test_different_case
    assert_equal( {"hap"=>1, "agr"=>1, "sad"=>0}, base_analysis("./lib/sentiment/test1.txt"))
  end



end
