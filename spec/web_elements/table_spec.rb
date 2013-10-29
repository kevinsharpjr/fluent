require_relative '../spec_helper'

describe 'Fluent::WebElements::Table' do

  let(:table_object) { double('table_object') }
  let(:table_row_object) { double('table_row_object') }
  let(:table) { Fluent::WebElements::Table }
  
  it 'should register with a table tag' do
    ::Fluent::WebElements.get_class_for(:table).should == ::Fluent::WebElements::Table
  end

  context 'on the watir platform' do
    let(:watir_table) { Fluent::WebElements::Table.new(table_object, :platform => :watir_webdriver) }

    it 'should return a table row when indexed' do
      table_object.stub(:[]).with(1).and_return(table_object)
      watir_table[1].should be_instance_of Fluent::WebElements::TableRow
    end

    it 'should return the first row' do
      table_object.stub(:[]).with(0).and_return(table_object)
      watir_table.first_row.should be_instance_of Fluent::WebElements::TableRow
    end

    it 'should return the last row' do
      table_object.stub(:[]).with(-1).and_return(table_object)
      watir_table.last_row.should be_instance_of Fluent::WebElements::TableRow
    end

    it 'should return a row using text from the first column' do
      table_object.stub(:[]).with('row_text').and_return(table_object)
      table_object.should_receive(:rows).and_return(table_object)
      table_object.should_receive(:find_index).and_return('row_text')
      watir_table['row_text'].should be_instance_of Fluent::WebElements::TableRow
    end

    it 'should return the number of rows' do
      table_object.should_receive(:wd).and_return(table_object)
      table_object.should_receive(:find_elements).with(:xpath, './/child::tr').and_return(table_object)
      table_object.should_receive(:size).and_return(2)
      watir_table.rows.should == 2
    end

    it 'should iterate over the table rows' do
      watir_table.should_receive(:rows).and_return(2)
      table_object.stub(:[]).and_return(table_object)
      count = 0
      watir_table.each { |e| count += 1 }
      count.should == 2
    end
  end

end