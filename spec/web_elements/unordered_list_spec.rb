require_relative '../spec_helper'

describe 'Fluent::WebElements::UnorderedList' do

  it 'should register with a unordered list tag' do
    ::Fluent::WebElements.get_class_for(:ul).should == ::Fluent::WebElements::UnorderedList
  end

  context 'on the watir platform' do
    let(:ul_element) { double('ul_element') }
    let(:watir_unordered_list) { Fluent::WebElements::UnorderedList.new(ul_element, :platform => :watir_webdriver) }

    it 'should return a list item when indexed' do
      ul_element.stub(:uls).and_return([ul_element])
      ul_element.stub(:find_elements).and_return(ul_element)
      ul_element.stub(:map).and_return([ul_element])
      ul_element.stub(:parent).and_return(ul_element)
      ul_element.stub(:element).and_return(ul_element)
      ul_element.stub(:==).and_return(true)
      watir_unordered_list[1]
    end

    it 'should know how many list items it contains' do
      ul_element.stub(:uls).and_return([ul_element])
      ul_element.stub(:find_elements).and_return(ul_element)
      ul_element.stub(:map).and_return([ul_element])
      ul_element.stub(:parent).and_return(ul_element)
      ul_element.stub(:element).and_return(ul_element)
      ul_element.stub(:==).and_return(true)
      watir_unordered_list.items.should == 1
    end

    it 'should iterate over the list items' do
      watir_unordered_list.should_receive(:items).and_return(5)
      watir_unordered_list.stub(:[])
      count = 0
      watir_unordered_list.each { |item| count += 1 }
      count.should == 5
    end
  end

end