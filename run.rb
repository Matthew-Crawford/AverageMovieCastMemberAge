require_relative 'cast_member'
require_relative 'movie'
require_relative 'IMDB_Scraper'

def run
	imdb_scraper = IMDB_Scraper.new
	movies = imdb_scraper.get_cast_list(imdb_scraper.get_movies_in_theaters)
	puts movies
	sum = 0
	count = 0 
	movies.each do |movie|
		movie.cast_list.each do |cast_member|
			sum += cast_member.calculate_age
			count += 1 
		end
		movie.average_age = sum/count
		puts movie.average_age
	end
end
run