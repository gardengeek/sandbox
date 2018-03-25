require 'rails_helper'

RSpec.describe 'Companies', type: :request do
  describe 'GET /companies' do
    before do
      Company.create(name: 'Foo', plan_level: Company::PLAN_LEVELS[1])
      Company.create(name: 'Bar', plan_level: Company::PLAN_LEVELS[0])
      Company.create(name: 'Baz', plan_level: Company::PLAN_LEVELS[2])
      expect(Company.all.size).to eq 3

      get '/companies'
    end

    it 'returns data for all companies' do
      json = JSON.parse(response.body)
      expect(json).to_not be_empty

      company_data = json['data']
      expect(company_data.size).to eq 3
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
