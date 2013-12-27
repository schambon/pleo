require 'spec_helper'

describe Stemmer do

  it "stems" do
    Stemmer.new.stem("apoplectiquement").should == "apoplect"
  end

  it 'stems common French suffixes' do
    stemmer = Stemmer.new
    stemmer.stem( "constitutionnellement").should == "constitutionnel"
  end
end

