class Goal < ActiveRecord::Base
	belongs_to :user
  validates :custom_calories,
						presence: true,
						numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10000 }
end

