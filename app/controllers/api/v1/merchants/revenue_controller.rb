class Api::V1::Merchants::RevenueController < ApplicationController
  def index
    total_revenue_for_all = Merchant.all_total_revenue_for_date(params[:date])
    render json: TotalRevenueSerializer.new(TotalRevenue.new(total_revenue_for_all))
  end 

  def show
    merchant = Merchant.find(params[:merchant_id])
    if params[:date]
      render json: DateRevenueSerializer.new(merchant, {params: {date: params[:date]}})
    else
      render json: RevenueSerializer.new(merchant) 
    end 
  end 
end 