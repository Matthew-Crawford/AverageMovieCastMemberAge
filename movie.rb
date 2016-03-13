# movie.rb
# holds the information about a currently shown movie

class Movie
  attr_accessor :title, :movie_link, :average_age, :cast_list

  # initialize the Movie object
  # @param title: the movie title
  # @param movie_link: the directory path of the movie 
  # @param average_age: average age of the cast
  # @param cast_list: a list of Cast_Member objects
  def initialize(title, movie_link, average_age=0, cast_list=[])
    @title = title
    @movie_link = movie_link
    @average_age = average_age
    @cast_list = cast_list
  end

  # calculates the average age of the cast
  # @return: the average age the cast, false if there are no cast members
  #  with age an age  
  def calculate_average_age
    sum = 0
    cast_list.each do |cast_member|
      sum += cast_member.calculate_age
    end
    if cast_list.count != 0
      sum/cast_list.count
    else
      false
    end
  end

  # displays the average age
  def display_average_age
    puts "Title: #{title} Average Age: #{calculate_average_age}"
  end
end
