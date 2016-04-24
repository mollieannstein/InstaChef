module ApplicationHelper
  def highlight(text, match_array)
    stuff = []
    match_array.each do |m|
      stuff << Procedure.find(m.procedure_id).term
    end
    stuff.each do |s|
      p s
      if text.include?(s)
        text = text.gsub(s, "<mark>"+s+"</mark>")
      elsif text.downcase.include?(s.downcase)
        text = text.downcase.gsub(s.downcase, "<mark>"+s.downcase.capitalize+"</mark>")
      end
    end
    return text
  end

  def recipe_converter(ingredient, converter)
    return (ingredient.to_r * converter).to_f
  end
end
