require 'rails_helper'

RSpec.describe "商品の出品", type: :system do
  before do
    @item = FactoryBot.create(:item)
    user2 = FactoryBot.create(:user)
  end

  context '商品が出品できるとき' do
    it 'ログインしたユーザは出品ができる' do
      # ログイン
      sign_in(@item.user)
      # トップページに出品ボタンがある
      expect(page).to have_content("出品する")
      # 出品ページへ移動する
      visit new_item_path
      # フォームに情報を入力する
      image_path = Rails.root.join('public/images/test_image.png')
      attach_file('item[image]', image_path)
      fill_in 'item-name', with: @item.name
      fill_in 'item-info', with: @item.content
      fill_in 'item-price', with: @item.price
      find('select[name="item[category_id]"]').select(@item.category.name)
      find('select[name="item[condition_id]"]').select(@item.condition.name)
      find('select[name="item[charge_id]"]').select(@item.charge.name)
      find('select[name="item[prefecture_id]"]').select(@item.prefecture.name)
      find('select[name="item[shipping_id]"]').select(@item.shipping.name)
      # 出品するとitemモデルのカウントが１上がる
      expect{find('input[name="commit"]').click}.to change{Item.count}.by(1)
      # 出品に成功するとトップページへ戻る
      expect(current_path).to eq(root_path)
      # トップページに出品した内容がある（テキスト）
      expect(page).to have_content(@item.name)
      # トップページに出品した内容がある（画像）
      expect(page).to have_selector("img[src$='#{@item.image.filename}']")
    end
  end
  context '商品が出品できないとき' do
    it 'ログインしていないユーザは出品ができない' do
      # トップページに移動する
      visit root_path
      # トップページに出品ボタンがある
      expect(page).to have_content("出品する")
      # 出品ボタンがあり、リンクがあることを確認する
      expect(find("a[class='purchase-btn']")).to have_link(nil, href: "/items/new")
      # 新規登録画面へもどる
      visit new_item_path
      expect(current_path).to eq(new_user_session_path)
    end
  end
end

RSpec.describe "商品詳細ページの表示", type: :system do
  before do
    @item = FactoryBot.create(:item)
    @user2 = FactoryBot.create(:user)
  end
  context '商品詳細ページを表示できるとき' do
    it 'ログインした出品者は商品詳細ページを表示できる' do
      # ログインする
      sign_in(@item.user)
      # トップページに出品した商品が表示されているのを確認
      expect(page).to have_content(@item.name)
      # 商品詳細ページへ移動
      visit item_path(@item.id)
      # 商品詳細ページには出品した商品が表示されている（テキスト）
      expect(page).to have_content(@item.name)
      # 商品詳細ページには出品した商品が表示されている（画像）
      expect(page).to have_selector("img[src$='#{@item.image.filename}']")
      # 編集ボタンがある
      expect(page).to have_content("商品の編集")
      # 削除ボタンがある
      expect(page).to have_content("削除")
      # 商品購入ボタンがない
      expect(page).to have_no_content("購入画面に進む")
    end
    it 'ログインしている出品者でないユーザは商品詳細ページを表示できる' do
      # ログインする
      sign_in(@user2)
      # トップページに出品した商品が表示されているのを確認
      expect(page).to have_content(@item.name)
      # 商品詳細ページへ移動
      visit item_path(@item.id)
      # 商品詳細ページには出品した商品が表示されている（テキスト）
      expect(page).to have_content(@item.name)
      # 商品詳細ページには出品した商品が表示されている（画像）
      expect(page).to have_selector("img[src$='#{@item.image.filename}']")
      # 商品購入ボタンがある
      expect(page).to have_content("購入画面に進む")
      # 編集ボタンがない
      expect(page).to have_no_content("商品の編集")
      # 削除ボタンがない
      expect(page).to have_no_content("削除")
    end
    it 'ログインしていないユーザは商品詳細ページを表示できる' do
      # トップページへ移動 
      visit root_path
      # トップページに商品が表示されている
      expect(page).to have_content(@item.name)
      # 商品詳細ページへ移動
      visit item_path(@item.id)
      # 編集ボタンがないことを確認
      expect(page).to have_no_content("商品の編集")
      # 削除ボタンがないことを確認
      expect(page).to have_no_content("削除")
      # 商品購入ボタンがない事を確認
      expect(page).to have_no_content("購入画面に進む")
    end
  end
