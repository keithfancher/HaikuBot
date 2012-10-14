#!/usr/bin/env python


import linecache
import random
import re
import sys


WORD_LIST = 'hyph-dict'
LIST_LENGTH = 187175 # we're cheating here -- we know the length of the list


def get_syllables(word):
    """Return a list of syllables in the given word."""
    split_list = re.split('\W', word)
    # the weird ASCII character causes empty strings which we need to remove:
    return filter(None, split_list)


def get_num_syllables(word):
    """Return the number of syllables in a word."""
    return len(get_syllables(word))


def get_random_word(word_list, list_length):
    """Return a random word from the given word list file. Assumes one word per
    line."""
    return linecache.getline(word_list, random.randint(1, list_length)).strip()


def clean_word(word):
    """Our handy dictionary uses ASCII 165 to separate syllables -- this
    function removes them for the output of our... poetry."""
    return filter(lambda x: x != chr(165), word)


def get_haiku_line(syllables):
    """Return a line of haiku with the specified number of syllables."""
    remaining_syllables = syllables
    line = ''
    while(remaining_syllables > 0):
        word = get_random_word(WORD_LIST, LIST_LENGTH)
        syl = get_num_syllables(word)
        if syl <= remaining_syllables: # if the word's too long, ruh roh
            remaining_syllables -= syl
            line += clean_word(word) + ' '
    return line.strip() # kill remaining whitespace


def main():
    """My main() man."""
    print get_haiku_line(5)
    print get_haiku_line(7)
    print get_haiku_line(5)


if __name__ == '__main__':
    main()
