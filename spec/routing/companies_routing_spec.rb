require 'rails_helper'

RSpec.describe CompaniesController, type: :routing do
  describe 'routing' do

    it 'routes to #index' do
      expect(get:  '/companies').to route_to('companies#index')
    end

    it 'routes to #alphabetical' do
      expect(get: '/companies/alphabetically').to route_to('companies#alphabetically')
    end

    it 'routes to with_modern_plan' do
      expect(get: '/companies/with_modern_plan').to route_to('companies#with_modern_plan')
    end

    it 'routes to #not_trialing' do
      expect(get: '/companies/not_trialing').to route_to('companies#not_trialing')
    end

    it 'routes to #created_last_month' do
      expect(get: '/companies/created_last_month').to route_to('companies#created_last_month')
    end
  end
end
