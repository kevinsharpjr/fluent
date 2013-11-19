require 'spec_helper'

class TestLocators
  include Fluent
end

describe Fluent::Locators do
  
  context 'using watir' do
    let(:watir_browser) { mock_browser_for_watir }
    let(:watir_definition) { TestLocators.new(watir_browser) }

    it 'should locate a button element' do
      watir_browser.should_receive(:button).with(id: 'test').and_return(watir_browser)
      element = watir_definition.button_locate(id: 'test')
      element.should be_instance_of Fluent::WebElements::Button
    end
    
    it 'should locate a button with a default locator' do
      watir_browser.should_receive(:button).with(index: 0).and_return(watir_browser)
      watir_definition.button_locate
    end
    
    it 'should locate a link element' do
      watir_browser.should_receive(:link).with(id: 'test').and_return(watir_browser)
      element = watir_definition.link_locate(id: 'test')
      element.should be_instance_of Fluent::WebElements::Link
    end

    it 'should locate a link with a default locator' do
      watir_browser.should_receive(:link).with(index: 0).and_return(watir_browser)
      watir_definition.link_locate
    end

    it 'should locate a radio element' do
      watir_browser.should_receive(:radio).with(id: 'test').and_return(watir_browser)
      element = watir_definition.radio_locate(id: 'test')
      element.should be_instance_of Fluent::WebElements::Radio
    end

    it 'should locate a radio with a default locator' do
      watir_browser.should_receive(:radio).with(index: 0).and_return(watir_browser)
      watir_definition.radio_locate
    end

    it 'should locate a checkbox' do
      watir_browser.should_receive(:checkbox).with(id: 'test').and_return(watir_browser)
      element = watir_definition.checkbox_locate(id: 'test')
      element.should be_instance_of Fluent::WebElements::CheckBox
    end

    it 'should locate a checkbox using a default locator' do
      watir_browser.should_receive(:checkbox).with(index: 0).and_return(watir_browser)
      watir_definition.checkbox_locate
    end

    it 'should locate a select list element' do
      watir_browser.should_receive(:select_list).with(id: 'test').and_return(watir_browser)
      element = watir_definition.select_list_locate(id: 'test')
      element.should be_instance_of Fluent::WebElements::SelectList
    end

    it 'should locate a select list using a default locator' do
      watir_browser.should_receive(:select_list).with(index: 0).and_return(watir_browser)
      watir_definition.select_list_locate
    end

    it 'should locate a text area element' do
      watir_browser.should_receive(:textarea).with(id: 'test').and_return(watir_browser)
      element = watir_definition.text_area_locate(id: 'test')
      element.should be_instance_of Fluent::WebElements::TextArea
    end

    it 'should locate a text area using a default locator' do
      watir_browser.should_receive(:textarea).with(index: 0).and_return(watir_browser)
      watir_definition.text_area_locate
    end

    it 'should locate a text field element' do
      watir_browser.should_receive(:text_field).with(id: 'test').and_return(watir_browser)
      element = watir_definition.text_field_locate(id: 'test')
      element.should be_instance_of Fluent::WebElements::TextField
    end

    it 'should locate a text field element using a default locator' do
      watir_browser.should_receive(:text_field).with(index: 0).and_return(watir_browser)
      watir_definition.text_field_locate
    end

    it 'should locate a table' do
      watir_browser.should_receive(:table).with(id: 'test').and_return(watir_browser)
      element = watir_definition.table_locate(id: 'test')
      element.should be_instance_of Fluent::WebElements::Table
    end

    it 'should locate a table using a default locator' do
      watir_browser.should_receive(:table).with(index: 0).and_return(watir_browser)
      watir_definition.table_locate
    end

    it 'should locate a table cell' do
      watir_browser.should_receive(:td).with(id: 'test').and_return(watir_browser)
      element = watir_definition.cell_locate(id: 'test')
      element.should be_instance_of Fluent::WebElements::Cell
    end

    it 'should locate a table cell using a default locator' do
      watir_browser.should_receive(:td).with(index: 0).and_return(watir_browser)
      watir_definition.cell_locate
    end

    it 'should locate a div' do
      watir_browser.should_receive(:div).with(id: 'test').and_return(watir_browser)
      element = watir_definition.div_locate(id: 'test')
      element.should be_instance_of Fluent::WebElements::Div
    end

    it 'should locate a div using a default locator' do
      watir_browser.should_receive(:div).with(index: 0).and_return(watir_browser)
      watir_definition.div_locate
    end

    it 'should locate a span' do
      watir_browser.should_receive(:span).with(id: 'test').and_return(watir_browser)
      element = watir_definition.span_locate(id: 'test')
      element.should be_instance_of Fluent::WebElements::Span
    end

    it 'should locate a span using a default locator' do
      watir_browser.should_receive(:span).with(index: 0).and_return(watir_browser)
      watir_definition.span_locate
    end

    it 'should locate an image' do
      watir_browser.should_receive(:image).with(id: 'test').and_return(watir_browser)
      element = watir_definition.image_locate(id: 'test')
      element.should be_instance_of Fluent::WebElements::Image
    end

    it 'should locate an image using a default locator' do
      watir_browser.should_receive(:image).with(index: 0).and_return(watir_browser)
      watir_definition.image_locate
    end

    it 'should locate a list item' do
      watir_browser.should_receive(:li).with(id: 'test').and_return(watir_browser)
      element = watir_definition.list_item_locate(id: 'test')
      element.should be_instance_of Fluent::WebElements::ListItem
    end

    it 'should locate a list item using a default locate' do
      watir_browser.should_receive(:li).with(index: 0).and_return(watir_browser)
      watir_definition.list_item_locate
    end

    it 'should locate an ordered list' do
      watir_browser.should_receive(:ol).with(id: 'test').and_return(watir_browser)
      element = watir_definition.ordered_list_locate(id: 'test')
      element.should be_instance_of Fluent::WebElements::OrderedList
    end

    it 'should locate an ordered list using a default locator' do
      watir_browser.should_receive(:ol).with(index: 0).and_return(watir_browser)
      watir_definition.ordered_list_locate
    end

    it 'should locate an unordered list' do
      watir_browser.should_receive(:ul).with(id: 'test').and_return(watir_browser)
      element = watir_definition.unordered_list_locate(id: 'test')
      element.should be_instance_of Fluent::WebElements::UnorderedList
    end

    it 'should locate an unordered list using a default locator' do
      watir_browser.should_receive(:ul).with(index: 0).and_return(watir_browser)
      watir_definition.unordered_list_locate
    end

    it 'should locate a form' do
      watir_browser.should_receive(:form).with(id: 'test').and_return(watir_browser)
      element = watir_definition.form_locate(id: 'test')
      element.should be_instance_of Fluent::WebElements::Form
    end

    it 'should locate a form using a default locator' do
      watir_browser.should_receive(:form).with(index: 0).and_return(watir_browser)
      watir_definition.form_locate
    end

    it 'should locate heading elements' do
      [:h1, :h2, :h3, :h4, :h5, :h6].each do |method|
        watir_browser.should_receive(method).with(id: 'test').and_return(watir_browser)
        element = watir_definition.send "#{method}_locate", {id: 'test'}
        element.should be_instance_of Fluent::WebElements::Heading
      end
    end

    it 'should locate heading elements using a default locator' do
      [:h1, :h2, :h3, :h4, :h5, :h6].each do |method|
        watir_browser.should_receive(method).with(index: 0).and_return(watir_browser)
        watir_definition.send "#{method}_locate"
      end
    end

    it 'should locate a paragraph element' do
      watir_browser.should_receive(:p).with(id: 'test').and_return(watir_browser)
      element = watir_definition.paragraph_locate(id: 'test')
      element.should be_instance_of Fluent::WebElements::Paragraph
    end

    it 'should locate a paragraph element using a default locator' do
      watir_browser.should_receive(:p).with(index: 0).and_return(watir_browser)
      watir_definition.paragraph_locate
    end

    it 'should locate a label' do
      watir_browser.should_receive(:label).with(id: 'text').and_return(watir_browser)
      element = watir_definition.label_locate(id: 'text')
      element.should be_instance_of Fluent::WebElements::Label
    end

    it 'should locate a label element using a default locator' do
      watir_browser.should_receive(:label).with(index: 0).and_return(watir_browser)
      watir_definition.label_locate
    end
    
  end
  
end