#!/usr/bin/env python


import hyphen
import sys


def get_syllables(word):
    """Return the syllables of a word, as a list. Because
    Hyphenator.syllables() returns [] for words of length <= 3, we have to
    check for the empty list before returning."""
    hyph = hyphen.Hyphenator('en_US')
    syllables = hyph.syllables(unicode(word))
    if not syllables:
        syllables.append(unicode(word))
    return syllables


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
