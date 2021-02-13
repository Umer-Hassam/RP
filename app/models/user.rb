class User < ApplicationRecord
	has_one :profile
	

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def is_admin? 
  	return profile.role == "Admin"
  end
  def is_employee? 
  	return profile.role == "Employee"
  end
end
