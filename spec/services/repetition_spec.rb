# encoding: UTF-8

require 'spec_helper'


 SAMPLE = <<-END
 Ô toi, le plus savant et le plus beau des Anges,
  Dieu trahi par le sort et privé de louanges,

   Ô Satan, prends pitié de ma longue misère!

    Ô Prince de l'exil, à qui l'on a fait tort
     Et qui, vaincu, toujours te redresses plus fort,

      Ô Satan, prends pitié de ma longue misère!
    END

describe Repetition do

  describe 'Nominal case' do
    tk = Tokenizer.new.tokenize SAMPLE
    repet = Repetition.analyze tk

    it 'should return an array' do
      repet.should be_an Array
    end

    it 'should contain repetitions' do
      repet.size.should > 0
      repet[0].should be_a Repetition
    end

    it 'should contain ô' do
      o = repet.select {|r| r.stem == 'ô'}
      o.should_not be_empty
      o.size.should == 1
      o[0].occurrences.size.should == 4
    end
  end

  describe 'Short threshold' do
    tk = Tokenizer.new.tokenize SAMPLE
    repet = Repetition.analyze tk, 5
    it 'should not contain ô' do
      o = repet.select {|r| r.stem == 'ô'}
      o.should be_empty
    end
    it 'should contain plus' do
      plus = repet.select{|r| r.stem =='plus'}
      plus.should_not be_empty
      plus[0].occurrences.size.should == 2
    end
  end

end

