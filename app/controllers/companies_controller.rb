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

  # GET /companies/not_trialing
  def not_trialing
    render json: { data: Company.not_trialing }
  end

  # GET /companies/created_last_month
  def created_last_month
    render json: { data: Company.created_last_month }
  end
end
