class RecipesController < ApplicationController
  def search
    @recipes = Recipe.where(params[:id])
  end

  def show

  end
end