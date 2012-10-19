# Copyright 2012 Keith Fancher
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require 'test/unit'
require 'rack/test'
require 'haikubot'
require 'haikubot_web'

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

  def test_with_apostrophes
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

class TestWebInterface < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_index_is_okey_dokey
    get '/'
    assert_equal(200, last_response.status)
    assert(last_response.body.include?('HaikuBot says'))
  end

  def test_raw_haiku_are_okey_dokey
    get '/raw/'
    assert_equal(200, last_response.status)
  end

  def test_raw_haiku_no_slash
    get '/raw'
    assert_equal(200, last_response.status)
  end

  def test_404
    get '/ohmygodthisisgoingtobethebestpageeverijustknowit'
    assert_equal(404, last_response.status)
  end
end
