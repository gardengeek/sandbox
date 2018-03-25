class Company < ApplicationRecord
  PLAN_LEVELS = %w(legacy custom basic plus growth enterprise).freeze
  MODERN_PLAN_LEVELS = (PLAN_LEVELS - %w(custom legacy)).freeze

  has_many :lessons, dependent: :destroy

  validates :name, :plan_level, presence: true
  validates :name, length: { in: 3...255 }
  validates :plan_level, inclusion: { in: PLAN_LEVELS }

  scope :alphabetically, -> { order('name collate NOCASE') }
  scope :modern_plan_levels, -> { where('plan_level IN (?)', MODERN_PLAN_LEVELS) }
  scope :not_trialing, -> { where('trial_ends_on is null or trial_ends_on < ?', Date.today) }
  scope :created_last_month, -> { where('created_at between ? and ?', 1.month.ago.beginning_of_month, 1.month.ago.end_of_month) }
end
