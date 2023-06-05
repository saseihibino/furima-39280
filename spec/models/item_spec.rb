require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品' do
    context '出品できる場合' do
      it '適切な情報を入力すると出品できる' do
        expect(@item).to be_valid
      end
    end

    context '出品出来ない場合' do
      it '画像は空では登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("画像を入力してください")
      end

      it '商品名は空では登録できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end

      it '商品の説明は空では登録できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end

      it 'カテゴリー情報は選択しないと登録できない' do
        @item.category_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include('カテゴリーは0以外の値にしてください')
      end

      it 'カテゴリー情報は空では登録できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーを入力してください")
      end

      it '商品の状態は選択しないと登録できない' do
        @item.condition_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の状態は0以外の値にしてください')
      end

      it '商品の状態は空では登録できない' do
        @item.condition_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態を入力してください")
      end

      it '配送料の負担は選択しないと登録できない' do
        @item.delivery_charge_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include('配送料の負担は0以外の値にしてください')
      end

      it '配送料の負担は空では登録できない' do
        @item.delivery_charge_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担を入力してください")
      end

      it '発送元の地域は選択しないと登録できない' do
        @item.prefecture_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include('発送元の地域は0以外の値にしてください')
      end

      it '発送元の地域は空では登録できない' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域を入力してください")
      end

      it '発送までの日数は選択しないと登録できない' do
        @item.day_to_send_id = '0'
        @item.valid?
        expect(@item.errors.full_messages).to include('発送までの日数は0以外の値にしてください')
      end

      it '発送までの日数は空では登録できない' do
        @item.day_to_send_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数を入力してください")
      end

      it '価格は空では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格を入力してください")
      end

      it '価格は300以下では登録できない' do
        @item.price = '200'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は300以上の値にしてください')
      end

      it '価格は9999999以上では登録できない' do
        @item.price = '10000000'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は9999999以下の値にしてください')
      end

      it '価格は全角数字では登録できない' do
        @item.price = '１００００'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は数値で入力してください')
      end

      it '価格は小数では登録できない' do
        @item.price = '3000.111'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は整数で入力してください')
      end

      it 'ユーザに紐づいていないと登録できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Userを入力してください')
      end
    end
  end
end
