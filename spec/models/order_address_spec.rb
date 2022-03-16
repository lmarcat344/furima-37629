require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order = FactoryBot.build(:order_address, user_id: @user.id, item_id: @item.id)
    sleep 0.05
  end

  context '内容に問題ない場合' do
    it "tokenと住所の項目全てがあれば保存ができること" do
      expect(@order).to be_valid
    end
    it "build_addr(建物名)が空でも保存できる" do
      @order.build_addr = ''
      expect(@order).to be_valid
    end
  end

  context '内容に問題がある場合' do
    it "tokenが空では保存ができないこと" do
      @order.token = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("Token can't be blank")
    end
    it "post_code(郵便番号)が空では保存ができないこと" do
      @order.post_code = ''
      @order.valid?
      expect(@order.errors.full_messages).to include("Post code can't be blank")
    end
    it "prefecture_id(都道府県)が指定されていないと保存ができないこと" do
      @order.prefecture_id = 0
      @order.valid?
      expect(@order.errors.full_messages).to include("Prefecture can't be blank")
    end
    it "city(市区町村)が空では保存ができないこと" do
      @order.city = ''
      @order.valid?
      expect(@order.errors.full_messages).to include("City can't be blank")
    end
    it "address1(番地)が空では保存ができないこと" do
      @order.address1 = ''
      @order.valid?
      expect(@order.errors.full_messages).to include("Address1 can't be blank")
    end
    it "phone(電話番号)が空では保存ができないこと" do
      @order.phone = ''
      @order.valid?
      expect(@order.errors.full_messages).to include("Phone can't be blank")
    end
    it "post_codeが「3桁ハイフン4桁」でなければ 保存ができないこと" do
      @order.post_code = '1111111'
      @order.valid?
      expect(@order.errors.full_messages).to include("Post code is invalid. Enter it as follows (e.g. 123-4567)")
    end
    it "post_codeが半角文字列でなければ保存ができないこと" do
      @order.post_code = 'あああ-ああああ'
      @order.valid?
      expect(@order.errors.full_messages).to include("Post code is invalid. Enter it as follows (e.g. 123-4567)")
    end
    # "phoneが10桁以上11桁以内でなければ保存ができないこと"
    it "phoneが10桁より少なければ保存ができないこと" do
      @order.phone = 123456789
      @order.valid?
      expect(@order.errors.full_messages).to include("Phone is too short")
    end
    it "phoneが11桁より多ければ保存ができないこと" do
      @order.phone = 123456789012
      @order.valid?
      expect(@order.errors.full_messages).to include("Phone is too short")
    end
    it "phoneが半角数値でなければ保存ができないこと" do
      @order.phone = '012-3456-89'
      @order.valid?
      expect(@order.errors.full_messages).to include("Phone is invalid. Input only number")
    end
    it "ユーザが紐づいていないと保存ができないこと" do
      @order.user_id = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("User can't be blank")
    end
    it "itemが紐づいていないと保存ができないこと" do
      @order.item_id = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("Item can't be blank")
    end
  end
end
