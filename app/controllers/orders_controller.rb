class OrdersController < ApplicationController
  before_action :set_item

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)

    if @order_address.valid?

      Payjp.api_key = "sk_test_279c50d429cd37f239549ba1"
      # Payjp::Charge.create(
      #   amount: @item.price,
      #   card: @order_address.token,
      #   currency: 'jpy'
      # )

      @order_address.save

      return redirect_to root_path
    else
      render :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_address).permit(:post_code, :prefecture_id, :city, :address1, :build_addr, :phone).merge(user_id: @item.user_id, item_id: @item.id, token: params[:token])
  end

end
