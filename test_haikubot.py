#!/usr/bin/env python


import unittest
import haikubot as h


class TestGetSyllables(unittest.TestCase):

    def setUp(self):
        self.known_pairs = [('expressive', [u'ex', u'pres', u'sive']),
                            ('excrutiating', [u'ex', u'cru', u'ti', u'at', u'ing']),
                            ('flagrant', [u'fla', u'grant']),
                            ('fornication', [u'for', u'ni', u'ca', u'tion']),
                            ('foo', [u'foo']),
                           ]

    def test_known_pairs(self):
        """Known words/syllable pairs should match get_syllables' output."""
        for word, syllables in self.known_pairs:
            self.assertEqual(h.get_syllables(word), syllables)


class TestGetNumSyllables(unittest.TestCase):

    def setUp(self):
        self.known_pairs = [('expressive', 3),
                            ('excrutiating', 5),
                            ('flagrant', 2),
                            ('fornication', 4),
                            ('foo', 1),
                           ]

    def test_known_pairs(self):
        """Known words/syllable count pairs should match get_num_syllables'
        output."""
        for word, syllables in self.known_pairs:
            self.assertEqual(h.get_num_syllables(word), syllables)


if __name__ == '__main__':
    unittest.main()
