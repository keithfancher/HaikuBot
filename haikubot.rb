#!/usr/bin/env ruby

WORD_LIST = 'hyph-dict'
SEP = 165.chr # separates syllables in the dict

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
      if syl <= remaining_syllables and not acronym?(word)
        remaining_syllables -= syl
        line << clean_word(word) + ' '
      end
    end
    line.strip
  end

  private

  # Return true if the word is an acronym, false otherwise
  def acronym?(word)
    word.match(/^[A-Z]+$/) ? true : false
  end

  # Return an array of syllables in the given word, assuming each syllable is
  # properly split in our dictionary
  def get_syllables(word)
    word.split(/\W/)
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
