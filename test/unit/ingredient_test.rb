require File.join(File.dirname(__FILE__), '..', 'test_helper')

class IngredientTest < ActiveSupport::TestCase
  def test_ingredient_has_a_quantity_and_name
    ingredient = ingredients(:eggs)
    assert_equal '2', ingredient.quantity
    assert_equal 'eggs', ingredient.name
  end
end
