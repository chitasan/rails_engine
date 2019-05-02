class Api::V1::Merchants::MostRevenueController < ApplicationController
  def index
    merchants_ranked = Merchant.merchants_ranked_by_total_revenue(params[:quantity])
    render json: MerchantSerializer.new(merchants_ranked)
  end 
end 