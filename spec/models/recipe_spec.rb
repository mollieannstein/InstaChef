require 'spec_helper'
require 'rails_helper'

describe Recipe do
  let(:recipe) { Recipe.new(name: "Mac and Cheese")}

  it "creates a recipe with a name 'Mac and Cheese'" do
    expect(recipe.name).to eq("Mac and Cheese")
  end
end
