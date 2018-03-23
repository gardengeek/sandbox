class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies, comment: 'Company information' do |t|
      t.string :name, comment: 'Company name'
      t.date :trial_ends_on, comment: 'Trial end date'
      t.string :plan_level, comment: 'Company plan level'

      t.timestamps
    end
  end
end
