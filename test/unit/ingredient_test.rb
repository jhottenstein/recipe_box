require File.join(File.dirname(__FILE__), '..', 'test_helper')

class IngredientTest < ActiveSupport::TestCase
  def test_ingredient_has_a_quantity_and_name
    ingredient = ingredients(:eggs)
    assert_equal '2', ingredient.quantity
    assert_equal 'eggs', ingredient.name
  end

  def test_ingredient_from_string
    string = "2 eggs"
    ingredient = Ingredient.from_string(string)
    assert_equal '2', ingredient.quantity
    assert_equal 'eggs', ingredient.name
  end

  def test_parse_ingredient_simple
    ingredient = "2 eggs"
    parsed_ingredient = Ingredient.parse(ingredient)
    assert_equal '2', parsed_ingredient[:quantity]
    assert_equal 'eggs', parsed_ingredient[:name]
  end

  def test_parse_ingredient_with_unit
    ingredient = "1 tsp foo"
    parsed_ingredient = Ingredient.parse(ingredient)
    assert_equal '1 tsp', parsed_ingredient[:quantity]
    assert_equal 'foo', parsed_ingredient[:name]
  end

end
