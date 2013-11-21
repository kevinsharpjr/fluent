require 'spec_helper'

class HeadingGenerators
  include Fluent

  h1 :headingOne, id: 'headingOne'
  h2 :headingTwo, id: 'headingTwo'
  h3 :headingThree, id: 'headingThree'
  h4 :headingFour, id: 'headingFour'
  h5 :headingFive, id: 'headingFive'
  h6 :headingSix, id: 'headingSix'
  
  h1s :headingsOne, class: 'headingsOne'
  h2s :headingsTwo, class: 'headingsTwo'
  h3s :headingsThree, class: 'headingsThree'
  h4s :headingsFour, class: 'headingsFour'
  h5s :headingsFive, class: 'headingsFive'
  h6s :headingsSix, class: 'headingsSix'
end

describe Fluent::Generators do
  let(:watir_browser)    { mock_browser_for_watir }
  let(:watir_definition) { HeadingGenerators.new(watir_browser) }

  let(:heading_object) { double('heading_object') }
  let(:heading_definition) { Fluent::WebElements::Heading.new(heading_object, :platform => :watir_webdriver) }

  describe 'heading generators' do
    context 'when declared on a page definition' do
      it 'should generate methods for referencing the heading' do
        watir_definition.should respond_to(:headingOne_object)
        watir_definition.should respond_to(:headingTwo_object)
        watir_definition.should respond_to(:headingThree_object)
        watir_definition.should respond_to(:headingFour_object)
        watir_definition.should respond_to(:headingFive_object)
        watir_definition.should respond_to(:headingSix_object)
      end
      
      it 'should generate methods for interacting with the heading' do
        watir_definition.should respond_to(:headingOne)
        watir_definition.should respond_to(:headingTwo)
        watir_definition.should respond_to(:headingThree)
        watir_definition.should respond_to(:headingFour)
        watir_definition.should respond_to(:headingFive)
        watir_definition.should respond_to(:headingSix)
      end

      it 'should generate methods for multiple headings' do
        watir_definition.should respond_to(:headingsOne_elements)
        watir_definition.should respond_to(:headingsTwo_elements)
        watir_definition.should respond_to(:headingsThree_elements)
        watir_definition.should respond_to(:headingsFour_elements)
        watir_definition.should respond_to(:headingsFive_elements)
        watir_definition.should respond_to(:headingsSix_elements)
      end
    end

    context 'when used by the watir platform' do
      it 'should locate the heading' do
        watir_browser.should_receive(:h1).and_return(watir_browser)
        web_element = watir_definition.headingOne_h1
        web_element.should_not be_nil
        web_element.should be_instance_of Fluent::WebElements::Heading

        watir_browser.should_receive(:h2).and_return(watir_browser)
        web_element = watir_definition.headingTwo_h2
        web_element.should be_instance_of Fluent::WebElements::Heading

        watir_browser.should_receive(:h3).and_return(watir_browser)
        web_element = watir_definition.headingThree_h3
        web_element.should be_instance_of Fluent::WebElements::Heading

        watir_browser.should_receive(:h4).and_return(watir_browser)
        web_element = watir_definition.headingFour_h4
        web_element.should be_instance_of Fluent::WebElements::Heading

        watir_browser.should_receive(:h5).and_return(watir_browser)
        web_element = watir_definition.headingFive_h5
        web_element.should be_instance_of Fluent::WebElements::Heading

        watir_browser.should_receive(:h6).and_return(watir_browser)
        web_element = watir_definition.headingSix_h6
        web_element.should be_instance_of Fluent::WebElements::Heading
      end

      it 'should locate multiple headings' do
        watir_browser.should_receive(:h1s).and_return(watir_browser)
        watir_browser.should_receive(:h2s).and_return(watir_browser)
        watir_browser.should_receive(:h3s).and_return(watir_browser)
        watir_browser.should_receive(:h4s).and_return(watir_browser)
        watir_browser.should_receive(:h5s).and_return(watir_browser)
        watir_browser.should_receive(:h6s).and_return(watir_browser)
        
        watir_browser.should_receive(:[]).exactly(6).times.and_return(heading_definition)
        watir_browser.should_receive(:map).exactly(6).times.and_return(watir_browser)
        
        web_elements = watir_definition.headingsOne_elements
        web_elements[0].should be_instance_of Fluent::WebElements::Heading
        
        web_elements = watir_definition.headingsTwo_elements
        web_elements[0].should be_instance_of Fluent::WebElements::Heading
        
        web_elements = watir_definition.headingsThree_elements
        web_elements[0].should be_instance_of Fluent::WebElements::Heading

        web_elements = watir_definition.headingsFour_elements
        web_elements[0].should be_instance_of Fluent::WebElements::Heading

        web_elements = watir_definition.headingsFive_elements
        web_elements[0].should be_instance_of Fluent::WebElements::Heading

        web_elements = watir_definition.headingsSix_elements
        web_elements[0].should be_instance_of Fluent::WebElements::Heading
      end

      it 'should return the text of a heading' do
        watir_browser.should_receive(:h1).and_return(watir_browser)
        watir_browser.should_receive(:text).and_return('testing')
        watir_definition.headingOne.should == 'testing'

        watir_browser.should_receive(:h2).and_return(watir_browser)
        watir_browser.should_receive(:text).and_return('testing')
        watir_definition.headingTwo.should == 'testing'

        watir_browser.should_receive(:h3).and_return(watir_browser)
        watir_browser.should_receive(:text).and_return('testing')
        watir_definition.headingThree.should == 'testing'

        watir_browser.should_receive(:h4).and_return(watir_browser)
        watir_browser.should_receive(:text).and_return('testing')
        watir_definition.headingFour.should == 'testing'

        watir_browser.should_receive(:h5).and_return(watir_browser)
        watir_browser.should_receive(:text).and_return('testing')
        watir_definition.headingFive.should == 'testing'

        watir_browser.should_receive(:h6).and_return(watir_browser)
        watir_browser.should_receive(:text).and_return('testing')
        watir_definition.headingSix.should == 'testing'
      end
    end
  end
  
end