class RecipesController < ApplicationController
  # autocomplete :recipe, :name


# if user presses "enter", it's processed like a normal http request, otherwise it's an ajax
  def index
    # if search params do this
    if params[:search]
      @recipes = Recipe.search(params[:search])
      if request.xhr?
        @recipes = @recipes[0..2]
        render partial: "search", locals: { recipes: @recipes, search: params[:search]}
      end
    else
      @recipes = Recipe.all
    end
  end

  def allrecipes
    @recipes = Recipe.all
    if request.xhr?
      render partial: "allrecipes", layout: false, locals: { recipes: @recipes }
    else
      render :show
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    if request.xhr?
      render partial: "show", layout: false, locals: { recipe: @recipe, procedure: @recipe.procedures }
    else
      render :show
    end
  end

end
