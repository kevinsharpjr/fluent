require_relative '../spec_helper'

describe 'Fluent::WebElements::OrderedList' do

  it 'should register with a ordered list tag' do
    ::Fluent::WebElements.get_class_for(:ol).should == ::Fluent::WebElements::OrderedList
  end

  context 'on the watir platform' do
    let(:ol_element) { double('ol_element') }
    let(:watir_ordered_list) { Fluent::WebElements::OrderedList.new(ol_element, :platform => :watir_webdriver) }

    it 'should return a list item when indexed' do
      ol_element.stub(:ols).and_return([ol_element])
      ol_element.stub(:find_elements).and_return(ol_element)
      ol_element.stub(:map).and_return([ol_element])
      ol_element.stub(:parent).and_return(ol_element)
      ol_element.stub(:element).and_return(ol_element)
      ol_element.stub(:==).and_return(true)
      watir_ordered_list[1]
    end

    it 'should know how many list items it contains' do
      ol_element.stub(:ols).and_return([ol_element])
      ol_element.stub(:find_elements).and_return(ol_element)
      ol_element.stub(:map).and_return([ol_element])
      ol_element.stub(:parent).and_return(ol_element)
      ol_element.stub(:element).and_return(ol_element)
      ol_element.stub(:==).and_return(true)
      watir_ordered_list.items.should == 1
    end

    it 'should iterate over the list items' do
      watir_ordered_list.should_receive(:items).and_return(5)
      watir_ordered_list.stub(:[])
      count = 0
      watir_ordered_list.each { |item| count += 1 }
      count.should == 5
    end
  end

end