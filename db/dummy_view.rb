r = Recipe.last

r.ingredients.each do |i|
  p i.item
end

r.directions.each do |d|
  p d.step
end

r.recipe_procedures do |rp|
  p rp.id
end
