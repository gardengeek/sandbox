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
        expect(Company.all.size).to eq 4

        expect(Company.alphabetically.map(&:name)).to eq ['Bar', 'bax', 'Baz', 'Foo']
      end
    end

    describe '.modern_plan_levels' do
      it 'returns companies with modern plan levels' do
        Company.create(name: 'modern_2', plan_level: Company::MODERN_PLAN_LEVELS.sample)
        Company.create(name: 'modern_1', plan_level: Company::MODERN_PLAN_LEVELS.sample)
        Company.create(name: 'modern_3', plan_level: Company::MODERN_PLAN_LEVELS.sample)
        Company.create(name: 'not_modern_6', plan_level: 'custom')
        Company.create(name: 'not_modern_7', plan_level: 'legacy')
        expect(Company.all.size).to eq 5

        expect(Company.modern_plan_levels.map(&:name)).to match_array(['modern_1', 'modern_2', 'modern_3'])
      end
    end

    describe '.not_trialing' do
      it 'returns companies with a trial_ends_on of nil or in the past' do
        Company.create(name: 'Foo', plan_level: Company::PLAN_LEVELS.sample, trial_ends_on: 2.days.ago.to_date)
        Company.create(name: 'Bar', plan_level: Company::PLAN_LEVELS.sample, trial_ends_on: nil)
        Company.create(name: 'Baz', plan_level: Company::PLAN_LEVELS.sample, trial_ends_on: 5.days.from_now.to_date)
        Company.create(name: 'Bax', plan_level: Company::PLAN_LEVELS.sample, trial_ends_on: 2.days.from_now.to_date)
        Company.create(name: 'Qux', plan_level: Company::PLAN_LEVELS.sample, trial_ends_on: Date.today)
        expect(Company.all.size).to eq 5

        expect(Company.not_trialing.map(&:name)).to match_array(['Foo', 'Bar'])
      end
    end

    describe '.created_last_month' do
      it 'returns companies that were created last month' do
        Company.create(name: 'Foo', plan_level: Company::PLAN_LEVELS.sample, created_at: 1.month.ago.beginning_of_month)
        Company.create(name: 'Bar', plan_level: Company::PLAN_LEVELS.sample, created_at: 1.month.ago.end_of_month)
        Company.create(name: 'bax', plan_level: Company::PLAN_LEVELS.sample, created_at: 2.months.ago)
        Company.create(name: 'Baz', plan_level: Company::PLAN_LEVELS.sample, created_at: Date.today.beginning_of_month)
        Company.create(name: 'Baz', plan_level: Company::PLAN_LEVELS.sample)
        expect(Company.all.size).to eq 5

        expect(Company.created_last_month.map(&:name)).to match_array(['Foo', 'Bar'])
      end
    end
  end
end
