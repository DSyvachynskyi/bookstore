class Order < ActiveRecord::Base

belongs_to :costumer
belongs_to :credit_card
belongs_to :order_status

has_many :order_items
has_one :adress
has_one :billing_adress
 :order_status


validates :costumer_id, presence: true
validates :completed_date, presence: true




def total_price
sum=0  
OrderItem.where(order_id: id).find_each do |o|
sum += o.price
end
return sum
end


end
