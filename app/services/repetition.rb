class Repetition

  attr_accessor :stem, :occurrences



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

    return result
  end

  private

  def self.from_stem_and_array (stem, occurrences)
    r = Repetition.new
    r.stem = stem
    r.occurrences = occurrences

    return r
  end

end
