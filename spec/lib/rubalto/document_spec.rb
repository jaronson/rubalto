require 'spec_helper'

describe Rubalto::Document do
  describe 'initialization' do
    let(:path){ alto_fixture('large') }
    let(:instance){ Rubalto::Document.new(path) }

    it 'should set @xml' do
      instance.xml.should be_a(Nokogiri::XML::Document)
      require 'pry'; require 'pp'; binding.pry
    end
  end
end
