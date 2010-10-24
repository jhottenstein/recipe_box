require File.join(File.dirname(__FILE__), '..', 'test_helper')

class RecipeTest < ActiveSupport::TestCase
  def test_has_ingredients
    recipe = Recipe.new
    recipe.ingredients
  end

  def test_recipe_accepts_nested_attributes
    recipe = Recipe.new
    recipe.ingredients_attributes = [{:name => 'foo'}]
  end
  
end
