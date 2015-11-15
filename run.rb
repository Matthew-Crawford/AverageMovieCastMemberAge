# run.py
# displays the average age for each movie

require_relative 'cast_member'
require_relative 'movie'
require_relative 'IMDB_Scraper'

imdb_scraper = IMDB_Scraper.new
movies = imdb_scraper.get_cast_list_for_all_movies(imdb_scraper.get_movies_in_theaters)
movies.each do |movie_thread|
	movie_thread.value.display_average_age
end