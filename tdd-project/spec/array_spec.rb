require 'rspec'
require 'array'

describe Array do
    subject(:array) { Array.new }

    describe '#my_uniq' do
        context 'duplicates exist' do
            it 'should remove duplicate values' do
                expect(array.my_uniq([1, 1, 2, 3])).to eq([1, 2, 3])
            end
        end
        
        context "duplicates don't exist" do
            it 'should return all elements' do
                expect(array.my_uniq([1, 2, 3])).to eq([1, 2, 3])
            end
        end
    end

    describe '#two_sum' do
        it 'should return index pairs that sum to zero' do
            expect(array.two_sum([-1, 0, 2, -2, 1])).to eq([[0, 4], [2, 3]])
        end
    end
end