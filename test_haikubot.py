#!/usr/bin/env python


import unittest
import haikubot as h


class TestIsAcronym(unittest.TestCase):
    acronyms = ['FUCK', 'ABD', 'YAR', 'IMOGDB', 'ETC']
    not_acronyms = ['blah', 'YAddA', 'Not This One Either!', 'what-ev-er']

    def test_acronyms_returns_true(self):
        for acronym in self.acronyms:
            self.assertTrue(h.is_acronym(acronym))

    def test_not_acronyms_returns_false(self):
        for not_acronym in self.not_acronyms:
            self.assertFalse(h.is_acronym(not_acronym))


if __name__ == '__main__':
    unittest.main()
