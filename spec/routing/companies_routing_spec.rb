require 'rails_helper'

RSpec.describe CompaniesController, type: :routing do
  describe 'routing' do

    it 'routes to #index' do
      expect(:get => '/companies').to route_to('companies#index')
    end
  end
end
