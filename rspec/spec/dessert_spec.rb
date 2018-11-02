require 'rspec'
require 'dessert'

describe Dessert do
  type, quantity = 'cake', 10
  let(:chef) { double("chef", name: 'Patrick') }
  subject(:dessert) { Dessert.new(type, quantity, chef) }

  describe "#initialize" do
    it "sets a type" do
      expect(dessert.type).to eq(type)
    end

    it "sets a quantity" do
      expect(dessert.quantity).to eq(quantity)
    end

    it "starts ingredients as an empty array" do
      expect(dessert.ingredients).to be_empty
    end

    it "raises an argument error when given a non-integer quantity" do
      expect { Dessert.new(type, 'invalid', chef) }.to raise_error(ArgumentError)
    end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      ingredient = 'flour'
      dessert.add_ingredient(ingredient)
      expect(dessert.ingredients).to include(ingredient)
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do
      ingredients = ['pepper', 'flour', 'apricots']
      expect(10.times.all? { ingredients.shuffle == ingredients }).to be(false)
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      dessert.eat(3)
      expect(dessert.quantity).to eq(7)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect { dessert.eat(10000) }.to raise_error('not enough left!')
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      expect(chef).to receive(:titleize)
      dessert.serve
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      expect(chef).to receive(:bake).with(dessert)
      dessert.make_more
    end
  end
end
