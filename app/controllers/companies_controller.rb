class CompaniesController < ApplicationController

  # GET /companies
  def index
    render json: { data: Company.all }
  end

  # GET /companies/alphabetically
  def alphabetically
    render json: { data: Company.alphabetically }
  end
end
