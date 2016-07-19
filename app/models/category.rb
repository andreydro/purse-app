class Category < ActiveRecord::Base
  has_many :incomes,  dependent: :destroy
  has_many :expenses, dependent: :destroy

  validates_presence_of :name

  def name=(val)
    write_attribute(:name, val.upcase)
  end

  def self.categories_names
    all.map(&:name)
  end

end
