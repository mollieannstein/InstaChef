module ApplicationHelper
  def highlight(text, match_array)
    stuff = []
    match_array.each do |m|
      stuff << Procedure.find(m.procedure_id).term
    end
    stuff.each do |s|
      if text.include?(s)
        text = text.gsub(s, "<mark>"+s+"</mark>")
      elsif text.downcase.include?(s.downcase)
        text = text.downcase.gsub(s.downcase, "<mark>"+s.downcase.capitalize+"</mark>")
      end
    end
    return text
  end

  def recipe_converter(ingredient, converter)
    rational_number = ingredient.to_r
    replace_me = rational_number.to_s
    replace_me_too = rational_number.to_i.to_s
    return convert((ingredient.to_r * converter).to_f).to_s + ingredient.gsub(replace_me, "").gsub(replace_me_too, "")
  end

  def convert x
    Float(x)
    i, f = x.to_i, x.to_f
    i == f ? i : f
    rescue ArgumentError
    x
  end
end
