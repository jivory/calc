class Goal < ActiveRecord::Base
	belongs_to :user
	with_options if: "custom_calories.nil?" do |a|
		a.validates :desired_weight, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1000 } 
		a.validates :age, presence: true, numericality: { greater_than_or_equal_to: 12, less_than_or_equal_to: 100 }
		a.validates :weight, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1000 }
		a.validates :height, presence: true, numericality: { greater_than_or_equal_to: 20, less_than_or_equal_to: 108 }
		a.validates :activity, presence: true
		a.validates :sex, presence: true 
	end
end

