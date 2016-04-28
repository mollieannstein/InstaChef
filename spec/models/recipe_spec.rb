require 'spec_helper'
require 'rails_helper'

describe Recipe do
  let(:recipe) { Recipe.create(name: "Mac and Cheese")}

  it "creates a recipe with a name 'Mac and Cheese'" do
    expect(recipe.name).to eq("Mac and Cheese")
  end

  it "finds recipes in the database whose names match a query string" do
    Recipe.create(name: "Mac and Cheese")
    search_output = Recipe.search("Mac")
    bad_search = Recipe.search("Pork")
    expect(search_output).to_not match(bad_search)
    expect(search_output.first).to have_attributes(:name => "Mac and Cheese")
  end

end
