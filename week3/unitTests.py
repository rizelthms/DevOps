import unittest
import main


class tests(unittest.TestCase):

    def test_read_csv_should_read_5462_entries(self):
        result = main.read_csv()
        self.assertEqual(len(result), 5462)

    def test_search_should_return_3_elements(self):
        result = main.search([
            {'film_id': '862', 'title': 'Summer Scarface', 'release_year': '1983', 'rating': 'G',
             'actor_name': 'Angelina Astaire'},
            {'film_id': '619', 'title': 'Neighbors Charade', 'release_year': '1983', 'rating': 'R',
             'actor_name': 'Ralph Cruz'},
            {'film_id': '545', 'title': 'Madness Attacks', 'release_year': '1983', 'rating': 'PG-13',
             'actor_name': 'Scarlett Damon'},
            {'film_id': '619', 'title': 'Neighbors Charade', 'release_year': '1983', 'rating': 'R',
             'actor_name': 'Scarlett Damon'},
            {'film_id': '729', 'title': 'Rider Caddyshack', 'release_year': '1983', 'rating': 'PG',
             'actor_name': 'Scarlett Damon'},
            {'film_id': '468', 'title': 'Invasion Cyclone', 'release_year': '1983', 'rating': 'PG',
             'actor_name': 'Woody Jolie'},
            {'film_id': '574', 'title': 'Midnight Westward', 'release_year': '1983', 'rating': 'G',
             'actor_name': 'James Pitt'},
            {'film_id': '729', 'title': 'Rider Caddyshack', 'release_year': '1983', 'rating': 'PG',
             'actor_name': 'James Pitt'},
            {'film_id': '473', 'title': 'Jacket Frisco', 'release_year': '1983', 'rating': 'PG-13',
             'actor_name': 'Charlize Dench'}
        ], 'Scarlett Damon')
        self.assertEqual(len(result), 3)

    def test_transform_should_count_2_james_pitts(self):
        result = main.transform([
            {'film_id': '729', 'title': 'Rider Caddyshack', 'release_year': '1983', 'rating': 'PG',
             'actor_name': 'Scarlett Damon'},
            {'film_id': '468', 'title': 'Invasion Cyclone', 'release_year': '1983', 'rating': 'PG',
             'actor_name': 'Woody Jolie'},
            {'film_id': '340', 'title': 'Frontier Cabin', 'release_year': '1983', 'rating': 'PG-13',
             'actor_name': 'Ben Willis'},
            {'film_id': '574', 'title': 'Midnight Westward', 'release_year': '1983', 'rating': 'G',
             'actor_name': 'James Pitt'},
            {'film_id': '729', 'title': 'Rider Caddyshack', 'release_year': '1983', 'rating': 'PG',
             'actor_name': 'James Pitt'},
            {'film_id': '668', 'title': 'Peak Forever', 'release_year': '1983', 'rating': 'PG',
             'actor_name': 'Kenneth Pesci'},
            {'film_id': '473', 'title': 'Jacket Frisco', 'release_year': '1983', 'rating': 'PG-13',
             'actor_name': 'Charlize Dench'}
        ])
        self.assertEqual(result['James Pitt'], 2)


if __name__ == '__main__':
    unittest.main()
