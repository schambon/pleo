require 'java'

class Stemmer

  def stem(string)
    stemmer = org.tartarus.snowball.ext.FrenchStemmer.new
    stemmer.setCurrent(string)
    stemmer.stem
    return stemmer.getCurrent
  end
end
