require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item, user_id: @user.id)
  end

  describe '商品の出品' do
    context '商品の出品ができる場合' do
      it 'ユーザが紐づいており、全ての項目が存在すれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '商品の出品ができない場合' do
      it 'ユーザが紐づいていなければ出品できない' do
        @item.user_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("User must exist")
      end
      it '商品画像が空では出品できない' do
        item_no_image = Item.new(id: 3, name: 'aaa', content: 'aaa', category_id: 1, condition_id: 1, charge_id: 1, prefecture_id: 1, shipping_id: 1, price: 1000, user_id: @user.id)
        item_no_image.valid?
        expect(item_no_image.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名(name)が空では出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it '商品説明(content)が空では出品できない' do
        @item.content = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Content can't be blank")
      end
      it 'カテゴリー(category_id)が指定されていなければ出品できない' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it '商品の状態(condition_id)が指定されていなければ出品できない' do
        @item.condition_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition can't be blank")
      end
      it '配送料の負担(charge_id)が指定されていなければ出品できない' do
        @item.charge_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Charge can't be blank")
      end
      it '発送元(prefecture_id)が指定されていなければ出品できない' do
        @item.prefecture_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '発送までの日数(shipping_id)が指定されていなければ出品できない' do
        @item.shipping_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping can't be blank")
      end
      it '価格(price)が空では出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it '価格が¥300円より安い価格では出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is out of setting range")
      end
      it '価格が¥9999999円より高い価格では出品できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is out of setting range")
      end
      # 価格の値が半角数値でなければ出品できない
      it '価格の値が全角数値では出品できない' do
        @item.price = '１１１１'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is invalid. Input half-width characters")
      end
      it '価格の値がアルファベットでは出品できない' do
        @item.price = 'aaaa'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is invalid. Input half-width characters")
      end
      it '価格の値が全角文字では出品できない' do
        @item.price = 'あああああ'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is invalid. Input half-width characters")
      end
    end
  end
end
