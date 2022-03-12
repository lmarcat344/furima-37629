class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions 
  belongs_to :prefecture
  belongs_to :category
  belongs_to :condition
  belongs_to :charge 
  belongs_to :shipping

  with_options presence: true do 
    validates :image
    validates :name
    validates :content
    validates :price, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: 'is out of setting range' }
    validates :price, numericality: { only_integer: true, message: 'is invalid. Input half-width characters' }
  end

  validates :category_id, numericality: { other_than: 0, message: "can't be blank" } 
  validates :condition_id, numericality: { other_than: 0, message: "can't be blank" } 
  validates :charge_id, numericality: { other_than: 0, message: "can't be blank" } 
  validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }
  validates :shipping_id, numericality: { other_than: 0, message: "can't be blank" }  
end
