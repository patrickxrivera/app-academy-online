require 'towers/game'

describe Game do
    let(:tower_one) { double('tower_one', :plates => [3, 2, 1]) }
    let(:tower_two) { double('tower_two', :plates => []) }
    let(:tower_three) { double('tower_three', :plates => []) }

    subject(:game) { Game.new(tower_one, tower_two, tower_three) }

    describe '#initialize' do
        it 'should initialize all three towers' do
            expect(game.towers.length).to eq(3)
        end

        it 'should reference available plates' do
            expect(game.towers[0].plates).to eq([3, 2, 1])
        end

        it 'should reference empty plates' do
            expect(game.towers[1].plates).to eq([])
        end
    end

    describe '#move' do
        context 'valid input' do
            it 'should move top plate to other tower' do
                game.move(1, 2)
                expect(game.towers[0].plates).to eq([3, 2])
                expect(game.towers[1].plates).to eq([1])
            end
        end
        
        context 'invalid input' do
            it 'should raise an error when given an invalid input' do
                expect { game.move(-10, 2) }.to raise_error('Must input either 1, 2, or 3.')
            end
        end
    end
end