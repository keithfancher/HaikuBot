require 'test/unit'
require 'haikubot'

class TestGetSyllables < Test::Unit::TestCase

  def setup
    @bot = HaikuBot.new(WORD_LIST, SEP)
  end

  def test_one_syllable
    word = 'ducks'
    result = ['ducks']
    assert_equal(result, @bot.send(:get_syllables, word))
  end

  def test_two_syllables
    word = 'lung•worm'
    result = ['lung', 'worm']
    assert_equal(result, @bot.send(:get_syllables, word))
  end

  def test_with_spaces
    word = 'claw ham•mer'
    result = ['claw', 'ham', 'mer']
    assert_equal(result, @bot.send(:get_syllables, word))
  end

  def test_with_hyphens
    word = 'clean-shav•en'
    result = ['clean', 'shav', 'en']
    assert_equal(result, @bot.send(:get_syllables, word))
  end

  def test_with_apostraphes
    word = "can't"
    result = ["can't"]
    assert_equal(result, @bot.send(:get_syllables, word))
  end

end

class TestCleanWord < Test::Unit::TestCase

  def setup
    @bot = HaikuBot.new(WORD_LIST, SEP)
  end

  def test_exactly_what_youd_expect
    word = 'car•bon•ic-ac•id gas'
    result = 'carbonic-acid gas'
    assert_equal(result, @bot.send(:clean_word, word))
  end

end

class TestAcronym < Test::Unit::TestCase

  def setup
    @bot = HaikuBot.new(WORD_LIST, SEP)
  end

  def test_acronym_returns_true
    word = 'LONGACRONYM'
    assert_equal(true, @bot.send(:acronym?, word))
  end

  def test_not_acronym_returns_false
    word = 'place-kick•er'
    assert_equal(false, @bot.send(:acronym?, word))
  end

  def test_combo_returns_false
    word = 'place-kick•er ACRO'
    assert_equal(false, @bot.send(:acronym?, word))
  end

end
