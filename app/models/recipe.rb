class Recipe < ActiveRecord::Base
  has_many :terms through: :RecipeProcedures
end
