class Movie

	attr_accessor :title, :movie_link, :average_age, :cast_list

	def initialize(title, movie_link, average_age=0, cast_list=[])
		@title = title
		@movie_link = movie_link
		@average_age = average_age
		@cast_list = cast_list
	end
end
