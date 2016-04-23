class RecipeProcedures < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :procedure
end
