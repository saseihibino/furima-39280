require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザ新規登録' do
    context '新規登録できる場合' do
      it '必要な情報を適切に入力すれば登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it 'nick_nameが空では登録できない' do
        @user.nick_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("ニックネームを入力してください")
      end

      it 'emailは空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Eメールを入力してください")
      end

      it 'emailは重複していては登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end

      it 'emailは@含まないと登録できない' do
        @user.email = 'testmail'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end

      it 'passwordは空では登録できない' do
        @user.password = ''
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワードを入力してください")
      end

      it 'passwordは6文字以上じゃないと登録できない' do
        @user.password = 'a1234'
        @user.password_confirmation = 'a1234'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end

      it 'passwordは数字のみでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end

      it 'passwordは英字のみでは登録できない' do
        @user.password = 'abcdefg'
        @user.password_confirmation = 'abcdefg'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end

      it 'passwordは全角を含むpasswordでは登録できない' do
        @user.password = 'abcdefｇ'
        @user.password_confirmation = 'abcdefｇ'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは不正な値です')
      end

      it 'password_confirmationはpasswordと一致しなけれな登録できない' do
        @user.password = 'a123456'
        @user.password_confirmation = 'a1234567'
        @user.valid?
        expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
      end

      it 'first_nameは空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(名字)を入力してください")
      end

      it 'first_nameは全角（漢字・ひらがな・カタカナ）じゃないと登録できない（英数字の場合）' do
        @user.first_name = 'Yamada123'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(名字)は不正な値です')
      end

      it 'first_nameは全角（漢字・ひらがな・カタカナ）じゃないと登録できない（半角の場合）' do
        @user.first_name = 'ﾔﾏﾀﾞ'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(名字)は不正な値です')
      end

      it 'last_nameは空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前(名前)を入力してください")
      end

      it 'last_nameは全角（漢字・ひらがな・カタカナ）じゃないと登録できない（英数字の場合）' do
        @user.last_name = 'Tarou123'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(名前)は不正な値です')
      end

      it 'last_nameは全角（漢字・ひらがな・カタカナ）じゃないと登録できない（半角の場合）' do
        @user.last_name = 'ﾀﾛｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(名前)は不正な値です')
      end

      it 'first_name_kanaは空では登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ(名字)を入力してください")
      end

      it 'first_name_kanaはカタカナじゃないと登録できない（英数字の場合）' do
        @user.first_name_kana = 'Yamada123'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ(名字)は不正な値です')
      end

      it 'first_name_kanaはカタカナじゃないと登録できない（半角の場合）' do
        @user.first_name_kana = 'ﾔﾏﾀﾞ'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ(名字)は不正な値です')
      end

      it 'first_name_kanaはカタカナじゃないと登録できない（ひらがなの場合）' do
        @user.first_name_kana = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ(名字)は不正な値です')
      end

      it 'first_name_kanaはカタカナじゃないと登録できない（漢字の場合）' do
        @user.first_name_kana = '山田'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ(名字)は不正な値です')
      end

      it 'last_name_kanaは空では登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("お名前カナ(名前)を入力してください")
      end

      it 'last_name_kanaはカタカナじゃないと登録できない（英数字の場合）' do
        @user.last_name_kana = 'Tarou123'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ(名前)は不正な値です')
      end

      it 'last_name_kanaはカタカナじゃないと登録できない（半角の場合）' do
        @user.last_name_kana = 'ﾀﾛｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ(名前)は不正な値です')
      end

      it 'last_name_kanaはカタカナじゃないと登録できない（ひらがなの場合）' do
        @user.last_name_kana = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ(名前)は不正な値です')
      end

      it 'last_name_kanaはカタカナじゃないと登録できない（漢字の場合）' do
        @user.last_name_kana = '太郎'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前カナ(名前)は不正な値です')
      end

      it 'birth_dateは空では登録できない' do
        @user.birth_date = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("生年月日を入力してください")
      end
    end
  end
end
