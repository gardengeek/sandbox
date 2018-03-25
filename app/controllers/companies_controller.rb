class CompaniesController < ApplicationController

  # GET /companies
  def index
    render json: { data: Company.all }
  end

  # GET /companies/alphabetically
  def alphabetically
    render json: { data: Company.alphabetically }
  end

  # GET /companies/with_modern_plan
  def with_modern_plan
    render json: { data: Company.modern_plan_levels }
  end
end
