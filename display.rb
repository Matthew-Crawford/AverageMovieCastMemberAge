# display.rb
# scrapes IMDB for all movies currently showing in theaters
# and displays their associated average cast member age

require_relative 'cast_member'
require_relative 'movie'
require_relative 'IMDB_Scraper'
require 'command_line_reporter'

class Display
	include CommandLineReporter

	# runs IMDB_Scaper and displays the results
	def run
		min_cast_member_number = 3

		imdb_scraper = IMDB_Scraper.new
		movies = imdb_scraper.get_cast_list_for_each_movie(imdb_scraper.get_movies_in_theaters)
		puts

		header :title => "Average Age of Cast of Movies Currently in Theaters",
			 :width => 100, :bold => true

		table(:border => true) do
			sum_age = 0
			count = 0
			row  do
				column 'Title', :width => 30, :align => 'center'
				column 'Average Age', :width => 25, :padding => 5
			end

			movies.each do |movie_thread|
				movie = movie_thread.value
				movie.average_age = movie.calculate_average_age

				# skips the movie if the minimum cast_member number is
				# not met
				if movie.cast_list.count < min_cast_member_number
					next
				end
				row do
					column movie.title
					column movie.average_age
				end
				sum_age += movie.average_age
				count += 1
			end	

			average_age_all_movies = sum_age/count
			row do
				column 'Average Age of All Movies'
				column average_age_all_movies
			end
		end
	end
end
Display.new.run