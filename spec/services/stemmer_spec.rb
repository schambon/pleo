require 'spec_helper'

describe Stemmer do

  it "stems" do
    Stemmer.new.stem("apoplectiquement").should == "apoplect"
  end
end

