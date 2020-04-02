class CreateBranches < ActiveRecord::Migration[5.2]
  def change
    create_table :branches do |t|
      t.references :supermarket, foreign_key: true
      t.string :address

      t.timestamps
    end
  end
end
