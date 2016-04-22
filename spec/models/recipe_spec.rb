require 'spec_helper'
require 'rails_helper'

describe Recipe do
  let(:recipe) { Recipe.new(name: "Mac and Cheese", ingredients: "1 cup Mac, 1 cup cheese", directions: "Boil Mac, add cheese") }

  it "creates a recipe with a name of 'Mac and Cheese'" do
    expect(recipe.name).to eq("Mac and Cheese")
  end

  it "creates a recipe with ingredients" do
    expect(recipe.ingredients).to eq("1 cup Mac, 1 cup cheese")
  end

  it "creates a recipe with directions" do
    expect(recipe.directions).to eq("Boil Mac, add cheese")
  end

end
