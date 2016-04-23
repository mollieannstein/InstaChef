class RecipeProcedure < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :procedure
end
