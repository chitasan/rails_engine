class DateRevenueSerializer
  include FastJsonapi::ObjectSerializer
  
  attribute :revenue do |object, params|
    (object.total_revenue_for_date(params[:date]) / 100.0).to_s
  end
end 