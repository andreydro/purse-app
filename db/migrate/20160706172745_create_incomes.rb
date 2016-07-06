class CreateIncomes < ActiveRecord::Migration
  def change
    create_table :incomes do |t|
      t.integer :incomes

      t.timestamps null: false
    end
  end
end
