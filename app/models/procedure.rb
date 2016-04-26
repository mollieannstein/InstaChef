class Procedure < ActiveRecord::Base
  has_many :recipe_procedures
  has_many :recipes, through: :recipe_procedures, source: :recipe

  def count_frequency
    self.recipes.count
  end

  def self.sort_count_frequency
    Procedure.all.sort do |p1, p2|
      p2.count_frequency <=> p1.count_frequency
    end
  end

end
