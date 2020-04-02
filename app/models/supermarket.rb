class Supermarket < ApplicationRecord
  has_many :branches
  has_many :order_items

  has_one_attached :photo
end
