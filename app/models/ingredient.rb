class Ingredient < ActiveRecord::Base
  belongs_to :recipe

  def to_s
    "#{quantity} #{name}"
  end

  def self.from_string(string)
    self.new(parse(string))
  end

  
  UNITS_OF_MEASURE = ['tsp']
  DIGITS = '\d+'
  UNITS = '(?: tsp)*'
  NAME = '(.+)'
  RE = Regexp.new("(#{DIGITS}#{UNITS}) #{NAME}")
  /(\d(?:\/\d|\.\d)*(?: (?:tsp|teaspoon))*) /
  def self.parse(string)
    match = string.match(RE)
    {:quantity => match[1], :name => match[2]}
  end 

end
