class CompaniesController < ApplicationController

  # GET /companies
  # GET /companies.json
  def index
    render json: { data: Company.all }
  end
end
