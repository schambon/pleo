# encoding: UTF-8
require 'spec_helper'

describe Tokenizer do
  it 'should return a hash' do
    s = Tokenizer.new.tokenize("les sanglots longs des violons de l'automne")
    s.should be_a Hash
  end

  it 'should ignore stop words' do
    s = Tokenizer.new.tokenize("les sanglots longs des violons de l'automne")
    s.should_not have_key "les"
    s.should_not have_key "des"
    s.should_not have_key "de"
    s.should_not have_key "l"
  end

  it 'should have stems for non-stop words' do
    s = Tokenizer.new.tokenize("les sanglots longs des violons de l'automne")
    s.should have_key "sanglot"
    s.should have_key "violon"
  end

  it 'should convert to lowercase' do
    s = Tokenizer.new.tokenize("ALLÔ")
    s.should have_key "allô"
  end

  it 'should find correct indices' do
    s = Tokenizer.new.tokenize("allô de l'hôpital")
    s.should have_key "allô"
    s["allô"][0].char_position.should == 0
    s["allô"][0].word_position.should == 0
    s["hôpital"][0].char_position.should == 10
    s["hôpital"][0].word_position.should == 3
  end

  it 'should handle multiple stems right' do
    s = Tokenizer.new.tokenize("apoplectiquement apoplectique")
    s["apoplect"].size.should == 2
    s["apoplect"][0].char_position.should == 0
    s["apoplect"][1].char_position.should == 17
    s["apoplect"][0].word_position.should == 0
    s["apoplect"][1].word_position.should == 1
  end

  it 'should ignore double spaces' do
    s = Tokenizer.new.tokenize("le vison   voyageur")
    s.should have_key "voyageur"
    s["voyageur"].should be_an Array
    s["voyageur"].size.should == 1
    s["voyageur"][0].should be_a Word
    s["voyageur"][0].word_position.should == 2
    s.should_not have_key ""
  end

end
