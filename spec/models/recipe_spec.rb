require 'spec_helper'
require 'rails_helper'

describe Recipe do
  let(:recipe) { Recipe.create(name: "Mac and Cheese")}

  it "creates a recipe with a name 'Mac and Cheese'" do
    expect(recipe.name).to eq("Mac and Cheese")
  end

  # it "finds recipes in the database whose names match a query string" do
  #   expect(Recipe.all.search("Mac")).to match(recipe)
  # end

end
