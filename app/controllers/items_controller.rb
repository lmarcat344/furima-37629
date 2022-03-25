class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :set_item, only: [:show, :destroy, :edit, :update]
  before_action :move_to_index, except: [:index, :show, :new, :create, :search]

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
    @comments = Comment.all
    @comment = Comment.new
  end

  def destroy
    @item.destroy

    redirect_to root_path
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to action: :show
    else
      render :edit
    end
  end

  def search
    @q = Item.ransack(params[:q])
    # ヘッダーの検索フォームから来た場合と検索ページか来た場合に分かれてる
    if params.dig(:q).nil?
      @items = Item.search(params[:keyword])   
    elsif params[:q]&.dig(:name)  # or検索を可能にするための記述
      squished_keywords = params[:q][:name].squish
      params[:q][:name_cont_any] = squished_keywords.split(" ")
      @q = Item.ransack(params[:q])
      @items = @q.result
    else  # 何も入力がない場合
      @items = @q.result
    end
    # render :index
  end
  private

  def item_params
    params.require(:item).permit(:image, :name, :content, :category_id, :condition_id, :charge_id, :prefecture_id, :shipping_id, :price).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    unless (current_user.id == @item.user.id) && @item.order.nil?
      redirect_to action: :index
    end
  end
end
