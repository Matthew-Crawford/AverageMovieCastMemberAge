# cast_member.rb
# provides a way to create cast_members and calculate the cast_member's age

class Cast_Member
	attr_accessor :name, :link, :date_of_birth

	# initialize a Cast_Member object
	# @param name: name of the actor
	# @param link: url link of the actor's page
	# @param date_of_birth: a DateTime object representing the cast member's 
	# date of birth
	def initialize(name, link, date_of_birth)
		@name = name
		@link = link
		@date_of_birth = date_of_birth
	end

	# calculates age based on date of birth and the current date
	# @return: the current age of the cast_member
	def calculate_age
		now = DateTime.now
		age = now.year - date_of_birth.year

		# subtracts 1 from the age if the number of days in the current year
		# is less than the number of days before the cast members' birthday
		if now.yday < date_of_birth.yday
			age -= 1
		end
		return age
	end	

	def display_age(expected_age)
		puts "Expected age: #{expected_age}, Recieved age #{calculate_age}"
	end
end

# simple unit test to test correct age
def test_calculate_age

	matthew_birth = DateTime.new(1994,12,15)
	cast_member = Cast_Member.new("Matthew", "", matthew_birth)
	cast_member.calculate_age
	cast_member.display_age(20)

	dan_birth = DateTime.new(1994, 1, 26)
	cast_member = Cast_Member.new("Dan", "", dan_birth)
	cast_member.calculate_age
	cast_member.display_age(21)
end