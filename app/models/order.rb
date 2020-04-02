class Order < ApplicationRecord
  belongs_to :customer
  belongs_to :delivery_user, optional: true
  has_many :order_items
end
