require "test_helper"

class TokenizationTest < Minitest::Test
  include Sentiment
  include Sentiment::Tokenization
  def test_check_low_t
    result = tokenization("Классификация настроения текста из базы ANEW[3],:
        счастливый - 8.21;
      хороший - 7.47;
      скучный - 2.95;", true, 3)
    puts result
    assert_equal(result, %w[классификация настроения текста базы anew счастливый хороший скучный])
  end

  def test_check_low_f
    result = tokenization("Школьники в Детской компьютерной школе ни в чем не уступают студентам.
  Один вот сегодня на занятии натурально спал, даже свои ФИО не отреагировал!",  false, 3)
    puts result
    assert_equal(result,
                 %w[Школьники Детской компьютерной школе чем уступают студентам Один вот сегодня занятии натурально спал даже свои ФИО
отреагировал])
  end

  def test_check_min_token_size_1
    result = tokenization(
      'Нет повести печальнее на свете: «Мое знакомство с языками программирования началось с того, что в 7 классе в школе нам стали преподавать основы C++»',  true, 1)
    puts result
    assert_equal(result,
                 %w[нет повести печальнее на свете мое знакомство с языками программирования началось с того что в классе в школе нам
стали преподавать основы c])
  end

  def test_check_min_token_size_3
    result = tokenization('Чтобы учить языки программирования, умным быть не обязательно', false, 3)
    puts result
    assert_equal(result, %w[Чтобы учить языки программирования умным быть обязательно])
  end

  def test_check_min_token_size_6
    result = tokenization(
      'Нет повести печальнее на свете: «Мое знакомство с языками программирования началось с того, что в 7 классе в школе нам стали преподавать основы C++»',  true, 6)
    puts result
    assert_equal(result,
                 ["повести", "печальнее", "знакомство", "языками", "программирования", "началось", "классе", "преподавать", "основы"])
  end

  def test_some_special_cases1
    result = tokenization('1) Вам? Везде!
  2) Вы за Протопопова не беспокойтесь!
  3) И это на двести рублей больше, чем он стоит.',  true, 4)
    puts result
    assert_equal(result, %w[везде протопопова беспокойтесь двести рублей больше стоит])
  end

  def test_some_special_cases2
    result = tokenization('01/11/2021|01.11.2021', false, 1)
    puts result
    assert_equal(result, [])
  end

  def test_some_special_cases3
    result = tokenization('Классификация текстов (документов) (англ. Document classification)
  — задача компьютерной лингвистики 1888-1907', false, 3)
    puts result
    assert_equal(result, %w[Классификация текстов документов англ Document classification задача компьютерной лингвистики])
  end

  def test_some_special_cases4
    result = tokenization('светло-розовый, aivanov@gmail.com. Символ: # позволяет закомментировать строки КОДА', false, 0)
    puts result
    assert_equal(result, %w[светло-розовый aivanovgmailcom символ позволяет закомментировать строки кода])
  end
end

