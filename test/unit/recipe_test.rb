require File.join(File.dirname(__FILE__), '..', 'test_helper')

class RecipeTest < ActiveSupport::TestCase
  def test_has_ingredients
    recipe = Recipe.new
    recipe.ingredients
  end
end
