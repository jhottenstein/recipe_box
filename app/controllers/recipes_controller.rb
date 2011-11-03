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
    parse_ingredients
    @recipe = Recipe.new(params[:recipe])
    if @recipe.save
      redirect_to @recipe
    else
      render :action => :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    parse_ingredients
    @recipe = Recipe.find(params[:id])
    @recipe.ingredients.clear
    if @recipe.update_attributes(params[:recipe])
      redirect_to @recipe
    else
      render :action => :edit
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_path
  end

private
  def parse_ingredients    #TODO move this 
    ingredients = params[:recipe].delete(:ingredients)
    if ingredients  
      parsed_ingredients = ingredients.split("\n").collect do |ingredient_string|
                            ingredient = Ingredient.parse(ingredient_string)
                            {:name => ingredient.name, :quantity => ingredient.quantity}
                           end
      params[:recipe][:ingredients_attributes] = parsed_ingredients 
    end
  end
end
