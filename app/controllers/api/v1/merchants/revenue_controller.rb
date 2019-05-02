class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    all_total_revenue = Merchant.all_total_revenue_for_date(params[:date])
    render json: TotalRevenueSerializer.new(TotalRevenue.new(all_total_revenue))
  end 
end 