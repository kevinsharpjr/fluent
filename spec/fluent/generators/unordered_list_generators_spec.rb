require 'spec_helper'

class UnorderedListGenerators
  include Fluent

  ul :list_short, id: 'list1'
  unordered_list :list, id: 'list2'
  unordered_lists :facts, class: 'facts'
end

describe Fluent::Generators do
  let(:watir_browser)    { mock_browser_for_watir }
  let(:watir_definition) { UnorderedListGenerators.new(watir_browser) }

  let(:unordered_list_object) { double('unordered_list_object') }
  let(:unordered_list_definition) { Fluent::WebElements::UnorderedList.new(unordered_list_object, :platform => :watir_webdriver) }
  
  describe 'unordered list generators' do
    context 'when declared on a page definition' do
      it 'should generate methods for referencing the unordered list' do
        watir_definition.should respond_to(:list_object)
        watir_definition.should respond_to(:list_element)
        watir_definition.should respond_to(:list_unordered_list)
        watir_definition.should respond_to(:list_short_ul)
      end

      it 'should generate methods for interacting with the unordered list' do
        watir_definition.should respond_to(:list)
        watir_definition.should respond_to(:list_exists?)
        watir_definition.should respond_to(:list_visible?)
        watir_definition.should respond_to(:list?)
        watir_definition.should respond_to(:list_?)
        watir_definition.should respond_to(:list_ul_exists?)
        watir_definition.should respond_to(:list_ul_visible?)
        watir_definition.should respond_to(:list_ul?)
        watir_definition.should respond_to(:list_ul_?)
      end

      it 'should generate methods for multiple unordered lists' do
        watir_definition.should respond_to(:facts_elements)
      end
    end

    context 'when used by the watir platform' do
      it 'should locate the unordered list' do
        watir_browser.should_receive(:ul).and_return(watir_browser)
        web_element = watir_definition.list_unordered_list
        web_element.should_not be_nil
        web_element.should be_instance_of Fluent::WebElements::UnorderedList
      end

      it 'should locate multiple unordered lists' do
        watir_browser.should_receive(:uls).and_return(watir_browser)
        watir_browser.should_receive(:[]).and_return(unordered_list_definition)
        watir_browser.should_receive(:map).and_return(watir_browser)
        web_elements = watir_definition.facts_elements
        web_elements.should_not be_nil
        web_elements[0].should be_instance_of Fluent::WebElements::UnorderedList
      end
      
      it 'should return the text of a unordered list' do
        watir_browser.should_receive(:ul).twice.and_return(watir_browser)
        watir_browser.should_receive(:text).twice.and_return('testing')
        watir_definition.list.should == 'testing'
        watir_definition.list_short.should == 'testing'
      end
    end
  end

end