require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it '全ての項目が存在すれば登録できる' do
        expect(@user).to be_valid
      end
      it 'last_name_kanaが全角(カタカナ)"ー"有りで登録できる' do
        @user.last_name_kana = 'メアリー'
        expect(@user).to be_valid
      end
      it 'first_name_kanaが全角(カタカナ)"ー"有りで登録できる' do
        @user.first_name_kana = 'メアリー'
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'last_name_zenkakuが空では登録できない' do
        @user.last_name_zenkaku = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name zenkaku can't be blank")
      end
      it 'first_name_zenkakuが空では登録できない' do
        @user.first_name_zenkaku = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name zenkaku can't be blank")
      end
      it 'last_name_kanaが空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'first_name_kanaが空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = 'abcde'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'passwordが半角英数字混合でなければ登録できない' do
        @user.password = 'ああああああ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is invalid. Include both letters and numbers")
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '重複したemailが存在する場合は登録できない' do
        @other_user = FactoryBot.build(:user, email: @user.email)
        @other_user.save
        @user.valid?
        expect(@user.errors.full_messages).to include("Email has already been taken")
      end
      it 'emailは@を含まなければ登録できない' do
        @user.email = 'aaaaaaaaa.com'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it 'last_name_zenkakuが全角(漢字・ひらがな・カタカナ)でなければ登録できない' do
        # アルファベットのテスト
        @user.last_name_zenkaku = 'abcdefg'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name zenkaku is invalid. Input full-width characters")

        # 半角カタカナのテスト
        @user.last_name_zenkaku = 'ｱｲｳｴｵｶ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name zenkaku is invalid. Input full-width characters")

        # 全角アルファベットのテスト
        @user.last_name_zenkaku = 'ａｂｃｄｅｆ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name zenkaku is invalid. Input full-width characters")

      end
      it 'first_name_zenkakuが全角(漢字・ひらがな・カタカナ)でなければ登録できない' do
        # アルファベットのテスト
        @user.last_name_zenkaku = 'abcdefg'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name zenkaku is invalid. Input full-width characters")

        # 半角カタカナのテスト
        @user.last_name_zenkaku = 'ｱｲｳｴｵｶ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name zenkaku is invalid. Input full-width characters")

        # 全角アルファベットのテスト
        @user.last_name_zenkaku = 'ａｂｃｄｅｆ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name zenkaku is invalid. Input full-width characters")

      end
      it 'last_name_kanaが全角(カタカナ)意外では登録できない' do
        # アルファベットのテスト
        @user.last_name_kana = 'abcdefg'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid. Input full-width katakana characters")

        # ひらがなのテスト
        @user.last_name_kana = 'あいうえおか'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid. Input full-width katakana characters")

        # 漢字のテスト
        @user.last_name_kana = '漢字漢字漢字'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid. Input full-width katakana characters")

        # 半角カタカナのテスト
        @user.last_name_kana = 'ｱｲｳｴｵｶ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid. Input full-width katakana characters")

        # 全角アルファベットのテスト
        @user.last_name_kana = 'ａｂｃｄｅｆ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid. Input full-width katakana characters")
      end
      it 'first_name_zenkakuが全角(カタカナ)意外では登録できない' do
        # アルファベットのテスト
        @user.last_name_kana = 'abcdefg'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid. Input full-width katakana characters")

        # ひらがなのテスト
        @user.last_name_kana = 'あいうえおか'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid. Input full-width katakana characters")

        # 漢字のテスト
        @user.last_name_kana = '漢字漢字漢字'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid. Input full-width katakana characters")

        # 半角カタカナのテスト
        @user.last_name_kana = 'ｱｲｳｴｵｶ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid. Input full-width katakana characters")

        # 全角アルファベットのテスト
        @user.last_name_kana = 'ａｂｃｄｅｆ'
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid. Input full-width katakana characters")
      end
    end
  end
end
