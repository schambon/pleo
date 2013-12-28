class TextController < ApplicationController


  def analyze
    @repet = Repetition.analyze(Tokenizer.new.tokenize(params[:text]))
    rep_by_char_idx = {}
    @repet.each do |r|
      r.occurrences.each do |o|
        rep_by_char_idx[o.char_position] = {:repet => r, :occurrence => o}
      end
    end

    @output = ""
    index = 0
    nextend = -1
    params[:text].each_char do |c|
      f_o = rep_by_char_idx[index]
      if f_o != nil
        @output = @output + "<a id=\"#{f_o[:repet].id}\" class=\"repet_#{('%.3f' % f_o[:repet].score.round(3)).gsub(/\./, '')}\">"
        nextend = index + f_o[:occurrence].as_found.size
      end
      @output = @output + "</a>" if index == nextend
      @output = @output + c
      index = index + 1
    end


  end
end
