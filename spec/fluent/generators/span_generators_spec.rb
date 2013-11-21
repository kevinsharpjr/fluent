require 'spec_helper'

class SpanGenerators
  include Fluent

  span :inline, id: 'inline'
  spans :instruct, class: 'instruct'
end

describe Fluent::Generators do
  let(:watir_browser)    { mock_browser_for_watir }
  let(:watir_definition) { SpanGenerators.new(watir_browser) }

  let(:span_object) { double('span_object') }
  let(:span_definition) { Fluent::WebElements::Span.new(span_object, :platform => :watir_webdriver) }
  
  describe 'span generators' do
    context 'when declared on a page definition' do
      it 'should generate methods for referencing the span' do
        watir_definition.should respond_to(:inline_object)
        watir_definition.should respond_to(:inline_element)
        watir_definition.should respond_to(:inline_span)
      end

      it 'should generate methods for interacting with the span' do
        watir_definition.should respond_to(:inline)
        watir_definition.should respond_to(:inline_exists?)
        watir_definition.should respond_to(:inline_visible?)
        watir_definition.should respond_to(:inline?)
        watir_definition.should respond_to(:inline_?)
        watir_definition.should respond_to(:inline_span_exists?)
        watir_definition.should respond_to(:inline_span_visible?)
        watir_definition.should respond_to(:inline_span?)
        watir_definition.should respond_to(:inline_span_?)
      end

      it 'should generate methods for multiple spans' do
        watir_definition.should respond_to(:instruct_elements)
      end
    end

    context 'when used by the watir platform' do
      it 'should locate the span' do
        watir_browser.should_receive(:span).and_return(watir_browser)
        web_element = watir_definition.inline_span
        web_element.should_not be_nil
        web_element.should be_instance_of Fluent::WebElements::Span
      end

      it 'should locate multiple spans' do
        watir_browser.should_receive(:spans).and_return(watir_browser)
        watir_browser.should_receive(:[]).and_return(span_definition)
        watir_browser.should_receive(:map).and_return(watir_browser)
        web_elements = watir_definition.instruct_elements
        web_elements.should_not be_nil
        web_elements[0].should be_instance_of Fluent::WebElements::Span
      end

      it 'should return the text of a span' do
        watir_browser.should_receive(:span).and_return(watir_browser)
        watir_browser.should_receive(:text).and_return('testing')
        watir_definition.inline.should == 'testing'
      end
    end
  end
end