require 'spec_helper'

class TableGenerators
  include Fluent

  table :accounts, id: 'accounts'
end

describe Fluent::Generators do
  let(:watir_browser)    { mock_browser_for_watir }
  let(:watir_definition) { TableGenerators.new(watir_browser) }

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
    end

    context 'when used by the watir platform' do
      it 'should locate the table' do
        watir_browser.should_receive(:table).and_return(watir_browser)
        web_element = watir_definition.accounts_table
        web_element.should_not be_nil
        web_element.should be_instance_of Fluent::WebElements::Table
      end

      it 'should return the text of a table' do
        watir_browser.should_receive(:table).and_return(watir_browser)
        watir_browser.should_receive(:text).and_return('testing')
        watir_definition.accounts.should == 'testing'
      end
    end
  end
end