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
    p "PEW PEW PEW"
    @recipes = Recipe.all
    if request.xhr?
      render partial: "allrecipes", layout: false, locals: { recipes: @recipes }
    else
      render :show
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
    servings_change = false
    if params[:servings_multiplier]
      @servings_multiplier = (params[:servings_multiplier].to_r / @recipe.servings.to_r).to_f
      servings_change = true
    else
      @servings_multiplier = 1
    end

    if request.xhr?
      if servings_change
        render partial: "ingredients", layout: false, locals: { recipe: @recipe, procedure: @recipe.procedures, servings: @servings_multiplier }
      else
        puts 'hello there ***************'
        render partial: "show", layout: false, locals: { recipe: @recipe, procedure: @recipe.procedures, servings: @servings_multiplier }
      end
    else
      puts 'i am rendering :show'
      render :show
    end
  end

end
