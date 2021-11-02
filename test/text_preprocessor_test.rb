require_relative "test_helper"

class Text_preprocessor_test < Minitest::Test
  include Sentiment
  include Sentiment::Text_preprocessor

  def setup

    #test1

    @corpus11 = [%w[кот собак кот],%w[лаб контрольн контрольн семинар],%w[экзамен сесс контрольн сесс]]
    @dictionary11 = words_in_corpus_frequency(@corpus11) # count words' frequency in @corpus11

    @corpus12 = [[],[],[]]
    @dictionary12 = words_in_corpus_frequency(@corpus12) # count words' frequency in @corpus12

    @corpus13 = [%w[стол диван диван дирижабл стол]]
    @dictionary13 = words_in_corpus_frequency(@corpus13) # count words' frequency in @corpus13

    @corpus14 = [%w[Иркутск], %w[кино], %w[ИркутскИркутск кино], %w[алтарь молодость Иркутск]]
    @dictionary14 = words_in_corpus_frequency(@corpus14) # count words' frequency in @corpus14

    @corpus15 = [%w[ехал Грека через реку видит Грека в реке рак сунул в реку руку Грека
                рак за руку Греку в реку]]
    @dictionary15 = words_in_corpus_frequency(@corpus15) # count words' frequency in @corpus15

    #test2

    @corpus21 = [%w[рыбак актёр крокодил],%w[крокодил крокодил крокодил актёр],%w[актёр рыбак крокодил крокодил],
    %w[крокодил крокодил актёр],%w[крокодил актёр крокодил],%w[крокодил крокодил крокодил]]
    @dictionary21 = words_in_corpus_frequency(@corpus21) # count words' frequency in @corpus21

    # delete words with high and low frequency in @corpus21
    @out_corpus21 = delete_words_with_high_and_low_frequency(@dictionary21,@corpus21,0.2,0.9)

    @corpus22 = []
    @dictionary22 = words_in_corpus_frequency(@corpus22) # count words' frequency in @corpus22

    # delete words with high and low frequency in @corpus22
    @out_corpus22 = delete_words_with_high_and_low_frequency(@dictionary22,@corpus22,0.2,0.9)

    @corpus23 = [%w[лодж лифт дириж дириж],%w[дириж дириж данж данж],%w[данж лифт дириж данж]]
    @dictionary23 = words_in_corpus_frequency(@corpus23) # count words' frequency in @corpus23

    # delete words with high and low frequency in @corpus23
    @out_corpus23 = delete_words_with_high_and_low_frequency(@dictionary23,@corpus23,0.2,0.9)

    @corpus24 = [%w[лев комод комод],%w[комод комод кран кран],%w[кран лев кран]]
    @dictionary24 = words_in_corpus_frequency(@corpus24) # count words' frequency in @corpus24

    # delete words with high and low frequency in @corpus24
    @out_corpus24 = delete_words_with_high_and_low_frequency(@dictionary24,@corpus24,0.3,0.4)

    @corpus25 = [%w[мяч круг круг],%w[квадрат квадрат мяч]]
    @dictionary25 = words_in_corpus_frequency(@corpus25) # count words' frequency in @corpus25

    # delete words with high and low frequency in @corpus25
    @out_corpus25 = delete_words_with_high_and_low_frequency(@dictionary25,@corpus25,0.1,0.95)
  end

  #  test 1 : checks the work of function for counting of words' frequency in corpus
  def test_words_in_corpus_frequency
    assert_equal @dictionary11 , {
      'кот' => 2,'собак' => 1,'лаб' => 1,'контрольн' => 3,
      'семинар' => 1,'экзамен' => 1, 'сесс' => 2 }

    assert_equal @dictionary12 , {}

    assert_equal @dictionary13 , {
      'стол' => 2,'диван' => 2,'дирижабл' => 1 }

    assert_equal @dictionary14 , {
      'Иркутск' => 2,'кино' => 2,'ИркутскИркутск' => 1,
      'алтарь' => 1, 'молодость' => 1}

    assert_equal @dictionary15, {"ехал"=>1, "Грека"=>3, "через"=>1, "реку"=>3,
                                 "видит"=>1, "в"=>3, "реке"=>1, "рак"=>2, "сунул"=>1,
                                 "руку"=>2, "за"=>1, "Греку"=>1}
  end


  # test 2 : checks the work of function for deleting of words with very high and low frequency in corpus
  def test_deleting_of_words_having_in_corpus_high_and_low_frequency
     assert_equal @out_corpus21, [%w[актёр],
                                  %w[крокодил крокодил актёр],
                                  %w[актёр крокодил крокодил],
                                  %w[крокодил крокодил актёр],
                                  %w[крокодил актёр крокодил],
                                  %w[крокодил крокодил крокодил]]
     assert_equal @out_corpus22, []

     assert_equal @out_corpus23, [%w[дириж], %w[дириж дириж данж данж], %w[данж дириж данж]]

     assert_equal @out_corpus24, [%w[],%w[комод кран кран],%w[кран кран]]

     assert_equal @out_corpus25, [%w[круг круг],%w[квадрат квадрат мяч]]
  end
end