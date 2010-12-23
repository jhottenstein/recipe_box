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

  def test_parser_simple
    assert_parses(['3', 'eggs'])
    assert_parses(['', 'eggs'])
  end
  
  def test_parser_with_multiple_words
    assert_parses(['1', 'red cabbage'])
  end
  
  def test_parser_with_units_of_measure
    assert_parses(['1 tsp', 'cinnamon'])
    assert_parses(['1 TSP', 'cinnamon'])
    assert_parses(['1 t', 'cinnamon'])
    #assert_parses(['a pinch of', 'cinnamon'])
    #assert_parses(['a cup', 'cinnamon'], ['cup', 'cinnamon'])
    assert_parses(['dash', 'cinnamon'])
    assert_parses(['1t', 'cinnamon'], ['1 t', 'cinnamon'])    
    assert_parses(['10T', 'cinnamon'], ['10 T', 'cinnamon'])    
  end
  
  def test_units_of_volume_measure
    assert_units_contain 'pinch'
    assert_units_contain 'dash'
    assert_units_contain 'tsp'
    assert_units_contain 't'
    assert_units_contain 'T'
    assert_units_contain 'tbsp'
    assert_units_contain 'cup'
    assert_units_contain 'c'
    assert_units_contain 'pint'
    assert_units_contain 'pt'
    assert_units_contain 'quart'
    assert_units_contain 'qt'
    assert_units_contain 'gallon'
    assert_units_contain 'gal'
    assert_units_contain 'millilitres'
    assert_units_contain 'milliliters'
    assert_units_contain 'ml'
  end
  
  def assert_units_contain(unit)
    assert Ingredient::UNITS.include?(unit), "Ingredient::UNITS does not include #{unit}"
  end
  
  def test_parser_with_rationals
    assert_parses(['1.5 tsp', 'cinnamon'])
    assert_parses(['10.5 tsp', 'cinnamon'])
    assert_parses(['1.50 tsp', 'cinnamon'])
    assert_parses(['1/2 tsp', 'cinnamon'])
    assert_parses(['10/2 tsp', 'cinnamon'])
    assert_parses(['1/20 tsp', 'cinnamon'])
    assert_parses(['1 1/2 tsp', 'cinnamon'])
    assert_parses(['10 1/2 tsp', 'cinnamon'])
  end
  
private
  def assert_parses(input,  expected = input)
    text = input.join(' ')
    ingredient =  Ingredient.parse(text)
    assert_equal expected.first, ingredient.quantity, "Ingredient was #{ingredient.inspect}"
    assert_equal expected.last, ingredient.name, "Ingredient was #{ingredient.inspect}"
  end
end
