# AverageCurrentMovieCastMemberAge
Lists the movies showing in theaters and calculate the average age of the cast for each movie.

## Design Rationale

##### Programming Language
I chose Ruby for this project because I've never tried it before and I figured now would be a great time to try it. I also knew web scraping would be necessary, and Ruby's Mechanize library is great for the task.
##### Object Oriented Design
I started with average_cast_age_scrape.rb as a prototype and proof-of-concept for mechanize to scrape IMDB for movies currently showing in theaters. From there I seperated out sections of the script into Ruby methods and created IMDB_Scraper.rb. I also created movie.rb and cast_member.rb, which contains functionality to create Movie objects and Cast_Member objects, respectively. 

## How to Run It On A Mac
1. If you are on an Apple OSX system, press the command key and space at the same time to open up Spotlight Search
2. Type in "Terminal" and press enter
3. Check to make sure Ruby is installed on your system by typing "ruby -v", the response should include ruby 2.2.1
4. If ruby is not installed or up to date, go to https://www.ruby-lang.org/en/documentation/installation/ for instrunctions on how to install the latest version
5. Type "./run.sh" in the terminal to install the necessary gems and run the program
