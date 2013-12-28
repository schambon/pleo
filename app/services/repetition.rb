require 'rubygems'
require 'ruby-debug'

class Repetition

  attr_accessor :stem, :occurrences
  attr_accessor :score

  def id
    stem + "_" + @rnd.to_s
  end

  def self.analyze(hash_of_list_of_words, threshold = 400)
    result = []
    hash_of_list_of_words.each_pair do |stem, word_list|
      if (word_list.size != 0)
        all_repetitions_of_stem = []
        current_repetition = []
        last = nil
        word_list.each do |w|
          if last != nil
            diff = w.word_position - last.word_position
            if diff < threshold
              current_repetition << last if current_repetition.empty?
              current_repetition << w
            else
              all_repetitions_of_stem << current_repetition unless current_repetition.empty?
              current_repetition = []
            end
          end
          last = w
        end
        all_repetitions_of_stem << current_repetition unless current_repetition.empty?
        all_repetitions_of_stem.each { |r| result << Repetition.from_stem_and_array(stem, r) }
      end
    end


    max = result.max_by{|r| r.score}.score
    result.each {|r| r.score = r.score / max }
    return result


  end

  def calculate_score
    min = nil
    prev = nil
    # I guess there is a more functional way to do this, with inject or something
    @occurrences.each do |o|
      if prev != nil
        diff = o.word_position - prev.word_position
        min = diff if min == nil || diff < min
      end
      prev = o
    end
    @score = @occurrences.size.to_f / min.to_f


    @rnd = rand(100)
  end

  private

  def self.from_stem_and_array (stem, occurrences)
    r = Repetition.new
    r.stem = stem
    r.occurrences = occurrences
    r.calculate_score
    return r
  end

end
