
require_relative 'test_helper'

class BaseModelTest < Minitest::Test
  include Sentiment
  include Sentiment::Base

  def test_different_case
    assert_equal base_analysis("test1.txt"),{"hap"=>1, "agr"=>1, "sad"=>0};
  end



end
