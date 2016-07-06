class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.integer :expenses

      t.timestamps null: false
    end
  end
end
