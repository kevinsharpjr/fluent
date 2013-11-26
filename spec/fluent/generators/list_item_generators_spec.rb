require 'spec_helper'

class ListItemGenerators
  include Fluent

  li :list_short, id: 'list1'
  list_item :list, id: 'list2'
  list_items :facts, class: 'fact'
end

describe Fluent::Generators do
  let(:watir_browser)    { mock_browser_for_watir }
  let(:watir_definition) { ListItemGenerators.new(watir_browser) }

  let(:list_item_object) { double('list_item_object') }
  let(:list_item_definition) { Fluent::WebElements::ListItem.new(list_item_object, :platform => :watir_webdriver) }

  describe 'list item generators' do
    context 'when declared on a page definition' do
      it 'should generate methods for referencing the list item' do
        watir_definition.should respond_to(:list_object)
        watir_definition.should respond_to(:list_element)
        watir_definition.should respond_to(:list_list_item)
        watir_definition.should respond_to(:list_short_li)
      end

      it 'should generate methods for interacting with the list item' do
        watir_definition.should respond_to(:list)
        watir_definition.should respond_to(:list_exists?)
        watir_definition.should respond_to(:list_visible?)
        watir_definition.should respond_to(:list?)
        watir_definition.should respond_to(:list_?)
        watir_definition.should respond_to(:list_li_exists?)
        watir_definition.should respond_to(:list_li_visible?)
        watir_definition.should respond_to(:list_li?)
        watir_definition.should respond_to(:list_li_?)
      end

      it 'should generate methods for multiple list items' do
        watir_definition.should respond_to(:facts_elements)
      end
    end

    context 'when used by the watir platform' do
      it 'should locate the list item' do
        watir_browser.should_receive(:li).and_return(watir_browser)
        web_element = watir_definition.list_list_item
        web_element.should_not be_nil
        web_element.should be_instance_of Fluent::WebElements::ListItem
      end

      it 'should locate multiple list items' do
        watir_browser.should_receive(:lis).and_return(watir_browser)
        watir_browser.should_receive(:[]).and_return(list_item_definition)
        watir_browser.should_receive(:map).and_return(watir_browser)
        web_elements = watir_definition.facts_elements
        web_elements.should_not be_nil
        web_elements[0].should be_instance_of Fluent::WebElements::ListItem
      end

      it 'should return the text of a list item' do
        watir_browser.should_receive(:li).twice.and_return(watir_browser)
        watir_browser.should_receive(:text).twice.and_return('testing')
        watir_definition.list.should == 'testing'
        watir_definition.list_short.should == 'testing'
      end
    end
  end

end