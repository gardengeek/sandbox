require 'rails_helper'

RSpec.describe Lesson, type: :model do
  describe 'validations' do
    let(:lesson) { Lesson.new(company: Company.new)}

    describe 'name' do
      it 'is invalid when null' do
        lesson.name = nil
        expect(lesson.valid?).to eq false
      end

      context 'when it contains only letters and numbers' do
        it 'is valid' do
          lesson.name = 'a2'
          expect(lesson.valid?).to eq true
        end
      end

      context 'when it contains non-letters or numbers' do
        context 'such as !' do
          it 'is invalid' do
            lesson.name = 'a2!'
            expect(lesson.valid?).to eq false
          end
        end
        
        context 'when it contains spaces' do
          it 'is invalid' do
            lesson.name = 'Some Lesson2'
            expect(lesson.valid?).to eq false
          end
        end
      end
    end
  end
end
