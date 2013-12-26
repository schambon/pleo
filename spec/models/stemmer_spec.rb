require 'spec_helper'
require 'java'

describe org.tartarus.snowball.ext.FrenchStemmer do

  it "stems" do
    stemmer = org.tartarus.snowball.ext.FrenchStemmer.new
    stemmer.setCurrent("apoplectiquement")
    stemmer.stem
    stemmer.getCurrent.should == 'apoplect'
  end
end

