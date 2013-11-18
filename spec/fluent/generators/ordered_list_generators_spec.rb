require 'spec_helper'

class OrderedListGenerators
  include Fluent
  
  ol :list_short, id: 'list1'
  ordered_list :list, id: 'list2'
end

describe Fluent::Generators do
  let(:watir_browser)    { mock_browser_for_watir }
  let(:watir_definition) { OrderedListGenerators.new(watir_browser) }

  describe 'ordered list generators' do
    context 'when declared on a page definition' do
      it 'should generate methods for referencing the ordered list' do
        watir_definition.should respond_to(:list_object)
        watir_definition.should respond_to(:list_element)
        watir_definition.should respond_to(:list_ordered_list)
        watir_definition.should respond_to(:list_short_ol)
      end

      it 'should generate methods for interacting with the ordered list' do
        watir_definition.should respond_to(:list)
        watir_definition.should respond_to(:list_exists?)
        watir_definition.should respond_to(:list_visible?)
        watir_definition.should respond_to(:list?)
        watir_definition.should respond_to(:list_?)
        watir_definition.should respond_to(:list_ol_exists?)
        watir_definition.should respond_to(:list_ol_visible?)
        watir_definition.should respond_to(:list_ol?)
        watir_definition.should respond_to(:list_ol_?)
      end
    end

    context 'when used by the watir platform' do
      it 'should locate the ordered list' do
        watir_browser.should_receive(:ol).and_return(watir_browser)
        web_element = watir_definition.list_ordered_list
        web_element.should_not be_nil
        web_element.should be_instance_of Fluent::WebElements::OrderedList
      end

      it 'should return the text of a ordered list' do
        watir_browser.should_receive(:ol).twice.and_return(watir_browser)
        watir_browser.should_receive(:text).twice.and_return('testing')
        watir_definition.list.should == 'testing'
        watir_definition.list_short.should == 'testing'
      end
    end
  end
  
end