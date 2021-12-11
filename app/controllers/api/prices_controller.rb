module Api
  class PricesController < ApplicationController
    def index
      company = Company.find(params[:company_id])
      render json: company.prices
    end
  end
end
