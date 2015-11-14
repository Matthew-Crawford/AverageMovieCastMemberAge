class Movie

	attr_accessor :title, :movie_link, :cast_list

	def initialize(title, movie_link, cast_list=[])
		@title = title
		@movie_link = movie_link
		@cast_list = cast_list
	end
end
