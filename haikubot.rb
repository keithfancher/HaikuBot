#!/usr/bin/env ruby

# Copyright 2012,2013 Keith Fancher
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

WORD_LIST = 'hyph-dict'
SEP = '•' # separates syllables in the dict

class HaikuBot

  # Pass the 'bot your word list and the character used to separate syllables
  def initialize(word_list, separator)
    @separator = separator
    @words = IO.readlines(word_list)
    @words.map! { |x| x.chomp } # readlines preserves newlines :(
  end

  # Return a full haiku of the 5, 7, 5 variety. Separate each line with
  # specified delimiter.
  def get_haiku(d = "\n")
    "#{get_haiku_line(5)}#{d}#{get_haiku_line(7)}#{d}#{get_haiku_line(5)}#{d}"
  end

  # Return a line of beautiful poetry with the specified number of syllables
  def get_haiku_line(syllables)
    remaining_syllables = syllables
    line = ''
    while remaining_syllables > 0
      word = get_random_word
      syl = get_num_syllables(word)
      if syl <= remaining_syllables and not acronym?(word) and has_vowels?(word) and not has_numbers?(word)
        remaining_syllables -= syl
        line << clean_word(word) + ' '
      end
    end
    line.strip
  end

  private

  # Return true if the word is an acronym, false otherwise
  def acronym?(word)
    # Want to return false if *any* word in the phrase is an acronym, hence \b:
    clean_word(word).match(/\b[A-Z]+\b/) ? true : false
  end

  # Return true if word has vowels! What kind of word doesn't have vowels?!
  def has_vowels?(word)
    word.match(/[aeiouy]/i) ? true : false
  end

  # You guessed it...
  def has_numbers?(word)
    word.match(/[0-9]/) ? true : false
  end

  # Return an array of syllables in the given word, assuming each syllable is
  # properly split in our dictionary
  def get_syllables(word)
    delimiters = /[#{@separator}\s\-]/ # separator, whitespace, hyphens
    word.split(delimiters).reject { |x| x.empty? } # kill empty strings
  end

  # Return number of syllables in a word
  def get_num_syllables(word)
    get_syllables(word).length
  end

  # Return a random word from our list
  def get_random_word
    @words.choice # sample in 1.9 == choice in 1.8
  end

  # Remove the syllable separator characters from a word
  def clean_word(word)
    word.delete(@separator)
  end

end

if __FILE__ == $0
  haiku_bot = HaikuBot.new(WORD_LIST, SEP)
  puts haiku_bot.get_haiku
end
