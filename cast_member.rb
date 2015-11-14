require 'Date'
class Cast_Member
	attr_accessor :name, :link, :dob_day, :dob_month, :dob_year

	def initialize(name, link, dob_year=0, dob_month=0, dob_day=0)
		@name = name
		@link = link
		@dob_day = dob_day
		@dob_month = Date::MONTHNAMES.index(dob_month) 
		@dob_year = dob_year
	end

	# calculates age based on date of birth and the current date
	# @return: the current age of the cast_member
	def calculate_age
		now = DateTime.now
		dob = DateTime.new(dob_year.to_i, dob_month.to_i, dob_day.to_i)
		age = now.year - dob.year

		# subtracts 1 from the age if the number of days in the current year
		# is less than the number of days before the cast members' birthday
		if now.yday < dob.yday
			age--
		end
		return age
	end	

	def display_age
		puts calculate_age
	end
end

# simple unit test to test correct age
def test_calculate_age

	cast_member = Cast_Member.new(1994, "November", 14, "storm of war")
	cast_member.calculate_age
	cast_member.display_age

	cast_member = Cast_Member.new(1994, "January", 26, "Life of Matthew")
	cast_member.calculate_age
	cast_member.display_age
end
