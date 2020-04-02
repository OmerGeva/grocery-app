require "open-uri"

class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update]

  def show
    @order_items = @order.order_items

    @total_price = 0

    @order_items.each do |order_item|
      @total_price += order_item.item.price * order_item.amount
    end

    authorize @order

  end

  def create
    @order = Order.create(customer: current_user.customer)

    item = Item.find_by(name: params[:name], price: params[:price], description: params[:description])
    if item
      order_item = OrderItem.find_by(item: item)
      if order_item
        order_item.update(amount: order_item.amount += 1)
      else
        order_item = OrderItem.create(item: item, order: @order, amount: 1)
      end
    else
      file = URI.open(params[:img])
      item = Item.create(supermarket: Supermarket.find_by(name: "Shufersal"), name: params[:name], price: params[:price], description: params[:description])
      item.photo.attach(io: file, filename: "#{item.id}.png", content_type: 'image/png')
      item.save
      order_item = OrderItem.create(item: item, order: @order, amount: 1)
    end
    order_item.save
    redirect_to supermarket_path(Supermarket.find_by(name: 'Shufersal'))

    authorize @order
  end

  def update

    item = Item.find_by(name: params[:name], price: params[:price], description: params[:description])
    if item
      order_item = OrderItem.find_by(item: item)
      if order_item
        order_item.update(amount: order_item.amount += 1)
      else
        order_item = OrderItem.create(item: item, order: @order, amount: 1)
      end
    else
      file = URI.open(params[:img])
      item = Item.create(supermarket: Supermarket.find_by(name: "Shufersal"), name: params[:name], price: params[:price], description: params[:description])
      item.photo.attach(io: file, filename: "#{item.id}.png", content_type: 'image/png')
      item.save
      order_item = OrderItem.create(item: item, order: @order, amount: 1)
    end
    order_item.save
    redirect_to supermarket_path(Supermarket.find_by(name: 'Shufersal'))

    authorize @order
  end

  private

  def set_order
    @order = Order.find_by(customer: current_user.customer)
  end
end
