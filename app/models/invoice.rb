class Invoice < ApplicationRecord
  validates_presence_of :status 

  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  belongs_to :merchant
  belongs_to :customer

  enum status:['unshipped', 'shipped']
end
