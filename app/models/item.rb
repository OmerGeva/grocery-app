class Item < ApplicationRecord
  belongs_to :supermarket
  has_many :order_items

  has_one_attached :photo
end
