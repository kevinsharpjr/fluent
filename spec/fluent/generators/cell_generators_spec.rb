require 'spec_helper'

class CellGenerators
  include Fluent

  cell :total, id: 'total'
  cells :titles, id: 'titles'
end

describe Fluent::Generators do
  let(:watir_browser)    { mock_browser_for_watir }
  let(:watir_definition) { CellGenerators.new(watir_browser) }

  let(:cell_object) { double('cell_object') }
  let(:cell_definition) { Fluent::WebElements::Cell.new(cell_object, :platform => :watir_webdriver) }
  
  describe 'cell generators' do
    context 'when declared on a page definition' do
      it 'should generate methods for referencing the cell' do
        watir_definition.should respond_to(:total_object)
        watir_definition.should respond_to(:total_element)
        watir_definition.should respond_to(:total_cell)
        watir_definition.should respond_to(:total_td)
      end

      it 'should generate methods for interacting with the cell' do
        watir_definition.should respond_to(:total)
        watir_definition.should respond_to(:total_exists?)
        watir_definition.should respond_to(:total_visible?)
        watir_definition.should respond_to(:total?)
        watir_definition.should respond_to(:total_?)
        watir_definition.should respond_to(:total_td_exists?)
        watir_definition.should respond_to(:total_td_visible?)
        watir_definition.should respond_to(:total_td?)
        watir_definition.should respond_to(:total_td_?)
      end

      it 'should generate methods for multiple cells' do
        watir_definition.should respond_to(:titles_elements)
      end
    end

    context 'when used by the watir platform' do
      it 'should locate the cell' do
        watir_browser.should_receive(:td).and_return(watir_browser)
        web_element = watir_definition.total_cell
        web_element.should_not be_nil
        web_element.should be_instance_of Fluent::WebElements::Cell
      end

      it 'should locate multiple cells' do
        watir_browser.should_receive(:tds).and_return(watir_browser)
        watir_browser.should_receive(:[]).and_return(cell_definition)
        watir_browser.should_receive(:map).and_return(watir_browser)
        web_elements = watir_definition.titles_elements
        web_elements.should_not be_nil
        web_elements[0].should be_instance_of Fluent::WebElements::Cell
      end

      it 'should return the text of a table' do
        watir_browser.should_receive(:td).and_return(watir_browser)
        watir_browser.should_receive(:text).and_return('testing')
        watir_definition.total.should == 'testing'
      end
    end
  end
end