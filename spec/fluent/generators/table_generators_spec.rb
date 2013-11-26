require 'spec_helper'

class TableGenerators
  include Fluent

  table :accounts, id: 'accounts'
  tables :books, id: 'books'
end

describe Fluent::Generators do
  let(:watir_browser)    { mock_browser_for_watir }
  let(:watir_definition) { TableGenerators.new(watir_browser) }

  let(:table_object) { double('table_object') }
  let(:table_definition) { Fluent::WebElements::Table.new(table_object, :platform => :watir_webdriver) }
  
  describe 'table generators' do
    context 'when declared on a page definition' do
      it 'should generate methods for referencing the table' do
        watir_definition.should respond_to(:accounts_object)
        watir_definition.should respond_to(:accounts_element)
        watir_definition.should respond_to(:accounts_table)
      end

      it 'should generate methods for interacting with the table' do
        watir_definition.should respond_to(:accounts)
        watir_definition.should respond_to(:accounts_exists?)
        watir_definition.should respond_to(:accounts_visible?)
        watir_definition.should respond_to(:accounts?)
        watir_definition.should respond_to(:accounts_?)
        watir_definition.should respond_to(:accounts_table_exists?)
        watir_definition.should respond_to(:accounts_table_visible?)
        watir_definition.should respond_to(:accounts_table?)
        watir_definition.should respond_to(:accounts_table_?)
      end

      it 'should generate methods for multiple tables' do
        watir_definition.should respond_to(:books_elements)
      end
    end

    context 'when used by the watir platform' do
      it 'should locate the table' do
        watir_browser.should_receive(:table).and_return(watir_browser)
        web_element = watir_definition.accounts_table
        web_element.should_not be_nil
        web_element.should be_instance_of Fluent::WebElements::Table
      end

      it 'should locate multiple tables' do
        watir_browser.should_receive(:tables).and_return(watir_browser)
        watir_browser.should_receive(:[]).and_return(table_definition)
        watir_browser.should_receive(:map).and_return(watir_browser)
        web_elements = watir_definition.books_elements
        web_elements.should_not be_nil
        web_elements[0].should be_instance_of Fluent::WebElements::Table
      end
      
      it 'should return the text of a table' do
        watir_browser.should_receive(:table).and_return(watir_browser)
        watir_browser.should_receive(:text).and_return('testing')
        watir_definition.accounts.should == 'testing'
      end
    end
  end
end