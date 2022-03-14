class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @items = Item.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to action: :index
    else
      render new_item_path
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def destroy
    binding.pry
  end

private

  def item_params
    params.require(:item).permit(:image, :name, :content, :category_id, :condition_id, :charge_id, :prefecture_id, :shipping_id, :price).merge(user_id: current_user.id)
  end
end
