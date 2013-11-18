require 'spec_helper'

describe 'Fluent::WebElements::Image' do
  let(:image_object) { double('image_object') }
  let(:image_definition) { ::Fluent::WebElements::Image.new(image_object, :platform => :watir_webdriver) }
  
  it 'should register with a image tag' do
    ::Fluent::WebElements.get_class_for(:img).should == ::Fluent::WebElements::Image
  end

  context 'with watir-webdriver' do
    it 'should be able to determine the image width' do
      image_object.should_receive(:width).and_return(100)
      image_definition.width.should == 100
    end
    
    it 'should be able to determine the image height' do
      image_object.should_receive(:height).and_return(120)
      image_definition.height.should == 120
    end
    
    it 'should be able to determine if the image was loaded' do
      image_object.should_receive(:loaded?).and_return(true)
      image_definition.loaded?
    end
  end
  
end