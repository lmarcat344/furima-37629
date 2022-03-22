require 'rails_helper'

RSpec.describe "Users", type: :system do
  def visit_with_http_auth(path)
    username = ENV["BASIC_AUTH_USER"]
    password = ENV["BASIC_AUTH_PASSWORD"]
  end

  before do
    @user = FactoryBot.build(:user)
  end

  context 'ユーザが正しく登録できる時' do
    it '正しい情報を入力すればユーザー新規登録ができてトップページへ移動する' do
      # トップページへ移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがある
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'nickname', with: @user.nickname
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      fill_in 'password-confirmation', with: @user.password_confirmation
      fill_in 'last-name', with: @user.last_name_zenkaku
      fill_in 'first-name', with: @user.first_name_zenkaku
      fill_in 'last-name-kana', with: @user.last_name_kana
      fill_in 'first-name-kana', with: @user.first_name_kana

      find('#user_birthday_1i').select(@user.birthday.year)
      find('#user_birthday_2i').select(@user.birthday.month)
      find('#user_birthday_3i').select(@user.birthday.day)
      # サインアップボタンを押すとユーザーモデルのカウントが１上がる
      expect{find('input[name="commit"]').click}.to change {User.count}.by(1)

      # トップページへ移動したことを確認する
      expect(current_path).to eq(root_path)
      # トップページにサインアップページに遷移するボタンや、ログインページへ遷移するボタンが表示されていない 
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ユーザが正しく登録できないとき' do
    it 'ユーザーが登録できないとき新規登録ページに戻る' do
      # トップページへ移動する
      visit root_path
      # トップページにサインアップページへ移動するボタンがある
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'nickname', with: ''
      fill_in 'email', with: ''
      fill_in 'password', with: ''
      fill_in 'password-confirmation', with: ''
      fill_in 'last-name', with: ''
      fill_in 'first-name', with: ''
      fill_in 'last-name-kana', with: ''
      fill_in 'first-name-kana', with: ''
      # サインアップボタンを押してもユーザーモデルのカウントが上がらないことを確認する
      expect{find('input[name="commit"]').click}.to change{User.count}.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq user_registration_path
    end
  end
end

RSpec.describe "login", type: :system do
  def visit_with_http_auth(path)
    username = ENV["BASIC_AUTH_USER"]
    password = ENV["BASIC_AUTH_PASSWORD"]
  end

  before do
    @user = FactoryBot.create(:user)
  end

  context 'ログインができるとき' do
    it '保存されているユーザーの情報と合致すればログインができる' do

      #  トップページに移動する 
      visit root_path
      # トップページにログインページへ遷移するボタンがあることを確認する
      expect(page).to have_content("ログイン")
      # ログインページへ遷移する
      visit new_user_session_path
      # 正しいユーザー情報を入力する
      fill_in 'email', with: @user.email
      fill_in 'password', with: @user.password
      # ログインボタンを押す
      find('input[name="commit"]').click
      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)
      # トップページにログアウトボタンが表示されることを確認する
      expect(page).to have_content("ログアウト")
      # サインアップページへ遷移するボタンやログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content("新規登録")
      expect(page).to have_no_content("ログイン")
    end
  end
  context 'ろぐいんできないとき' do
      it '保存されているユーザーの情報と合致しなければログインできない' do     
        # トップページに移動する
        visit root_path
        # トップページにログインページへ遷移するボタンがあることを確認する
        expect(page).to have_content("ログイン")
        # ログインページへ遷移する
        visit new_user_session_path
        # ユーザー情報を入力する
        fill_in 'email', with: ''
        fill_in 'password', with: ''
        # ログインボタンを押す
        find('input[name="commit"]').click
        # ログインページへ戻されることを確認する
        expect(current_path).to eq(new_user_session_path)
      end
  end
end

