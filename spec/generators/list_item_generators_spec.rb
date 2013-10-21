require_relative '../spec_helper'

class ListItemGenerators
  include Fluent

  li :list_short, id: 'list1'
  list_item :list, id: 'list2'
end

describe Fluent::Generators do
  let(:watir_browser)    { mock_browser_for_watir }
  let(:watir_definition) { ListItemGenerators.new(watir_browser) }

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
    end

    context 'when used by the watir platform' do
      it 'should locate the list item' do
        watir_browser.should_receive(:li).and_return(watir_browser)
        web_element = watir_definition.list_list_item
        web_element.should_not be_nil
        web_element.should be_instance_of Fluent::WebElements::ListItem
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