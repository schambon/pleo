class TextController < ApplicationController


  def analyze
    t = (params[:threshold].to_i if is_i?(params[:threshold])) || 100
    @repet = Repetition.analyze(Tokenizer.new.tokenize(params[:text]), t)
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
        @output = @output + "<a data-repetid=\"#{f_o[:repet].id}\" class=\"repet_#{('%.3f' % f_o[:repet].score.round(3)).gsub(/\./, '')}\">"
        nextend = index + f_o[:occurrence].as_found.size
      end
      @output = @output + "</a>" if index == nextend
      @output = @output + c
      index = index + 1
    end


# for presentation (histogram…)
    @repet = @repet.sort { |r1,r2| r1.score <=> r2.score }.reverse

  end


  private

    def is_i?(string)
           !!(string =~ /^[-+]?[0-9]+$/)
    end
end
