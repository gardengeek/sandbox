require 'rails_helper'

RSpec.describe CompaniesController, type: :routing do
  describe 'routing' do

    it 'routes to #index' do
      expect(get:  '/companies').to route_to('companies#index')
    end

    it 'routes to #alphabetical' do
      expect(get: '/companies/alphabetically').to route_to('companies#alphabetically')
    end
  end
end
