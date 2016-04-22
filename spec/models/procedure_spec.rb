require 'spec_helper'
require 'rails_helper'

describe Procedure do
  let(:procedure) { Procedure.new(term: 'chop', instructions: 'cut things up')}

  it "creates a procedure with a name of 'chop'" do
    expect(procedure.term).to eq("chop")
  end

  it "creates a procedure with instructions" do
    expect(procedure.instructions).to eq("cut things up")
  end

end
