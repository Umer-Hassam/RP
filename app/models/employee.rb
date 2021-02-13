class Employee < ApplicationRecord
	belongs_to :profile
	
  	has_many :projects
  	has_many :vendors, through: :projects
	
end
