class OrdersController < ApplicationController
  before_action :set_item

  def index
    @order_address = OrderAddress.new
  end

  def create
    binding.pry

    redirect_to root_path
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end
end
