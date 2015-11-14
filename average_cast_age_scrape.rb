require 'mechanize'
require 'ruby-progressbar'
require_relative 'cast_member'

BASE_URL = 'http://www.imdb.com/'
IN_THEATERS = 'http://www.imdb.com/movies-in-theaters'

imdb_scraper = Mechanize.new
movie_titles = []
movies_pages_list = []
cast_members = []
cast_member_page_links = []

imdb_scraper.history_added = Proc.new { sleep 0.2 }

imdb_scraper.get(IN_THEATERS) do |page|
	links = []
	movies_raw = page.search('td.overview-top')
	movies_raw.each do |movie|
		movie_title = movie.search('h4')
		link = movie_title.css('a')[0]
		links << link.attributes['href'].value
		movie_titles << link.attributes['title'].value
	end
	progressbar = ProgressBar.create(:title => " Gathering Movie Links")
	links.each do |movie_page_link|

		increment_amount = 100 / links.count
		progressbar.progress += increment_amount

		link = page.link_with(href: movie_page_link)
		movies_page = link.click
		movies_pages_list << movies_page
	end
end

puts 

progressbar = ProgressBar.create(:title => " Gathering Actor Links")

movies_pages_list.each do |movie_page|
	full_cast_page = movie_page.link_with(text: 'See full cast').click
	increment_amount = 100 / full_cast_page.search('td.itemprop').count
	full_cast_page.search('td.itemprop').each do |cast_list|
		cast_member_link = cast_list.css('a')[0]
		cast_member_page_links << cast_member_link.attributes['href'].value
		cast_members << cast_member_link.text
	end
	progressbar.progress += increment_amount
end

puts 

cast_member_page_links.each do |cast_member|
	begin
		cast_member_page_link = BASE_URL + cast_member
		cast_member_page = imdb_scraper.get(cast_member_page_link)
		birthday_container = cast_member_page.search('#name-born-info')
		birthday = birthday_container.at('time').text.strip
		birthday = birthday.gsub(/\r/, "")
		birthday = birthday.gsub(/\n/, "")
		birthday_month_year = birthday.split(" ")
		birthday_month_year[1] = birthday_month_year[1].gsub(',', '')
		puts birthday_month_year
		puts
	rescue NoMethodError
		puts "This dude/dudette does not have birthday information, continuing"
		next
	end
end