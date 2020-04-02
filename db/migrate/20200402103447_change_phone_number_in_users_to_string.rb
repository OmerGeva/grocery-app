class ChangePhoneNumberInUsersToString < ActiveRecord::Migration[5.2]
  def change
    change_column :customers, :phone_number, :string
    change_column :delivery_users, :phone_number, :string
  end
end
