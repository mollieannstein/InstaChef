require 'spec_helper'
require 'rails_helper'

describe Ingredient do
  let(:ingredient) { Ingredient.new(item: "Cheese")}

  it "creates an ingredient with an item" do
    expect(ingredient.item).to eq("Cheese")
  end
end
