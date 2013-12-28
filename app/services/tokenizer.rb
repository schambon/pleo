# encoding: UTF-8
require 'unicode_utils/downcase'

class Tokenizer

  NOT_ALPHA = /[^a-zàáäâéèëêíìïîóòôöúùüûýỳÿŷçåůæøœ]/

  def initialize
    @stopwords = {}
    File.open(Rails.root.join('config').join('stop_words.txt')).each_line do |line|
      line = line.gsub(/\|.+/, "").gsub(NOT_ALPHA, "")
      @stopwords[line] = "stop" if line != ''
    end
  end

  def tokenize(text)
    t = UnicodeUtils.downcase(text)   # use this rather than basic String.downcase to deal with accented letters correctly
    t = t.gsub(NOT_ALPHA, ' ')
    char_counter = 0
    @word_start_counter = 0
    @word_counter = 0
    @words = {}
    @word = ""
    t.each_char do | c |
      if (c == ' ')
        flush
        @word_start_counter = char_counter + 1 # +1 because the next word starts after the space
      else
        @word = @word + c 
      end

      char_counter = char_counter + 1
    end
    flush

    return @words
  end

  private

  def flush
    if (@word != "" && !@stopwords.has_key?(@word))
      w = Word.new @word, @word_start_counter, @word_counter

      @words[w.stem] = [] if ! @words.has_key? w.stem
      @words[w.stem] << w

    end
    @word_counter = @word_counter + 1 unless @word == ""
    @word = ""
  end

end
