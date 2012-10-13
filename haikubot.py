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


def get_random_word(word_list):
    """Return a random word from the given word list file. Assumes one word per
    line."""
    return linecache.getline(word_list, random.randint(1, LIST_LENGTH)).strip()


def main():
    """My main() man."""
#    word = sys.argv[1]
#    print get_syllables(word)
#    print get_num_syllables(word)

    rand_word = get_random_word(WORD_LIST)
    print rand_word
    print get_syllables(rand_word)
    print get_num_syllables(rand_word)


if __name__ == '__main__':
    main()
