class Item < ApplicationRecord
  validates_presence_of :name, :description, :unit_price
  
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  belongs_to :merchant

  def self.items_with_most_revenue(quantity)
    Item.joins(invoices: :transactions)
      .where('transactions.result = 0')
      .group(:id)
      .select("items.*, SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue")
      .order("revenue DESC")
      .limit(quantity)
  end 

  def self.items_by_inventory_sold(quantity)
    Item.joins(invoices: :transactions)
      .where('transactions.result = 0')
      .group(:id)
      .select("items.*, SUM(invoice_items.quantity) AS items_sold")
      .order("items_sold DESC")
      .limit(quantity)
  end

  def best_date(item_id)
    Invoice.joins({invoice_items: :item}, :transactions)
      .select("invoices.created_at as order_date, SUM(invoice_items.quantity) as item_count")
      .where("transactions.result = ? AND items.id = ?", 0, item_id)
      .order("item_count DESC, order_date DESC")
      .group("order_date")
      .limit(1)
  end
end
