module ApplicationHelper

  def highlight_ingredients(text, match_array)
    stuff = []
    match_array.each do |m|
      stuff << Procedure.find(m.procedure_id).past_tense_term
    end
    stuff.each do |s|
      if text.include?(" "+s+" ")
        if true
          text = text.gsub(" "+s+" ", "<mark>"+s+"</mark>")
        end
      elsif text.downcase.include?(" "+s.downcase+" ")
        text = text.downcase.gsub(s.downcase, "<mark>"+s.downcase.capitalize+"</mark>")
      end
    end
    return text.downcase
  end

  def highlight_directions(text, match_array)
    stuff = []
    match_array.each do |m|
      stuff << Procedure.find(m.procedure_id).term
    end
    stuff.each do |s|
      if text.include?(" "+s+" ")
        text = text.gsub(" "+s+" ", "<mark>"+s+"</mark>")
      elsif text.downcase.include?(" "+s.downcase+" ")
        text = text.downcase.gsub(" "+s.downcase+" ", "<mark>"+s.downcase.capitalize+"</mark>")
      end
    end
    return text.capitalize

  end

  def recipe_converter(ingredient, converter)
    i = ingredient.index(/[a-zA-Z(]/)
    rough_number = ingredient[0,i].strip
    rational_number = mixed_number_to_rational(rough_number)
    if rational_number == 0 || rational_number == false
      return ingredient
    else
      return convert((rational_number*converter).to_f).to_s + ingredient[i-1, ingredient.length]
    end
  end

  def convert x
    Float(x)
    i, f = x.to_i, x.to_f
    i == f ? i : f
    rescue ArgumentError
    x
  end

  def is_rational?(object)
    true if Rational(object) rescue false
  end

  def mixed_number_to_rational(amount)
    rational_to_return = 0
    amount.split(" ").each { |string|
      if is_rational?(string) # Number?
        if string.include?("/") # Fraction?
          rational_to_return += Rational(string)
        elsif string.to_i == string.to_f # Whole number?
          rational_to_return += string.to_i
        elsif string.include?(".") # Decimal?
          rational_to_return += Rational(string)
        else # Not a fraction, decimal, or whole number.
          return false
        end
      else
        return false # Not a number.
      end
    }
    rational_to_return
  end
end
