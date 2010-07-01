class RecipesController < ApplicationController

  def index
    @recipes = Recipe.find(:all)
  end

  def show
    @recipe = Recipe.find(params[:id])
  end
end
