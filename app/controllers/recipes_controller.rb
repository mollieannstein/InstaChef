class RecipesController < ApplicationController
  # autocomplete :recipe, :name


# if user presses "enter", it's processed like a normal http request, otherwise it's an ajax
  def index
    # puts "I'm here"
    if params[:search]
      @recipes = Recipe.search(params[:search])
      if request.xhr?
        render partial: "search", locals: { recipes: @recipes, search: params[:search]}
      end
    else
      @recipes = Recipe.all
    end
  end

  # def search
  #   @recipes = Recipe.search(params[:query])
  # end

  def show
    @recipe = Recipe.find(params[:id])
    render :show
  end
end
