class Vendor < ApplicationRecord
	belongs_to :profile
	has_many :employees
end
