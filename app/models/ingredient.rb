class Ingredient < ActiveRecord::Base
  belongs_to :recipe

  def to_s
    "#{quantity} #{name}"
  end

  def self.from_string(string)
    parse(string)
  end

  UNITS = [ 'pinch', 'dash',
            'tsp', 't',
            'tbsp', 'T',
            'cup', 'c',
            'pint', 'pt',
            'quart', 'qt',
            'gallon', 'gal',
            'millilitres', 'milliliters', 'ml'
          ]
  
  OPTIONAL_NUMBERS = '((?:\d+ )?[\d\.\/]+)?'
  UNITS_OF_MEASURE = "(#{UNITS.join('|')})?"
  NAME = '(.+)'
  OPTIONAL_SPACE  = ' *'
  WHOLE_INGREDIENT = /#{OPTIONAL_NUMBERS}#{OPTIONAL_SPACE}#{UNITS_OF_MEASURE}#{OPTIONAL_SPACE}#{NAME}/i

  def self.parse(ingredient)
    parsed_ingredient = ingredient.match(WHOLE_INGREDIENT)[1..3]
    attributes = {}
    parsed_ingredient
    attributes[:quantity] = parsed_ingredient[0..1].compact.join(' ')
    attributes[:name] = parsed_ingredient[2]
    self.new(attributes)
  end

end
