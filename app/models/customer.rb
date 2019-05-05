class Customer < ApplicationRecord
  validates_presence_of :first_name, :last_name

  has_many :invoices

  def favorite_merchant
    merchant_id = invoices.joins(:transactions)
      .where('transactions.result = 0')
      .group(:merchant_id)
      .select("invoices.merchant_id, COUNT(transactions.id) AS num_transactions")
      .order("num_transactions DESC")
      .first.merchant_id
    Merchant.find(merchant_id)
  end
end
