class OrderAddress
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :post_code, :prefecture_id, :city, :address1, :build_addr, :phone
  attr_accessor :token
  
  with_options presence: true do
    validates :post_code, format: { with: /\A\d{3}[-]\d{4}\z/, message: 'is invalid. Enter it as follows (e.g. 123-4567)'}
    validates :city
    validates :address1
    validates :phone, format: { with: /\A.{10,11}\z/, message: "is too short" }
    validates :user_id
    validates :item_id
  end
    validates :phone, format: { with: /\A\d+\z/, message: "is invalid. Input only number" }
    validates :prefecture_id, numericality: { other_than: 0, message: "can't be blank" }


  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(post_code: post_code, prefecture_id: prefecture_id, city: city, address1: address1, build_addr: build_addr, phone: phone, order_id: order.id)
  end
end
