# encoding: UTF-8
require 'unicode_utils/downcase'

class Tokenizer

  def initialize
    @stemmer = Stemmer.new
    @stopwords = {}
    File.open(Rails.root.join('config').join('stop_words.txt')).each_line do |line|
      line = line.gsub(/\|.+/, "").gsub(/\W/, "")
      @stopwords[line] = "stop" if line != ''

    end
  end

  def tokenize(text)
    t = UnicodeUtils.downcase(text)   # use this rather than basic String.downcase to deal with accented letters correctly
    t = t.gsub(/[^a-zàáäâéèëêíìïîóòôöúùüûýỳÿŷçåůæø]/, ' ')
    i = 0
    j = 0
    @words = {}
    @word = ""
    t.each_char do | c |
      if (c == ' ')
        flush j
        j = i + 1 # on commence au mot suivant !
      else
        @word = @word + c 
      end

      i = i+1
    end
    flush j

    return @words
  end

  private

  def flush(index)
    if (! @stopwords.has_key? @word)
      w = @stemmer.stem @word
      @words[w] = [] if ! @words.has_key? w
      @words[w] << index
    end
    @word = ""
  end

end
