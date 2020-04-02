class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name
      t.references :user, foreign_key: true
      t.integer :phone_number

      t.timestamps
    end
  end
end
