class RecipesController < ApplicationController

  def index
    @recipes = Recipe.find(:all)
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new
    @recipe.ingredients.build
  end

  def create
    @recipe = Recipe.new(params[:recipe])
    if @recipe.save
      redirect_to :action => :show, :id => @recipe
    end
  end
end
