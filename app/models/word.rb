# a word (actually a stem) found in the text input
class Word

  attr_accessor :stem, :char_position, :word_position, :as_found

  def initialize(text, char_position, word_position)
    @stem = Stemmer.new.stem text
    @char_position = char_position
    @word_position = word_position
    @as_found = text
  end


end
