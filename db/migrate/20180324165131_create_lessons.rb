class CreateLessons < ActiveRecord::Migration[5.1]
  def change
    create_table :lessons, comment: 'Lesson information' do |t|
      t.string :name, comment: 'Name of the lesson'
      t.references :company, foreign_key: true, comment: 'Company associated with the lesson'
      t.boolean :active, default: true, comment: 'active if true, inactive if false'

      t.timestamps
    end
  end
end
