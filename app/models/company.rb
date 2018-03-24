class Company < ApplicationRecord
  PLAN_LEVELS = %w(legacy custom basic plus growth enterprise).freeze
  validates :name, :plan_level, presence: true
  validates :name, length: { in: 3...255 }
  validates :plan_level, inclusion: { in: PLAN_LEVELS }
end