class RecipesController < ApplicationController
  # autocomplete :recipe, :name
  def index
    @recipes = Recipe.all
    if params[:search]
      @recipes = Recipe.search(params[:search])
    else
      @recipes = Recipe.all
    end
  end


  def search
    @recipes = Recipe.search(params[:query])
  end

  def show
    @recipe = Recipe.find(params[:id])
    render partial: "procedures", locals: {recipe: @recipe}
  end
end