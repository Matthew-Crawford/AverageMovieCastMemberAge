# IMDB_Scraper.rb
# A web scraping program that searches IMDB for movies currently in theaters and retrieves the age of each
# cast member for each movie

require 'mechanize'
require 'ruby-progressbar'
require 'Date'
require 'command_line_reporter'
require_relative 'cast_member'
require_relative 'movie'

# A web scraper that scrapes IMDB  
class IMDB_Scraper
	include CommandLineReporter

	attr_accessor :scraper

	# Default url's 
	BASE_URL = 'http://www.imdb.com/'
	IN_THEATERS = 'http://www.imdb.com/movies-in-theaters'

	def initialize(scraper = Mechanize.new)

		# Instantiates a mechanize object which provides web scraping functionality
		@scraper = scraper

		# Sleeps for .2 seconds every time the scraper does an action
		 @scraper.history_added = Proc.new { sleep 0.5 }
	end	


	# finds all movies currently in theaters
	# @return: the urls of all movie pages currently shown in theaters
	def get_movies_in_theaters
		movie_links = []
		scraper.get(IN_THEATERS) do |page|
			movies_raw = page.search('td.overview-top')
			movies_raw.each do |movie_link|
				link = movie_link.search('h4').css('a')[0]
				movie = Movie.new(link.attributes['title'].value, 
					link.attributes['href'].value)
				movie_links << movie
			end
		end
		return movie_links
	end

	# creates a thread for each movie currently showing in theaters 
	# @param movies: the urls of all movie pages currently shown in theaters
	# @return: a list of movies with all valid cast_members in it's cast_list attribute
	def get_cast_list_for_each_movie(movies)
		movie_list_threads = []
		puts "Getting cast for all movies currently in theaters\n\n"
		progress_bar = ProgressBar.create( :format => '%a %bᗧ%i %p%% %t',
                    :progress_mark  => ' ',
                    :remainder_mark => '･',
                    :total 			=> movies.count)
		movies.each do |movie|
			movie_list_threads << Thread.new {get_cast_list(movie, progress_bar)}
		end

		movie_list_threads.each do |thread|
			thread.join 
		end
		return movie_list_threads
	end	

	# gets the cast members and their date of birth's for each movie
	# @param movie: the cast members' movie
	# @return: the movie with the full cast member list
	def get_cast_list(movie, progress_bar)
		movie_page = scraper.get(BASE_URL + movie.movie_link)
		full_cast_page = movie_page.link_with(text: 'See full cast').click
		cast_member_count = 0
		cast_list = full_cast_page.search('td.itemprop')
		cast_list.each do |cast_member_section|

			# stops after 50 cast_members pages have been visited
			cast_member_count += 1
			if cast_member_count > 50
				break
			end

			cast_member_link = cast_member_section.css('a')[0]
			cast_member_name = cast_member_link.text
			cast_member_dob = get_cast_member_dob(BASE_URL + cast_member_link.attributes['href'].value)

			if(cast_member_dob != false)
				date_of_birth = DateTime.new(cast_member_dob[2].to_i, cast_member_dob[0].to_i, cast_member_dob[1].to_i)
				cast_member = Cast_Member.new(cast_member_name, cast_member_link, date_of_birth)
				movie.cast_list << cast_member
			end
		end
		progress_bar.increment
		return movie
	end

	# goes to cast member's bio page and returns cast member's dob
	# @param url: the directory path for the actor's bio page
	# @return: an array in the format [day, month, year], or false if there isn't
	# birthday listed
	def get_cast_member_dob(url)
		begin
			# gets date of birth container
			cast_member_page = scraper.get(url)
			birthday_container = cast_member_page.search('#name-born-info')

			# formats the date of birth in 'mm d yyyy'
			birthday = birthday_container.at('time').text.strip
			birthday = birthday.gsub(/\r/, "")
			birthday = birthday.gsub(/\n/, "")
			birthday = birthday.split(" ")
			birthday[1] = birthday[1].gsub(',', '')
			birthday[0] = Date::MONTHNAMES.index(birthday[0]) 

			return birthday

		# catches if there is no date of birth for a given actor
		rescue NoMethodError
			return false
		end
	end
end