class RecipesController < ApplicationController
  def search
    if params[:query].present?
      @recipes = Recipe.search(params[:query], name: params[:name], load: true)
    else
      @recipes = Recipe.all.name params[:name]
    end
  end

  def autocomplete
    render json: Recipe.search(params[:query], autocomplete: true).map(&:name)
  end

  def show
    @recipe = Recipe.find(params[:id])
    render partial: "procedures"
  end
end