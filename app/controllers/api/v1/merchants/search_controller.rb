class Api::V1::Merchants::SearchController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.where(merchant_params))
  end 

  def show 
    render json: MerchantSerializer.new(Merchant.where(merchant_params).first)
  end

  private

  def merchant_params
    params.permit(:id, :name, :created_at, :updated_at)
  end 
end 