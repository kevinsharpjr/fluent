require 'spec_helper'

class SelectListGenerators
  include Fluent

  select_list :list, id: 'list'
  select_lists :book, class: 'book'
end

describe Fluent::Generators do
  let(:watir_browser)    { mock_browser_for_watir }
  let(:watir_definition) { SelectListGenerators.new(watir_browser) }

  let(:select_list_object) { double('select_list_object') }
  let(:select_list_definition) { Fluent::WebElements::SelectList.new(select_list_object, :platform => :watir_webdriver) }

  describe 'select list generators' do
    context 'when declared on a page definition' do
      it 'should generate methods for referencing the select list' do
        watir_definition.should respond_to(:list_object)
        watir_definition.should respond_to(:list_element)
        watir_definition.should respond_to(:list_select_list)
      end

      it 'should generate the common actions for checking the select list' do
        watir_definition.should respond_to(:list_exists?)
        watir_definition.should respond_to(:list_visible?)
        watir_definition.should respond_to(:list?)
        watir_definition.should respond_to(:list_?)
        watir_definition.should respond_to(:list_select_list?)
        watir_definition.should respond_to(:list_select_list_?)
        watir_definition.should respond_to(:list_select_list_exists?)
        watir_definition.should respond_to(:list_select_list_visible?)
      end

      it 'should generate common actions for enabled state' do
        watir_definition.should respond_to(:list_enabled?)
        watir_definition.should respond_to(:list!)
        watir_definition.should respond_to(:list_select_list!)
        watir_definition.should respond_to(:list_select_list_enabled?)
      end

      it 'should generate specific actions for interacting with the select list' do
        watir_definition.should respond_to(:list)
        watir_definition.should respond_to(:list=)
        watir_definition.should respond_to(:list_value?)
        watir_definition.should respond_to(:list_options?)
        watir_definition.should respond_to(:list_set)
        watir_definition.should respond_to(:list_get)
      end
      
      it 'should generate methods for multiple select lists' do
        watir_definition.should respond_to(:book_elements)
      end
    end

    context 'when used by the watir platform' do
      it 'should locate the select list' do
        watir_browser.should_receive(:select_list).and_return(watir_browser)
        web_element = watir_definition.list_object
        web_element.should_not be_nil
        web_element.should be_instance_of Fluent::WebElements::SelectList
      end

      it 'should locate multiple select lists' do
        watir_browser.should_receive(:select_lists).and_return(watir_browser)
        watir_browser.should_receive(:[]).and_return(select_list_definition)
        watir_browser.should_receive(:map).and_return(watir_browser)
        web_elements = watir_definition.book_elements
        web_elements.should_not be_nil
        web_elements[0].should be_instance_of Fluent::WebElements::SelectList
      end

      it 'should select an option from the select list' do
        watir_browser.should_receive(:select_list).twice.and_return watir_browser
        watir_browser.should_receive(:select).twice.with('testing')
        watir_definition.list = 'testing'
        watir_definition.list_set 'testing'
      end

      it 'should retrieve the current selected option from the select list' do
        selected = 'testing'
        selected.should_receive(:text).twice.and_return('testing')
        watir_browser.should_receive(:select_list).twice.and_return(watir_browser)
        watir_browser.should_receive(:selected_options).twice.and_return([selected])
        watir_definition.list.should == 'testing'
        watir_definition.list_get.should == 'testing'
      end
      
      it 'should retrieve the current value of a selected option' do
        watir_browser.should_receive(:select_list).and_return(watir_browser)
        watir_browser.should_receive(:value).and_return('testing')
        watir_definition.list_value?.should == 'testing'
      end

      it 'should retrieve a list of of selection options' do
        option1 = double('option')
        option2 = double('option')
        option1.should_receive(:text).and_return('list_item_1')
        option2.should_receive(:text).and_return('list_item_2')
        select_element = double('select')
        select_element.should_receive(:options).twice.and_return([option1, option2])
        watir_definition.should_receive(:list_object).and_return(select_element)
        watir_definition.list_options?.should == ['list_item_1','list_item_2']
      end
      
      it 'should return an option when indexed' do
        list_element = double('select_list')
        options = [list_element, list_element]
        web_element = Fluent::WebElements::SelectList.new(list_element, :platform => :watir_webdriver)
        list_element.should_receive(:wd).and_return(list_element)
        list_element.should_receive(:find_elements).with(:xpath, './/child::option').and_return(options)
        web_element[0].should be_instance_of Fluent::WebElements::Option
      end
      
      it 'should return an array of options when indexed' do
        list_element = double('select_list')
        options = [list_element, list_element]
        web_element = Fluent::WebElements::SelectList.new(list_element, :platform => :watir_webdriver)
        list_element.should_receive(:wd).and_return(list_element)
        list_element.should_receive(:find_elements).with(:xpath, './/child::option').and_return(options)
        web_element.options.size.should == 2
      end
      
      it 'should determine if a select list exists' do
        watir_browser.should_receive(:select_list).exactly(3).times.and_return(watir_browser)
        watir_browser.should_receive(:exists?).exactly(3).times.and_return(watir_browser)
        watir_definition.list_select_list_exists?.should be_true
        watir_definition.list_exists?.should be_true
        watir_definition.list?.should be_true
      end

      it 'should determine if a select list is visible' do
        watir_browser.should_receive(:select_list).exactly(3).times.and_return(watir_browser)
        watir_browser.should_receive(:present?).exactly(3).times.and_return(watir_browser)
        watir_definition.list_select_list_visible?.should be_true
        watir_definition.list_visible?.should be_true
        watir_definition.list_?.should be_true
      end

      it 'should determine if a select list is enabled' do
        watir_browser.should_receive(:select_list).exactly(3).times.and_return(watir_browser)
        watir_browser.should_receive(:enabled?).exactly(3).times.and_return(watir_browser)
        watir_definition.list_select_list_enabled?.should be_true
        watir_definition.list_enabled?.should be_true
        watir_definition.list!.should be_true
      end
    end
  end
end