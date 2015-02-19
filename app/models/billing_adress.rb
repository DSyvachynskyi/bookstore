class BillingAdress < ActiveRecord::Base

belongs_to :order
belongs_to :country

validates :adress, presence: true
validates :zipcode, presence: true
validates :city, presence: true
validates :phone, presence: true

end
