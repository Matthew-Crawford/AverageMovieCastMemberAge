require_relative 'cast_member'
require_relative 'movie'
require_relative 'IMDB_Scraper'

def run
	movies = get_cast_list(get_movies_in_theaters)
	
end