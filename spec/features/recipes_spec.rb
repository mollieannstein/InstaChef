require 'spec_helper'
require 'rails_helper'

RSpec.feature "Recipes", type: :feature do

  before do
    visit root_url
  end

  # scenario "as a visitor, I should be able to visit the all recipes page" do
  #   click_link ("ALL RECIPES")
  #   expect(page).to have_content "Appetizers"
  # end


end