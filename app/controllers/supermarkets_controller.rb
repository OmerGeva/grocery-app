require 'open-uri'
require 'nokogiri'
require 'addressable/uri'

class SupermarketsController < ApplicationController
  before_action :create_profile

  def index
    @supermarkets = policy_scope(Supermarket)
  end

  def show
    @supermarket = Supermarket.find(params[:id])

#############  PARSING   ###################################################################

    if session["searched_word"]
      searched_word = session["searched_word"]
    else
      searched_word = ''
    end
    @items = []
    if @supermarket.name == 'Shufersal'
      url = "https://www.shufersal.co.il/online/he/search?text=#{searched_word}"
      addressable_url = Addressable::URI.encode(url)
      html_file = open(addressable_url).read
      html_doc = Nokogiri::HTML(html_file)

      html_doc.search('.miglog-prod-inStock .textContainer .middleContainer .text').take(15).each_with_index do |element, index|
        @items[index] = []
        @items[index][0] = element.text.strip
      end
      html_doc.search('.miglog-prod-inStock .textContainer .middleContainer .line .price .number').take(10).each_with_index do |element, index|
        @items[index][1] = element.text.strip
      end
      html_doc.search('.miglog-prod-inStock .textContainer .middleContainer .labelsListContainer').take(10).each_with_index do |element, index|
        @items[index][2] = element.text.strip
      end
      html_doc.search('.miglog-prod-inStock .imgContainer img').take(10).each_with_index do |element, index|
        @items[index][3] = element.attribute('src').value
      end
    else
      url = "https://www.ampm.co.il/search/#{searched_word}"
      addressable_url = Addressable::URI.encode(url)
      html_file = open(addressable_url).read
      html_doc = Nokogiri::HTML(html_file)

      html_doc.search('.item').take(10).each_with_index do |element, index|
        p element
        @items[index] = []
        @items[index][0] = element.text.strip
      end
    end

    authorize @supermarket
  end

  def update_searched_word
    @supermarket = Supermarket.find(params[:supermarket_id])
    session["searched_word"] = params["query"]
    redirect_to supermarket_path(@supermarket)

    authorize @supermarket
  end

  private

  def create_profile
    unless current_user.customer || current_user.delivery_user
      redirect_to current_user.role == 'customer' ? new_customer_path : new_delivery_user_path
    end
  end

end
