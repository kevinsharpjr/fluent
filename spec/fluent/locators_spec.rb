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

    it 'should locate all button elements' do
      watir_browser.should_receive(:buttons).with(class: 'test').and_return([watir_browser])
      elements = watir_definition.button_elements(class: 'test')
      elements[0].should be_instance_of Fluent::WebElements::Button
    end
    
    it 'should locate a button using a default locator' do
      watir_browser.should_receive(:button).with(index: 0).and_return(watir_browser)
      watir_definition.button_locate
    end

    it 'should locate all buttons using a default locator' do
      watir_browser.should_receive(:buttons).with({}).and_return([watir_browser])
      watir_definition.button_elements
    end
    
    it 'should locate a link element' do
      watir_browser.should_receive(:link).with(id: 'test').and_return(watir_browser)
      element = watir_definition.link_locate(id: 'test')
      element.should be_instance_of Fluent::WebElements::Link
    end

    it 'should locate all link elements' do
      watir_browser.should_receive(:links).with(class: 'test').and_return([watir_browser])
      elements = watir_definition.link_elements(class: 'test')
      elements[0].should be_instance_of Fluent::WebElements::Link
    end

    it 'should locate a link using a default locator' do
      watir_browser.should_receive(:link).with(index: 0).and_return(watir_browser)
      watir_definition.link_locate
    end

    it 'should locate all links using a default locator' do
      watir_browser.should_receive(:links).with({}).and_return([watir_browser])
      watir_definition.link_elements
    end

    it 'should locate a radio element' do
      watir_browser.should_receive(:radio).with(id: 'test').and_return(watir_browser)
      element = watir_definition.radio_locate(id: 'test')
      element.should be_instance_of Fluent::WebElements::Radio
    end

    it 'should locate all radio elements' do
      watir_browser.should_receive(:radios).with(class: 'test').and_return([watir_browser])
      elements = watir_definition.radio_elements(class: 'test')
      elements[0].should be_instance_of Fluent::WebElements::Radio
    end

    it 'should locate a radio using a default locator' do
      watir_browser.should_receive(:radio).with(index: 0).and_return(watir_browser)
      watir_definition.radio_locate
    end

    it 'should find all radio elements using a default identifier' do
      watir_browser.should_receive(:radios).with({}).and_return([watir_browser])
      watir_definition.radio_elements
    end

    it 'should locate a checkbox' do
      watir_browser.should_receive(:checkbox).with(id: 'test').and_return(watir_browser)
      element = watir_definition.checkbox_locate(id: 'test')
      element.should be_instance_of Fluent::WebElements::CheckBox
    end

    it 'should locate all checkbox elements' do
      watir_browser.should_receive(:checkboxes).with(class: 'test').and_return([watir_browser])
      elements = watir_definition.checkbox_elements(class: 'test')
      elements[0].should be_instance_of Fluent::WebElements::CheckBox
    end

    it 'should locate a checkbox using a default locator' do
      watir_browser.should_receive(:checkbox).with(index: 0).and_return(watir_browser)
      watir_definition.checkbox_locate
    end

    it 'should locate all checkbox elements using a default locator' do
      watir_browser.should_receive(:checkboxes).with({}).and_return([watir_browser])
      watir_definition.checkbox_elements
    end

    it 'should locate a select list element' do
      watir_browser.should_receive(:select_list).with(id: 'test').and_return(watir_browser)
      element = watir_definition.select_list_locate(id: 'test')
      element.should be_instance_of Fluent::WebElements::SelectList
    end

    it 'should locate all select list elements' do
      watir_browser.should_receive(:select_lists).with(class: 'test').and_return([watir_browser])
      elements = watir_definition.select_list_elements(class: 'test')
      elements[0].should be_instance_of Fluent::WebElements::SelectList
    end

    it 'should locate a select list using a default locator' do
      watir_browser.should_receive(:select_list).with(index: 0).and_return(watir_browser)
      watir_definition.select_list_locate
    end

    it 'should locate all select list elements using a default locator' do
      watir_browser.should_receive(:select_lists).with({}).and_return([watir_browser])
      watir_definition.select_list_elements
    end
    
    it 'should locate a hidden element' do
      watir_browser.should_receive(:hidden).with(class: 'test').and_return(watir_browser)
      element = watir_definition.hidden_locate(class: 'test')
      element.should be_instance_of Fluent::WebElements::Hidden
    end

    it 'should locate all hidden field elements' do
      watir_browser.should_receive(:hiddens).with(class: 'test').and_return([watir_browser])
      elements = watir_definition.hidden_elements(class: 'test')
      elements[0].should be_instance_of Fluent::WebElements::Hidden
    end
    
    it 'should locate a hidden field using a default locator' do
      watir_browser.should_receive(:hidden).with(index: 0).and_return(watir_browser)
      watir_definition.hidden_locate
    end

    it 'should locate all hidden field elements using a default locator' do
      watir_browser.should_receive(:hiddens).with({}).and_return([watir_browser])
      watir_definition.hidden_elements
    end

    it 'should locate a text area element' do
      watir_browser.should_receive(:textarea).with(id: 'test').and_return(watir_browser)
      element = watir_definition.text_area_locate(id: 'test')
      element.should be_instance_of Fluent::WebElements::TextArea
    end

    it 'should locate all text area elements' do
      watir_browser.should_receive(:textareas).with(class: 'test').and_return([watir_browser])
      elements = watir_definition.text_area_elements(class: 'test')
      elements[0].should be_instance_of Fluent::WebElements::TextArea
    end

    it 'should locate a text area using a default locator' do
      watir_browser.should_receive(:textarea).with(index: 0).and_return(watir_browser)
      watir_definition.text_area_locate
    end

    it 'should locate all text area elements using a default locator' do
      watir_browser.should_receive(:textareas).with({}).and_return([watir_browser])
      watir_definition.text_area_elements
    end

    it 'should locate a text field element' do
      watir_browser.should_receive(:text_field).with(id: 'test').and_return(watir_browser)
      element = watir_definition.text_field_locate(id: 'test')
      element.should be_instance_of Fluent::WebElements::TextField
    end

    it 'should locate all text field elements' do
      watir_browser.should_receive(:text_fields).with(class: 'test').and_return([watir_browser])
      elements = watir_definition.text_field_elements(class: 'test')
      elements[0].should be_instance_of Fluent::WebElements::TextField
    end

    it 'should locate a text field element using a default locator' do
      watir_browser.should_receive(:text_field).with(index: 0).and_return(watir_browser)
      watir_definition.text_field_locate
    end

    it 'should locate all text fields with a default locator' do
      watir_browser.should_receive(:text_fields).with({}).and_return([watir_browser])
      watir_definition.text_field_elements
    end

    it 'should locate a table' do
      watir_browser.should_receive(:table).with(id: 'test').and_return(watir_browser)
      element = watir_definition.table_locate(id: 'test')
      element.should be_instance_of Fluent::WebElements::Table
    end

    it 'should locate all table elements' do
      watir_browser.should_receive(:tables).with(class: 'test').and_return([watir_browser])
      elements = watir_definition.table_elements(class: 'test')
      elements[0].should be_instance_of Fluent::WebElements::Table
    end

    it 'should locate a table using a default locator' do
      watir_browser.should_receive(:table).with(index: 0).and_return(watir_browser)
      watir_definition.table_locate
    end

    it 'should locate all table elements using a default locator' do
      watir_browser.should_receive(:tables).with({}).and_return([watir_browser])
      watir_definition.table_elements
    end

    it 'should locate a table cell' do
      watir_browser.should_receive(:td).with(id: 'test').and_return(watir_browser)
      element = watir_definition.cell_locate(id: 'test')
      element.should be_instance_of Fluent::WebElements::Cell
    end

    it 'should locate all table cells' do
      watir_browser.should_receive(:tds).with(class: 'test').and_return([watir_browser])
      elements = watir_definition.cell_elements(class: 'test')
      elements[0].should be_instance_of Fluent::WebElements::Cell
    end

    it 'should locate a table cell using a default locator' do
      watir_browser.should_receive(:td).with(index: 0).and_return(watir_browser)
      watir_definition.cell_locate
    end

    it 'should find all table cells using a default locator' do
      watir_browser.should_receive(:tds).with({}).and_return([watir_browser])
      watir_definition.cell_elements
    end

    it 'should locate a div' do
      watir_browser.should_receive(:div).with(id: 'test').and_return(watir_browser)
      element = watir_definition.div_locate(id: 'test')
      element.should be_instance_of Fluent::WebElements::Div
    end

    it 'should locate all div elements' do
      watir_browser.should_receive(:divs).with(class: 'test').and_return([watir_browser])
      elements = watir_definition.div_elements(class: 'test')
      elements[0].should be_instance_of Fluent::WebElements::Div
    end

    it 'should locate a div using a default locator' do
      watir_browser.should_receive(:div).with(index: 0).and_return(watir_browser)
      watir_definition.div_locate
    end

    it 'should locate all div elements using a default locator' do
      watir_browser.should_receive(:divs).with({}).and_return([watir_browser])
      watir_definition.div_elements
    end

    it 'should locate a span' do
      watir_browser.should_receive(:span).with(id: 'test').and_return(watir_browser)
      element = watir_definition.span_locate(id: 'test')
      element.should be_instance_of Fluent::WebElements::Span
    end

    it 'should locate all span elements' do
      watir_browser.should_receive(:spans).with(class: 'test').and_return([watir_browser])
      elements = watir_definition.span_elements(class: 'test')
      elements[0].should be_instance_of Fluent::WebElements::Span
    end
    
    it 'should locate a span using a default locator' do
      watir_browser.should_receive(:span).with(index: 0).and_return(watir_browser)
      watir_definition.span_locate
    end

    it 'should locate all span elements using a default locator' do
      watir_browser.should_receive(:spans).with({}).and_return([watir_browser])
      watir_definition.span_elements
    end

    it 'should locate an image' do
      watir_browser.should_receive(:image).with(id: 'test').and_return(watir_browser)
      element = watir_definition.image_locate(id: 'test')
      element.should be_instance_of Fluent::WebElements::Image
    end

    it 'should locate all images' do
      watir_browser.should_receive(:images).with(class: 'test').and_return([watir_browser])
      elements = watir_definition.image_elements(class: 'test')
      elements[0].should be_instance_of Fluent::WebElements::Image
    end
    
    it 'should locate an image using a default locator' do
      watir_browser.should_receive(:image).with(index: 0).and_return(watir_browser)
      watir_definition.image_locate
    end

    it 'should locate all images using a default locator' do
      watir_browser.should_receive(:images).with({}).and_return([watir_browser])
      watir_definition.image_elements
    end
    
    it 'should locate a list item' do
      watir_browser.should_receive(:li).with(id: 'test').and_return(watir_browser)
      element = watir_definition.list_item_locate(id: 'test')
      element.should be_instance_of Fluent::WebElements::ListItem
    end

    it 'should locate all list items' do
      watir_browser.should_receive(:lis).with(class: 'test').and_return([watir_browser])
      elements = watir_definition.list_item_elements(class: 'test')
      elements[0].should be_instance_of Fluent::WebElements::ListItem
    end

    it 'should locate a list item using a default locator' do
      watir_browser.should_receive(:li).with(index: 0).and_return(watir_browser)
      watir_definition.list_item_locate
    end

    it 'should find all list items using a default locator' do
      watir_browser.should_receive(:lis).with({}).and_return([watir_browser])
      watir_definition.list_item_elements
    end

    it 'should locate an ordered list' do
      watir_browser.should_receive(:ol).with(id: 'test').and_return(watir_browser)
      element = watir_definition.ordered_list_locate(id: 'test')
      element.should be_instance_of Fluent::WebElements::OrderedList
    end

    it 'should locate all ordered lists' do
      watir_browser.should_receive(:ols).with(class: 'test').and_return([watir_browser])
      elements = watir_definition.ordered_list_elements(class: 'test')
      elements[0].should be_instance_of Fluent::WebElements::OrderedList
    end

    it 'should locate an ordered list using a default locator' do
      watir_browser.should_receive(:ol).with(index: 0).and_return(watir_browser)
      watir_definition.ordered_list_locate
    end

    it 'should locate all ordered lists using a default locator' do
      watir_browser.should_receive(:ols).with({}).and_return([watir_browser])
      watir_definition.ordered_list_elements
    end

    it 'should locate an unordered list' do
      watir_browser.should_receive(:ul).with(id: 'test').and_return(watir_browser)
      element = watir_definition.unordered_list_locate(id: 'test')
      element.should be_instance_of Fluent::WebElements::UnorderedList
    end

    it 'should locate all unordered lists' do
      watir_browser.should_receive(:uls).with(class: 'test').and_return([watir_browser])
      elements = watir_definition.unordered_list_elements(class: 'test')
      elements[0].should be_instance_of Fluent::WebElements::UnorderedList
    end

    it 'should locate an unordered list using a default locator' do
      watir_browser.should_receive(:ul).with(index: 0).and_return(watir_browser)
      watir_definition.unordered_list_locate
    end

    it 'should locate all unordered lists using a default locator' do
      watir_browser.should_receive(:uls).with({}).and_return([watir_browser])
      watir_definition.unordered_list_elements
    end

    it 'should locate a form' do
      watir_browser.should_receive(:form).with(id: 'test').and_return(watir_browser)
      element = watir_definition.form_locate(id: 'test')
      element.should be_instance_of Fluent::WebElements::Form
    end

    it 'should locate all forms' do
      watir_browser.should_receive(:forms).with(class: 'test').and_return([watir_browser])
      elements = watir_definition.form_elements(class: 'test')
      elements[0].should be_instance_of Fluent::WebElements::Form
    end

    it 'should locate a form using a default locator' do
      watir_browser.should_receive(:form).with(index: 0).and_return(watir_browser)
      watir_definition.form_locate
    end

    it 'should locate all forms using a default locator' do
      watir_browser.should_receive(:forms).with({}).and_return([watir_browser])
      watir_definition.form_elements
    end

    it 'should locate heading elements' do
      [:h1, :h2, :h3, :h4, :h5, :h6].each do |method|
        watir_browser.should_receive(method).with(id: 'test').and_return(watir_browser)
        element = watir_definition.send "#{method}_locate", {id: 'test'}
        element.should be_instance_of Fluent::WebElements::Heading
      end
    end

    it 'should locate all heading elements' do
      [:h1, :h2, :h3, :h4, :h5, :h6].each do |method|
        watir_browser.should_receive("#{method}s").with(class: 'test').and_return([watir_browser])
        elements = watir_definition.send "#{method}_elements", {class: 'test'}
        elements[0].should be_instance_of Fluent::WebElements::Heading
      end
    end

    it 'should locate heading elements using a default locator' do
      [:h1, :h2, :h3, :h4, :h5, :h6].each do |method|
        watir_browser.should_receive(method).with(index: 0).and_return(watir_browser)
        watir_definition.send "#{method}_locate"
      end
    end

    it 'should locate all heading elements using a default locator' do
      [:h1, :h2, :h3, :h4, :h5, :h6].each do |method|
        watir_browser.should_receive("#{method}s").with({}).and_return([watir_browser])
        watir_definition.send "#{method}_elements"
      end
    end

    it 'should locate a paragraph element' do
      watir_browser.should_receive(:p).with(id: 'test').and_return(watir_browser)
      element = watir_definition.paragraph_locate(id: 'test')
      element.should be_instance_of Fluent::WebElements::Paragraph
    end

    it 'should locate all paragraph elements' do
      watir_browser.should_receive(:ps).with(class: 'test').and_return([watir_browser])
      elements = watir_definition.paragraph_elements(class: 'test')
      elements[0].should be_instance_of Fluent::WebElements::Paragraph
    end

    it 'should locate a paragraph element using a default locator' do
      watir_browser.should_receive(:p).with(index: 0).and_return(watir_browser)
      watir_definition.paragraph_locate
    end

    it 'should locate all paragraph elements using a default locator' do
      watir_browser.should_receive(:ps).with({}).and_return([watir_browser])
      watir_definition.paragraph_elements
    end

    it 'should locate a label' do
      watir_browser.should_receive(:label).with(id: 'text').and_return(watir_browser)
      element = watir_definition.label_locate(id: 'text')
      element.should be_instance_of Fluent::WebElements::Label
    end

    it 'should locate all label elements' do
      watir_browser.should_receive(:labels).with(class: 'test').and_return([watir_browser])
      elements = watir_definition.label_elements(class: 'test')
      elements[0].should be_instance_of Fluent::WebElements::Label
    end

    it 'should locate a label element using a default locator' do
      watir_browser.should_receive(:label).with(index: 0).and_return(watir_browser)
      watir_definition.label_locate
    end

    it 'should locate all label elements using a default locator' do
      watir_browser.should_receive(:labels).with({}).and_return([watir_browser])
      watir_definition.label_elements
    end
    
  end
  
end