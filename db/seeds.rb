require 'open-uri'
require 'net/http'
require 'json'
require 'nokogiri'

API_KEY = ""

rId_array = [29148, 25359, 25215, 13640, 16587, 12913, 28131, 15800, 27974, 31372, 2296, 30009, 17711, 4860, 7211, 33165, 7778, 10634, 29594, 13812, 34005, 20461, 3620, 34963, 17562, 29159, 7542, 26177, 29696, 3649, 31876, 33844, 24968, 1775, 609, 26548, 24321, 13464, 14755, 32478, 2734, 13344, 29102, 31904, 32024, 22230, 690, 12970, 7186, 22340, 28463, 30585, 23700, 31402, 5545, 23009, 34678, 7321, 17203, 22317, 28789, 4057, 25279, 3763, 28133, 28652, 8960, 16600, 9020, 32496, 33891, 33861, 30996, 33843, 33852, 33894, 13051, 20969, 28878, 29037, 17551, 30937, 22388, 15823, 21636, 22691, 22934, 12202, 27537, 13866, 11109, 2404, 5437, 6257, 12240, 7820, 23126, 22565, 27314, 27295, 27304, 10768, 16100, 1022, 30887, 28099, 6955, 21405, 28161, 27464, 28939, 27461, 12204, 4851, 29613, 32459, 30501, 32738, 30697, 12743, 14726, 12174, 17332, 9171, 30863, 19298, 18280, 24593, 26464, 11615, 23141, 15168, 4108, 14421, 22297, 8042, 6105, 34369, 24917, 2370, 14647, 19831, 30757, 32745, 9630, 29382, 6295, 2495, 2480, 2425, 11763, 2429, 3595, 5944, 2393, 10642, 2498, 2377, 9122, 32819, 32818, 7836, 1767, 1002, 10611, 34036, 18930, 21700, 2715, 12481, 22346, 26411, 10778, 7765, 29023, 28046, 2486, 15526, 26545, 14451, 3548, 11489, 1736, 19041, 2988, 13264, 17645, 31868, 21608, 644, 29100, 25370, 28899, 9824, 30086, 28734, 20410, 18048, 22559, 11852, 17309, 5783, 30557, 1735, 34173, 28708, 14753, 16067, 15227]


rId_array.each do |rId|
  uri = URI.parse(URI.escape("http://food2fork.com/api/get?key=#{API_KEY}&rId=#{rId}"))

  response = Net::HTTP.get(uri)
  response = JSON.parse(response)

  r = Recipe.create(name: response["recipe"]["title"], image_url: response["recipe"]["image_url"])

  ingredients = response["recipe"]["ingredients"]
  source_url = response["recipe"]["source_url"]
  p response["recipe"]["title"]
  p source_url

  doc = Nokogiri::HTML(open(source_url))

  directions = doc.css('li.step span.recipe-directions__list--item')
  directions.pop

  directions.each do |step|
    Direction.create(step: step.children.first.text, recipe_id: r.id)
  end

  ingredients.each do |item|
    Ingredient.create(item: item, recipe_id: r.id )
  end

  r.servings = /\d/.match(doc.css('div.subtext').first.text)[0].to_i
  r.save
end



# food_terms = ["cut", "diced", "sliced", "removed", "al dente", "bake", "baste", "beaten", "bias-sliced", "blanched", "blended", "boiled", "braised", "broiled", "browned", "butterflied", "candied", "carved", "chiffonaded", "chilled", "chopped", "buttered", "coated", "crimped", "crushed", "carmelized", "creamed", "cubed", "deep-fried", "dipped", "dissolved", "dredged", "dressed", "dusted", "dried", "emulsified", "filleted", "flaked", "floured", "fluted", "folded", "fried", "garsnished", "crystallized", "glazed", "grated", "greased", "ground", "juiced", "kneaded", "marbled", "marinaded", "mashed", "melted", "minced", "mixed", "moistened", "mulled", "parbroiled", "pared", "peeled", "pinched", "piped", "pitted", "plumped", "pounded", "processed", "preheated", "proofed", "pureed", "reduced", "reconstituted", "roasted", "sauteed", "scalded", "scored", "seared", "sectioned", "shredded", "finely shredded", "thinly sliced", "sieved", "sifted", "simmered", "skewered", "skimmed", "snipped", "steamed", "steeped", "stewed", "stirred", "scraped", "toasted", "tossed", "whipped", "zested", "julienned", "shaved", "drained"]
#
# p rId_array.size
#
# recipe_procs = []
#
# ingredients.each do |ing|
#   food_terms.each do |term|
#     if ing.include?(term)
#       recipe_procs.push(term)
#     end
#   end
# end
#
# p recipe_procs
# p food_terms.size



# response = {"recipe"=>{"publisher"=>"All Recipes", "f2f_url"=>"http://food2fork.com/view/31372", "ingredients"=>["1 pound bulk mild Italian sausage", "1 1/4 teaspoons crushed red pepper flakes", "4 slices bacon, cut into 1/2 inch pieces", "1 large onion, diced", "1 tablespoon minced garlic", "5 (13.75 ounce) cans chicken broth", "6 potato, thinly sliced", "1 cup heavy cream", "1/4 bunch fresh spinach, tough stems removed"], "source_url"=>"http://allrecipes.com/Recipe/Super-Delicious-Zuppa-Toscana/Detail.aspx", "recipe_id"=>"31372", "image_url"=>"http://static.food2fork.com/2160120bb1.jpg", "social_rank"=>99.99999999999993, "publisher_url"=>"http://allrecipes.com", "title"=>"Super-Delicious Zuppa Toscana"}}
