require 'open-uri'
require 'net/http'
require 'json'
require 'nokogiri'
require 'verbs'

############# REMOVE BEFORE PUSH ###########

APP_KEY = '3426a1046705ec18632e7c1386fad156' #ENV['API_KEY']
APP_ID = 'e512ae51' #ENV['YUMMLY_ID']
YOUTUBE_API = 'AIzaSyAJvghM4FRJ4pHZ0jcMPh7gdMFIjmyKDnI' #ENV['YOUTUBE_API']


yummly_rId_array = ["Chicken-And-Dumplings-I-Allrecipes", "Salsa-Allrecipes", "Horseradish-Sauce-Allrecipes_1", "Snow-Peak-Frosting-Allrecipes", "Classic-Candied-Sweet-Potatoes-Allrecipes", "Butterscotch-Drops-Allrecipes", "Tropical-Grilled-Chicken-Breast-AllRecipes-39303", "Bannock-Allrecipes", "Good-Old-Fashioned-Pancakes-546169", "Best-Spanish-Rice-Allrecipes"]

yummly_rId_array_long = ["Chicken-And-Dumplings-I-Allrecipes", "Salsa-Allrecipes", "Horseradish-Sauce-Allrecipes_1", "Snow-Peak-Frosting-Allrecipes", "Classic-Candied-Sweet-Potatoes-Allrecipes", "Butterscotch-Drops-Allrecipes", "Tropical-Grilled-Chicken-Breast-AllRecipes-39303", "Bannock-Allrecipes", "Good-Old-Fashioned-Pancakes-546169", "Best-Spanish-Rice-Allrecipes", "Creamy-Cheese-Bread-Allrecipes", "Traditional-White-Bread-Allrecipes", "London-Broil-For-The-Slow-Cooker-Allrecipes", "Slow-Cooker-Pulled-Pork-AllRecipes", "Best-Ever-Onion-Rings-Allrecipes", "Jen_s-Heavenly-Egg-Salad-Allrecipes", "Applesauce-Allrecipes_1", "Cheesiest-Potatoes-Casserole-Allrecipes", "Cabbage-Burgers-Allrecipes", "Easy-Hummus-Allrecipes", "Buffalo-Chicken-Dip-Allrecipes", "Easy-Gravy-Allrecipes", "Light-And-Fluffy-Spinach-Quiche-Allrecipes", "Best-Green-Bean-Casserole-Allrecipes", "Grandmother_s-Old-Fashioned-Butter-Roll-Allrecipes", "Country-Cooking-Slow-Cooker-Neck-Bones-Allrecipes", "Valentino_s-Pizza-Crust-Allrecipes", "Brandied-Candied-Sweet-Potatoes-AllRecipes", "Pork-Tenderloin-Marinade-Allrecipes", "Chewy-Sugar-Cookies-Allrecipes", "Slow-Cooker-Roast-Beef-AllRecipes", "Grandma_s-Famous-Salmon-Cakes-Allrecipes", "Beef-Burgundy-Iii-Allrecipes", "The-Best-Mashed-Potatoes-Allrecipes", "Amazing-Pork-Tenderloin-In-The-Slow-Cooker-Allrecipes", "Swiss-Cheese-Meatloaf-Allrecipes", "Simple-and-Delicious-Beet-Greens-AllRecipes-37742", "Quick-And-Easy-Alfredo-Sauce-Allrecipes", "Dominican-Style-Oatmeal-AllRecipes", "The-Best-Steak-Marinade-Allrecipes", "Cheese-and-Bacon-Potato-Rounds-682088", "The-World_s-Best-Turkey-Allrecipes"]

yummly_rId_array.each do |rId|

  url = "http://api.yummly.com/v1/api/recipe/#{rId}?_app_id=#{APP_ID}&_app_key=#{APP_KEY}"

  uri = URI.parse(URI.escape(url))

  response = Net::HTTP.get(uri)
  response = JSON.parse(response)

  r = Recipe.create(name: response["name"], image_url: response["images"][0]["hostedLargeUrl"], prep_time: response["totalTime"], servings: response["numberOfServings"], course: response["attributes"]["course"][0])

  ingredients = response["ingredientLines"]
  source_url = response["source"]["sourceRecipeUrl"]
  p response["name"]
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

end


nokogiri_procedures = Nokogiri::HTML(open("http://www.recipegoldmine.com/kitchart/kitchart17.html"))

procedures = nokogiri_procedures.css('p')
procedures.pop

