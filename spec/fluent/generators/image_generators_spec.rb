require 'spec_helper'

class ImageGenerators
  include Fluent

  image :logo, id: 'logo'
  images :headers, class: 'headers'
end

describe Fluent::Generators do
  let(:watir_browser)    { mock_browser_for_watir }
  let(:watir_definition) { ImageGenerators.new(watir_browser) }

  let(:image_object) { double('image_object') }
  let(:image_definition) { Fluent::WebElements::Image.new(image_object, :platform => :watir_webdriver) }
  
  describe 'image generators' do
    context 'when declared on a page definition' do
      it 'should generate methods for referencing the image' do
        watir_definition.should respond_to(:logo_object)
        watir_definition.should respond_to(:logo_element)
        watir_definition.should respond_to(:logo_image)
      end

      it 'should generate the common actions for checking the image' do
        watir_definition.should respond_to(:logo_exists?)
        watir_definition.should respond_to(:logo_visible?)
        watir_definition.should respond_to(:logo?)
        watir_definition.should respond_to(:logo_?)
        watir_definition.should respond_to(:logo_image_exists?)
        watir_definition.should respond_to(:logo_image_visible?)
        watir_definition.should respond_to(:logo_image?)
        watir_definition.should respond_to(:logo_image_?)
      end
      
      it 'should generate specific methods for interacting with the image' do
        watir_definition.should respond_to(:logo_loaded?)
        watir_definition.should respond_to(:logo_height)
        watir_definition.should respond_to(:logo_width)
        watir_definition.should respond_to(:logo_src)
        watir_definition.should respond_to(:logo_alt)
      end
      
      it 'should generate methods for multiple images' do
        watir_definition.should respond_to(:headers_elements)
      end
    end

    context 'when used by the watir platform' do
      it 'should locate the image' do
        watir_browser.should_receive(:image).and_return(watir_browser)
        web_element = watir_definition.logo_object
        web_element.should_not be_nil
        web_element.should be_instance_of Fluent::WebElements::Image
      end

      it 'should locate multiple images' do
        watir_browser.should_receive(:images).and_return(watir_browser)
        watir_browser.should_receive(:[]).and_return(image_definition)
        watir_browser.should_receive(:map).and_return(watir_browser)
        web_elements = watir_definition.headers_elements
        web_elements.should_not be_nil
        web_elements[0].should be_instance_of Fluent::WebElements::Image
      end
      
      it 'should check if the image is loaded' do
        watir_browser.should_receive(:image).and_return(image_definition)
        image_object.should_receive(:loaded?).and_return(true)
        watir_definition.logo_loaded?
      end
      
      it 'should return the height of the image' do
        watir_browser.should_receive(:image).and_return(image_definition)
        image_object.should_receive(:height).twice.and_return(120)
        watir_definition.logo_height
        image_definition.height.should == 120
      end
      
      it 'should return the width of the image' do
        watir_browser.should_receive(:image).and_return(image_definition)
        image_object.should_receive(:width).twice.and_return(100)
        watir_definition.logo_width
        image_definition.width.should == 100
      end
      
      it 'should return the src attribute of the image' do
        image_object.should_receive(:attribute_value).with("src")
        watir_browser.should_receive(:image).and_return(image_object)
        watir_definition.logo_src
      end
      
      it 'should return the alt attribute of the image' do
        image_object.should_receive(:attribute_value).with("alt")
        watir_browser.should_receive(:image).and_return(image_object)
        watir_definition.logo_alt
      end
      
    end
  end
end