end

RSpec.describe "商品を編集", type: :system do
  before do
    @item = FactoryBot.create(:item)
    @user2 = FactoryBot.create(:user)
  end

  context '商品を編集できるとき' do
    it 'ログインした出品者は編集ができる' do
      # 出品したユーザでログインする
      sign_in(@item.user)
      # 商品詳細ページへ移動する
      visit item_path(@item.id)
      # 商品詳細ページに編集ボタンがある
      expect(page).to have_content("商品の編集")
      # 商品編集ページへ移動する
      find('.item-red-btn').click
      expect(current_path).to eq(edit_item_path(@item.id))
      # すでにフォームに内容が入っている
      expect(find('#item-name').value).to eq(@item.name)
      # 出品内容を編集する
      fill_in 'item-name', with: "#{@item.name}+編集"
      # 編集してもitemモデルのカウントは変わらないことを確認する
      expect{find('input[name="commit"]').click}.to change{Item.count}.by(0)
      # 編集が完了すると商品詳細ぺーじへ移動する
      expect(current_path).to eq(item_path(@item.id))
      # 商品詳細ページには編集した内容が存在することを確認する（テキスト）
      expect(page).to have_content(@item.name)
      # 商品詳細ページには編集した内容が存在することを確認する（画像）
      expect(page).to have_selector("img[src$='#{@item.image.filename}']")
    end
  end

  context '商品を編集できないとき' do
    it 'ログインした出品者でないものは編集ができない' do
      # ログインする
      sign_in(@user2)
      # 商品詳細ページへ移動する
      find("img[src$='#{@item.image.filename}']").click
      # 商品詳細ページに編集ボタンがないことを確認する
      expect(page).to have_no_content("商品の編集")
      # 直接商品編集ページへ移動しようとするとトップページへ移動させられる
      visit edit_item_path(@item.id)
      expect(current_path).to eq(root_path)
    end
    it 'ログインしていないユーザは編集ができない' do
      # トップページへ移動する
      visit root_path
      # 商品詳細ページへ移動する
      find("img[src$='#{@item.image.filename}']").click
      # 商品詳細ページには削除ボタンがない事を確認する
      expect(page).to have_no_content("商品の編集")
    end
  end
end

RSpec.describe "商品を削除", type: :system do
  before do
    @item = FactoryBot.create(:item)
    @user2 = FactoryBot.create(:user)
  end

  context '商品を削除できるとき' do
    it 'ログインした出品者は削除ができる' do
      # 出品したユーザでログインする
      sign_in(@item.user)
      # 出品した商品がトップページにある 
      expect(page).to have_selector("img[src$='#{@item.image.filename}']")
      # 商品詳細ページへ移動する
      find("img[src$='#{@item.image.filename}']").click
      # 商品詳細ページに削除ボタンがある
      expect(page).to have_content("削除")
      # 出品内容を削除するとitemカウントが１つ減る
      expect{find('a[class="item-destroy"]').click}.to change{Item.count}.by(-1)
      # 削除が完了するとトップページへ移動する
      expect(current_path).to eq(root_path)
      # 商品詳細ページには削除した内容が存在しないことを確認する（テキスト）
      expect(page).to have_no_content(@item.name)
      # 商品詳細ページには削除した内容が存在しないことを確認する（画像）
      expect(page).to have_no_selector("img[src$='#{@item.image.filename}']")
    end
  end

  context '商品を編集できないとき' do
    it 'ログインした出品者でないものは削除ができない' do
      # 出品者でないユーザでログインする
      sign_in(@user2)
      # 商品詳細ページへ移動する
      find("img[src$='#{@item.image.filename}']").click
      # 商品詳細ページに削除ボタンがないことを確認する
      expect(page).to have_no_content("削除")
      # 直接商品編集ページへ移動しようとするとトップページへ移動させられる
      visit edit_item_path(@item.id)
      expect(current_path).to eq(root_path)
    end
    it 'ログインしていないと削除ができない' do
      # トップページへ移動する
      visit root_path
      # 商品詳細ページへ移動する
      find("img[src$='#{@item.image.filename}']").click
      # 商品詳細ページに削除ボタンがないことを確認する
      expect(page).to have_no_content("削除")
    end
  end
end
