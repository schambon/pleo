# encoding: UTF-8
require 'spec_helper'

describe Tokenizer do
  it 'should return a hash' do
    Tokenizer.new.tokenize("les sanglots longs des violons de l'automne").should be_a Hash
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
    s["allô"].should == [0]
    s["hôpital"].should == [10]
  end

  it 'should handle multiple stems right' do
    s = Tokenizer.new.tokenize("apoplectiquement apoplectique")
    s["apoplect"].should == [0, 17]
  end

end
