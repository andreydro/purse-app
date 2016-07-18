class CreateIncomes < ActiveRecord::Migration
  def change
    create_table :incomes do |t|
      t.integer :sum
      t.integer :user_id
      t.integer :category_id
      t.date :date

      t.timestamps null: false
    end
  end
end
