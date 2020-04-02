class User < ApplicationRecord
  acts_as_token_authenticatable

  has_one :customer
  has_one :delivery_user
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :role, presence: true

end
