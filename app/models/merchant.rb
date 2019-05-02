class Merchant < ApplicationRecord
  validates_presence_of :name

  has_many :items
  has_many :invoices
  
  def self.merchants_ranked_by_total_revenue(quantity)
    select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS total_revenue')
      .joins(invoices: [:invoice_items, :transactions])
      .where('transactions.result = 0')
      .group(:id)
      .order('total_revenue DESC')
      .limit(quantity)
  end 

  def self.merchants_ranked_by_total_items_sold(quantity)
    select('merchants.*, SUM(invoice_items.quantity) AS total_items')
      .joins(invoices: [:invoice_items, :transactions])
      .where('transactions.result = 0')
      .group(:id)
      .order('total_items DESC')
      .limit(quantity)
  end 

  def self.all_total_revenue_for_date(date)
    start_date = date + " 00:00:00 UTC"
    end_date = date + " 23:59:59 UTC"

    Invoice.joins(:invoice_items, :transactions)
      .where('transactions.result = 0')
      .where(created_at: start_date..end_date)
      .sum("invoice_items.unit_price * invoice_items.quantity")
  end 
end
