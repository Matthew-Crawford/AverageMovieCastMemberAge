# AverageMovieCastMemberAge
Lists the movies showing in theaters and calculates the average age of the cast for each movie.

## Design Rationale

##### Programming Language
I chose Ruby for this project because I've never tried it before and I figured now would be a great time see what it can do. I also knew web scraping would be necessary, and Ruby's Mechanize library is great for the task.
##### Object Oriented Design
I started with average_cast_age_scrape.rb as a prototype and proof-of-concept for mechanize to scrape IMDB for movies currently showing in theaters. From there I seperated out sections of the script into Ruby methods and created IMDB_Scraper.rb. I also created movie.rb and cast_member.rb, which contains functionality to create Movie objects and Cast_Member objects, respectively. 
##### Threads
Scraping most of the cast members pages for 15-20 movies can result in very long run times as the IMDB_Scraper slogs through hundreds of pages. To alleviate this I assigned a thread for each movie, resulting many threads scraping IMDB in parallel. This reduces run times from several minutes to averaging under a minute.
##### Max and Min Cast Members
I limit the Cast_Member objects to 50 because most of the cast members listed past 50 do not have fleshed out bio's, which usually means no date of birth. This needlessly prolongs runtime. I limit the minimum number of cast members to 3 because there are potential cases where there are only one or two cast members with date of birth information, which would not give a good representation for the average age.
## How to Run On OSX
1. Open the terminal
2. Check to make sure Ruby is installed on your system by typing "ruby -v"
3. If ruby is not installed or up to date, go to https://www.ruby-lang.org/en/documentation/installation/ for instructions on how to install the latest version
4. Clone the program files to your machine by typing "git clone https://github.com/MatthewCrawford0126/AverageCurrentMovieCastMemberAge.git"
5. Navigate to the program directory and type "sudo ./run.sh" in the terminal to install the necessary gems and run the program


