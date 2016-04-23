class RecipesController < ApplicationController
  def search
    @recipes = Recipe.where(params[:name])
  end

  def show
    @recipe = Recipe.find(params[:id])
    render partial: "procedures"
  end
end