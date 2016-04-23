class RecipesController < ApplicationController
  autocomplete :recipe, :name

  def search
    @recipes = Recipe.search(params[:query])
  end

  def show
    @recipe = Recipe.find(params[:id])
    render partial: "procedures", locals: {recipe: @recipe}
  end
end