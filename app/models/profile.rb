class Profile < ApplicationRecord
	belongs_to :user
	has_one :employee
	has_one :vendor
	
	attr_accessor(:email, :password)

	def role
		if user_type == nil
			return "Applicant"
		end

		case user_type
		when 357168
			return "Admin"
		when 3396
			return "Employer"
		when 445
			return "Employee"
		when 2623
  			return "Vendor"
  		else
  			return "Applicant"
  		end
	end

	def self.role_id(key)
		if key == nil
			return 0
		end

		case key.downcase
		when "Admin".downcase
			return 357168
		when "Employer".downcase
			return 3396
		when "Employee".downcase
			return 445
		when "Vendor".downcase
  			return 2623
  		else
  			return 0
  		end
	end

end
