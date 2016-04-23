require 'verbs'

include 'verbs'

p = "Pot-roast".downcase.to_sym

v = Verbs::Conjugator.conjugate "roast".to_sym, :tense => :past, :aspect => :perfective
p v
