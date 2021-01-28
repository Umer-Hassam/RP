class Employee < ApplicationRecord
	has_many :work_durations
	belongs_to :profile
	belongs_to :vendor, optional: true

	def weekly_hours_worked
		hours_worked = 0

		today = Date.today # Today's date %>
		days_from_this_week = (today.at_beginning_of_week..today.at_end_of_week).map
		
		for day in (today.at_beginning_of_week..today.at_end_of_week).map.each { |day| day } do
			start_time = DateTime.parse(day.to_s)
			hours = work_durations.where('work_day = ?', start_time)
    		
			if hours.count > 0
				puts "START: " + profile.full_name + ", " + start_time.strftime(" %b %e") + ", " + hours.first.hours.to_s
				hours_worked += hours.first.hours
			end
		end

		return hours_worked
	end
	
end
