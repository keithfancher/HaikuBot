#!/usr/bin/env python


import hyphen
import sys


def get_syllables(word):
    """Return the syllables of a word, as a list."""
    hyph = hyphen.Hyphenator('en_US')
    return hyph.syllables(unicode(word))


def get_num_syllables(word):
    """Return the number of syllables in a word."""
    return len(get_syllables(word))


def main():
    """My main() man."""
    word = sys.argv[1]
    print get_syllables(word)
    print get_num_syllables(word)


if __name__ == '__main__':
    main()
