class Lesson < ApplicationRecord
  belongs_to :company

  validates :name, presence: true, format: /\A[[:alnum:]]+\Z/
end