procedures.each do |item|

  object_text = item.text
  object_text = object_text.gsub(/\s{1}-{1}\s{1}/, "*")
  object_text = object_text.gsub("\\", "")
  object_text = object_text.gsub("\n", "")

  i = object_text.index('*')
  term =  object_text[0, i]

  if term == 'Cook'
  else

    past_term = Verbs::Conjugator.conjugate term.to_sym, :tense => :past, :aspect => :perfective
    p = Procedure.create(term: term, past_tense_term: past_term,instructions: object_text[i+1, object_text.length - i], youtube_url: "")

    # youtube json parse

    youtube_url = "https://www.googleapis.com/youtube/v3/search?part=snippet&maxResults=1&q=cooking+term#{term}&key=#{YOUTUBE_API}"

    youtube_uri = URI.parse(URI.escape(youtube_url))

    youtube_response = Net::HTTP.get(youtube_uri)
    youtube_response = JSON.parse(youtube_response)

    if youtube_response["items"].length > 0
       p.youtube_url = Procedure.update(p.id, :youtube_url => "//www.youtube.com/embed/#{youtube_response["items"][0]["id"]["videoId"]}")
       # p.save
      # puts youtube_response["items"][0]["id"]["videoId"]
    end
  end

end

procedure_array = []
past_tense_array = []

Procedure.all.each do |proc|
  procedure_array << proc.term
end

Procedure.all.each do |proc|
  past_tense_array << proc.past_tense_term
end

Recipe.all.each do |r|
  past_tense_array.each do |proc_name|
    r.ingredients.each do |ing|
      if ing.item.downcase.include?(proc_name.downcase)
        puts r.id.to_s + " " + proc_name
        RecipeProcedure.create(
            recipe_id: r.id,
            procedure_id: Procedure.find_by(past_tense_term: proc_name).id)
      end
    end
  end

  procedure_array.each do |proc_name|
    r.directions.each do |dir|
      if dir.step.downcase.include?(proc_name.downcase)
        puts r.id.to_s + " " + proc_name
        RecipeProcedure.create(
          recipe_id: r.id,
          procedure_id: Procedure.find_by(term: proc_name).id)
      end
    end
  end

end

p = Procedure.find_by(term: "Grill")
p.instructions = Procedure.find_by(term: "Broil").instructions
p.save


food2fork_rId_array = [29148, 25359, 25215, 13640, 16587, 12913, 28131, 15800, 27974, 31372, 2296, 30009, 17711, 4860, 7211, 33165, 7778, 10634, 29594, 13812, 34005, 20461, 3620, 34963, 17562, 29159, 7542, 26177, 29696, 3649, 31876, 33844, 24968, 1775, 609, 26548, 24321, 13464, 14755, 32478, 2734, 13344, 29102, 31904, 32024, 22230, 690, 12970, 7186, 22340, 28463, 30585, 23700, 31402, 5545, 23009, 34678, 7321, 17203, 22317, 28789, 4057, 25279, 3763, 28133, 28652, 8960, 16600, 9020, 32496, 33891, 33861, 30996, 33843, 33852, 33894, 13051, 20969, 28878, 29037, 17551, 30937, 22388, 15823, 21636, 22691, 22934, 12202, 27537, 13866, 11109, 2404, 5437, 6257, 12240, 7820, 23126, 22565, 27314, 27295, 27304, 10768, 16100, 1022, 30887, 28099, 6955, 21405, 28161, 27464, 28939, 27461, 12204, 4851, 29613, 32459, 30501, 32738, 30697, 12743, 14726, 12174, 17332, 9171, 30863, 19298, 18280, 24593, 26464, 11615, 23141, 15168, 4108, 14421, 22297, 8042, 6105, 34369, 24917, 2370, 14647, 19831, 30757, 32745, 9630, 29382, 6295, 2495, 2480, 2425, 11763, 2429, 3595, 5944, 2393, 10642, 2498, 2377, 9122, 32819, 32818, 7836, 1767, 1002, 10611, 34036, 18930, 21700, 2715, 12481, 22346, 26411, 10778, 7765, 29023, 28046, 2486, 15526, 26545, 14451, 3548, 11489, 1736, 19041, 2988, 13264, 17645, 31868, 21608, 644, 29100, 25370, 28899, 9824, 30086, 28734, 20410, 18048, 22559, 11852, 17309, 5783, 30557, 1735, 34173, 28708, 14753, 16067, 15227]


# Procedure.update(20, :img_url => "http://i.imgur.com/ywfTJDM.gif", :img_url2 => "http://i.imgur.com/eMKO3Bq.gif")
# Procedure.update(125, :img_url => "http://i.imgur.com/1BqVowg.gif")
# Procedure.update(69, :img_url => "http://i.imgur.com/WEgt5Sa.gif", :img_url2 => "http://i.imgur.com/MnHg8xS.gif")
# Procedure.update(41, :img_url => "http://i.imgur.com/nACmNlW.gif", :img_url2 => "http://i.imgur.com/RoxYQQU.gif")
