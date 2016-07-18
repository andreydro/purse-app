class Income < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

  validates_presense_of :sum, :category, :date
end
