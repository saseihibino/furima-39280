require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  before do 
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @order_address = FactoryBot.build(:order_address, user_id: user.id, item_id: item.id) 
  end

  describe '購入情報の保存' do
    context '保存できる場合' do
      it 'すべての情報が正しく入力されていれば保存できる' do
        expect(@order_address).to be_valid
      end

      it '建物名が空でも保存できる' do
        @order_address.building_name = ''
        expect(@order_address).to be_valid
      end
    end

    context '保存できない場合' do
      it '郵便番号は空では保存できない' do
        @order_address.post_code = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("郵便番号を入力してください")
      end

      it '郵便番号はハイフン無しでは保存できない' do
        @order_address.post_code = '1234567'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('郵便番号は不正な値です')
      end

      it '郵便番号は全角文字列では保存できない' do
        @order_address.post_code = '１２３-４５６７'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('郵便番号は不正な値です')
      end

      it '都道府県は選択しないと保存できない' do
        @order_address.prefecture_id = 0
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include('都道府県は0以外の値にしてください')
      end

      it '市区町村は空では保存できない' do
        @order_address.city = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("市区町村を入力してください")
      end

      it '番地は空では保存できない' do
        @order_address.house_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("番地を入力してください")
      end

      it '電話番号は空では保存できない' do
        @order_address.telephone_number = ''
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号を入力してください")
      end

      it '電話番号は10桁以下では保存できない' do
        @order_address.telephone_number = '123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号は不正な値です")
      end

      it '電話番号は11桁以上では保存できない' do
        @order_address.telephone_number = '123456789111'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号は不正な値です")
      end

      it '電話番号は全角数値では保存できない' do
        @order_address.telephone_number = '１２３４５６７８９１１'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("電話番号は不正な値です")
      end

      it '支払い情報は空では保存できない' do
        @order_address.token = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("クレジットカード情報を入力してください")
      end

      it 'ユーザが紐づいていないと保存できない' do
        @order_address.user_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("ユーザーを入力してください")
      end

      it '商品が紐づいていないと保存できない' do
        @order_address.item_id = nil
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("商品を入力してください")
      end
    end
  end
end
