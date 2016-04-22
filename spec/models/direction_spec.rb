require 'spec_helper'
require 'rails_helper'

describe Direction do
  let(:direction) { Direction.new(step: "Mix in flour")}

  it "direction has a step 'Mix in flour'" do
    expect(direction.step).to eq("Mix in flour")
  end
end
