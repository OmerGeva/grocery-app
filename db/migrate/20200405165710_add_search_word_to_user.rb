class AddSearchWordToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :searched_word, :string
  end
end
