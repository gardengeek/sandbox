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

  describe 'GET /companies/alphabetically' do
    before do
      Company.create(name: 'Foo', plan_level: Company::PLAN_LEVELS.sample)
      Company.create(name: 'Bar', plan_level: Company::PLAN_LEVELS.sample)
      Company.create(name: 'Baz', plan_level: Company::PLAN_LEVELS.sample)
      expect(Company.all.size).to eq 3

      get '/companies/alphabetically'
    end

    it 'returns data for all companies' do
      json = JSON.parse(response.body)
      expect(json).to_not be_empty

      company_data = json['data']
      expect(company_data.size).to eq 3
      expect(company_data[0]['name']).to eq 'Bar'
      expect(company_data[1]['name']).to eq 'Baz'
      expect(company_data[2]['name']).to eq 'Foo'
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /companies/with_modern_plan' do
    before do
      Company.create(name: 'Foo', plan_level: Company::MODERN_PLAN_LEVELS.sample)
      Company.create(name: 'Bar', plan_level: Company::MODERN_PLAN_LEVELS.sample)
      Company.create(name: 'Baz', plan_level: Company::MODERN_PLAN_LEVELS.sample)
      Company.create(name: 'Bax', plan_level: 'custom')
      Company.create(name: 'Qux', plan_level: 'legacy')
      expect(Company.all.size).to eq 5

      get '/companies/with_modern_plan'
    end

    it 'returns data for all companies with modern plans' do
      json = JSON.parse(response.body)
      expect(json).to_not be_empty

      company_data = json['data']
      expect(company_data.size).to eq 3
      expect(company_data.map { |hash| hash['name'] }).to match_array(['Foo', 'Bar', 'Baz'])
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
