class Ingredient < ActiveRecord::Base
  belongs_to :recipe

  def to_s
    "#{quantity} #{name}"
  end

  def self.from_string(string)
    parse(string)
  end

  UNITS = [ 'pinch', 'dash',
            'teaspoon', 'tsp', 't',
            'tablespoon', 'tbsp', 'T',
            'cup', 'c',
            'pint', 'pt',
            'quart', 'qt',
            'gallon', 'gal',
            'millilitres', 'milliliters', 'ml'
          ]
  
  NAME = ' *(.+)'
  OPTIONAL_NUMBERS = '(?:((?:\d+ )?[\d\.\/]+))?'
  OPTIONAL_UNITS_OF_MEASURE = "(?: *((?:#{UNITS.join('|')})s?) )?"
  WHOLE_INGREDIENT = /#{OPTIONAL_NUMBERS}#{OPTIONAL_UNITS_OF_MEASURE}#{NAME}/io

  def self.parse(ingredient)
    temp = ingredient.match(WHOLE_INGREDIENT)
    parsed_ingredient = temp[1..3]
    attributes = {}
    attributes[:quantity] = parsed_ingredient[0..1].compact.join(' ')
    attributes[:name] = parsed_ingredient[2]
    self.new(attributes)
  end

end
