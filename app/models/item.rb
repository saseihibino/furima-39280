class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :Prefecture
  belongs_to :category
  belongs_to :condition
  belongs_to :daytosend
  belongs_to :deliverycharge
  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :image
    validates :item_name
    validates :description
    validates :category_id, numericality: { other_than: 0 }
    validates :condition_id, numericality: { other_than: 0 }
    validates :delivery_charge_id, numericality: { other_than: 0 }
    validates :prefecture_id, numericality: { other_than: 0 }
    validates :day_to_send_id, numericality: { other_than: 0 }
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 },
                      format: { with: /\A[0-9]+\z/ }
  end
end