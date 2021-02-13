class Vendor < ApplicationRecord
	belongs_to :profile
	#has_many :employees

  	has_many :projects
  	has_many :employees, through: :projects
end
