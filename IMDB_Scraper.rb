# IMDB_Scraper.rb
# A web scraping program that searches IMDB for movies
# currently in theaters and retrieves the age of each
# cast member for each movie

require 'mechanize'
require 'ruby-progressbar'
require_relative 'cast_member'
require_relative 'movie'

# A web scraper that scrapes IMDB  
class IMDB_Scraper

	attr_accessor :scraper

	# Default url's 
	BASE_URL = 'http://www.imdb.com/'
	IN_THEATERS = 'http://www.imdb.com/movies-in-theaters'

	def initialize(scraper = Mechanize.new)

		# Instantiates a mechanize object which provides web scraping functionality
		@scraper = scraper

		# Sleeps for .2 seconds every time the scraper does an action
		@scraper.history_added = Proc.new { sleep 0.2 }
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

	# goes to each movie page and instantiates a Cast_Member object for each
	# cast member
	# @param links: the urls of all movie pages currently shown in theaters
	# @return: a list of movies with all valid cast_members in it's cast_list attribute
	def get_cast_list(links)
		movie_list = []
		links.each do |movie|
			full_cast_page = movie.link.link_with(text: 'See full cast').click
			full_cast_page.search('td.itemprop').each do |cast_list|
				cast_member_name = cast_member_link.text
				cast_member_link = cast_list.css('a')[0]
				cast_member_dob = get_cast_member_dob(BASE_URL + cast_member_link)
				if(cast_member_dob != false)
					cast_member = Cast_Member.new(cast_member_name, cast_member_link, 
						cast_member_dob[2], cast_member_dob[1], cast_member_dob[0])
					movie.cast_list << cast_member
					movie_list << movie
				end
			end
		end
		return movie_list
	end	

	# goes to cast member's bio page and returns cast member's dob
	# @param url: the directory path for the actor's bio page
	# @return: an array in the format [day, month, year]
	def get_case_member_dob(url)
		begin
			# gets date of birth container
			cast_member_page = scraper.get(cast_member_page_link)
			birthday_container = cast_member_page.search('#name-born-info')

			# formats the date of birth in 'd mm yyyy'
			birthday = birthday_container.at('time').text.strip
			birthday = birthday.gsub(/\r/, "")
			birthday = birthday.gsub(/\n/, "")
			birthday = birthday.split(" ")
			birthday[1] = birthday_month_year[1].gsub(',', '')

			return birthday

		# catches if there is no date of birth for a given actor
		rescue NoMethodError
			return false
		end
	end

end