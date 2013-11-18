require 'spec_helper'

describe 'Fluent::WebElements::TableRow' do
  let(:table) { double('table') }
  let(:table_cell) { double('table_cell') }
  let(:table_row_object) { double('table_row_object') }

  context 'on the watir platform' do
    it 'should return a table cell when indexed by number' do
      table_row = Fluent::WebElements::TableRow.new(table_row_object, :platform => :watir_webdriver)

      table_row.stub(:columns).and_return(2)
      table_row_object.should_receive(:[]).with(1).and_return(table_cell)
      
      table_row[1].should be_instance_of Fluent::WebElements::Cell
    end

    # Determine why this is not working.
    #it 'should return a table cell when indexed by string' do
      #table_row = Fluent::WebElements::TableRow.new(table_row_object, :platform => :watir_webdriver)
      
      #table.should_receive(:[]).and_return(table_cell)
      #table.stub(:tag_name).and_return(table)
      #table_row_object.stub(:parent).and_return(table)
      #table_row_object.should_receive(:[]).with(0).and_return(table_cell)
      
      #table_row['test'].should be_instance_of Fluent::WebElements::Cell
    #end
    
    it 'should return the number of columns' do
      table_row = Fluent::WebElements::TableRow.new(table_row_object, :platform => :watir_webdriver)
      table_row_object.stub(:wd).and_return(table_row_object)
      table_row_object.should_receive(:find_elements).with(:xpath, './/child::td|th').and_return(table_row_object)
      table_row_object.should_receive(:size).and_return(3)
      table_row.columns.should == 3
    end

    it 'should iterate over the table columns' do
      table_row = Fluent::WebElements::TableRow.new(table_row_object, :platform => :watir_webdriver)
      table_row.should_receive(:columns).and_return(2)
      table_row.stub(:[]).and_return(table_row_object)
      count = 0
      table_row.each { |e| count += 1 }
      count.should == 2
    end
  end
end