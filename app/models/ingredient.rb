class Ingredient < ActiveRecord::Base
  belongs_to :recipe
  def to_s
    "#{quantity} #{name}"
  end

end
