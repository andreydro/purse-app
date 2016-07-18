class Expense < ActiveRecord::Base
  belongs_to :user
  belogns_to :category

  validates_presence_of :sum, :category, :date

end
