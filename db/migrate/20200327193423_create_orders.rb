class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :customer, foreign_key: true
      t.references :delivery_user, foreign_key: true
      t.time :time
      t.date :date

      t.timestamps
    end
  end
end
