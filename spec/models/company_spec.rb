require 'rails_helper'

RSpec.describe Company, type: :model do
  describe 'validations' do
    context 'name' do
      let(:company) do
        Company.new(plan_level: Company::PLAN_LEVELS[0])
      end

      it 'is invalid when null' do
        company.name = nil
        expect(company.valid?).to eq false
      end

      context 'when greater than 2 and less than 255 characters' do
        it 'is valid' do
          company.name = 'foo'
          expect(company.valid?).to eq true
        end
      end

      context 'when 2 or less characters' do
        it 'is invalid' do
          company.name = 'fo'
          expect(company.valid?).to eq false
        end
      end

      context 'when 255 or more characters' do
        it 'is invalid' do
          company.name = 'a' * 255
          expect(company.valid?).to eq false
        end
      end
    end

    context 'plan_level' do
      let(:company) do
        Company.new(name: 'foo')
      end

      it 'is invalid when null' do
        company.plan_level = nil 
        expect(company.valid?).to eq false
      end

      context 'when value is in PLAN_LEVELS' do
        it 'is valid' do
          company.plan_level = Company::PLAN_LEVELS[0]
          expect(company.valid?).to eq true
        end
      end

      context 'when value is not in PLAN_LEVELS' do
        it 'is invalid' do
          company.plan_level = 'bar'
          expect(company.valid?).to eq false
        end
      end
    end
  end

  describe 'scopes' do
    describe '.alphabetically' do
      it 'sorts alphabetically by name' do
        Company.create(name: 'Foo', plan_level: Company::PLAN_LEVELS[1])
        Company.create(name: 'Bar', plan_level: Company::PLAN_LEVELS[0])
        Company.create(name: 'bax', plan_level: Company::PLAN_LEVELS[3])
        Company.create(name: 'Baz', plan_level: Company::PLAN_LEVELS[2])

        expect(Company.alphabetically.map(&:name)).to eq ['Bar', 'bax', 'Baz', 'Foo']
      end
    end
  end
end
