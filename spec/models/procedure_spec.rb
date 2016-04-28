require 'spec_helper'
require 'rails_helper'

describe Procedure do
  let(:procedure) { Procedure.create(term: 'chop', instructions: 'cut things up')}
  let(:recipe_one) {Recipe.create(name: "Mac and Cheese")}


  it "creates a procedure with a name of 'chop'" do
    expect(procedure.term).to eq("chop")
  end

  it "creates a procedure with instructions" do
    expect(procedure.instructions).to eq("cut things up")
  end

  it "counts the number of recipes for that procedure" do
    procedure.recipes << recipe_one
    expect(procedure.count_frequency).to eq(1)
  end

end
