require 'open-uri'
require 'nokogiri'
require 'addressable/uri'


class Api::V1::SupermarketsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [ :index, :show ]

  # acts_as_token_authentication_handler_for User, only: [ :update, :create, :destroy]
  before_action :set_supermarket, only: [:show, :update, :destroy]
  def index
    @supermarkets = policy_scope(Supermarket)
  end

  def show
    @supermarket = Supermarket.find(params[:id])

#############  PARSING   ###################################################################
    if params[:query]
      current_user.searched_word = params[:query]
    else
      current_user.searched_word = ''
    end
    url = "https://www.shufersal.co.il/online/he/search?text=#{current_user.searched_word}"
    addressableURl = Addressable::URI.encode(url)
    html_file = open(addressableURl).read
    html_doc = Nokogiri::HTML(html_file)

    @items = []
    html_doc.search('.miglog-prod-inStock .textContainer .middleContainer .text').take(10).each_with_index do |element, index|
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

    authorize @supermarket
  end


  def update_searched_word

    @supermarket = Supermarket.find(params[:supermarket_id])
    session["searched_word"] = params["query"]

    render :show
    authorize @supermarket
  end

  private

  def set_supermarket
    @supermarket = Supermarket.find(params[:id])
    authorize @supermarket
  end

  def supermarket_params
    params.require(:supermarket).permit(:name, :address)
  end

  def render_error
    render json: { errors: @supermarket.errors.full_messages },
      status: :unprocessable_entity
  end


end
