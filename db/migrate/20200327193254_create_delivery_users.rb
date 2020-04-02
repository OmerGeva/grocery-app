class CreateDeliveryUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :delivery_users do |t|
      t.string :first_name
      t.string :last_name
      t.references :user, foreign_key: true
      t.integer :phone_number
      t.integer :delivery_price
      t.text :description

      t.timestamps
    end
  end
end
