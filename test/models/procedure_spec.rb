require 'rails_helper'

describe Procedure do
  let(:procedure) { Procedure.new(term: 'chop', instructions: 'cut things up') }

  it "creates a procedure with a name of 'chop'" do
    expect(procedure.term).to eq("mince")
  end

end
