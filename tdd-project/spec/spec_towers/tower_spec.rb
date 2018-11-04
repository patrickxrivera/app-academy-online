require 'towers/tower'

describe Tower do
    subject(:tower) { Tower.new([3, 2, 1]) }

    describe '#initialze' do
        it 'should initialize with plates' do
            expect(tower.plates).to include(3)
        end
    end
end