require 'csv'

namespace :import do
  desc "Import Customers From CSV"
  task customers: :environment do
    CSV.foreach('db/data/customers.csv', headers: true) do |row|
      Customer.create!(row.to_h)
    end
  end

  desc "Import Merchants From CSV"
  task merchants: :environment do
    CSV.foreach('db/data/merchants.csv', headers: true) do |row|
      Merchant.create!(row.to_h)
    end
  end

  desc "Import Items From CSV"
  task items: :environment do
    CSV.foreach('db/data/items.csv', headers: true) do |row|
      Item.create!(row.to_h)
    end
  end

  desc "Import Invoices From CSV"
  task invoices: :environment do
    CSV.foreach('db/data/invoices.csv', headers: true) do |row|
      Invoice.create!(row.to_h)
    end
  end

  desc "Import Transactions From CSV"
  task transactions: :environment do
    CSV.foreach('db/data/transactions.csv', headers: true) do |row|
      Transaction.create!(row.to_h)
    end
  end

  desc "Import Invoice Items From CSV"
  task invoice_items: :environment do
    CSV.foreach('db/data/invoice_items.csv', headers: true) do |row|
      InvoiceItem.create!(row.to_h)
    end
  end
end
