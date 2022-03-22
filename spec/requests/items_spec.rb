require 'rails_helper'
# basic認証があるとうまく動かない
RSpec.describe ItemsController, type: :request do
  before do
    @item = FactoryBot.create(:item)
  end

  describe "GET #items" do
    it "indexアクションにリクエストすると正常にレスポンスが返ってくる" do
      get root_path
      expect(response.status).to eq 200
    end
    it 'indexアクションにリクエストするとレスポンスに出品済みの商品が存在する' do 
      get root_path
      expect(response.body).to include(@item.name) 
    end
    it 'indexアクションにリクエストするとレスポンスに出品済の画像URLが存在する' do 
      get root_path
      expect(response.body).to include(@item.image.filename.to_s)
    end
    it 'indexアクションにリクエストすると投稿するアイコンがある' do
      get root_path
      expect(response.body).to include('出品する')
    end
  end
  describe "get #show" do
    it "showアクションにアクセスすると正常にレスポンスが帰ってくる" do
      get item_path(@item.id)
      expect(response.status).to eq 200
    end
    it "showアクションにリクエストすると出品済の商品の名前が存在する" do
      get item_path(@item.id)
      expect(response.body).to include(@item.name)
    end
    it "showアクションにリクエストすると出品済の商品の画像urlが存在する" do
      get item_path(@item.id)
      expect(response.body).to include(@item.image.filename.to_s)
    end
  end
end
