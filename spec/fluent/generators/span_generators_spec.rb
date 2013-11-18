require 'spec_helper'

class SpanGenerators
  include Fluent

  span :inline, id: 'inline'
end

describe Fluent::Generators do
  let(:watir_browser)    { mock_browser_for_watir }
  let(:watir_definition) { SpanGenerators.new(watir_browser) }

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
    end

    context 'when used by the watir platform' do
      it 'should locate the span' do
        watir_browser.should_receive(:span).and_return(watir_browser)
        web_element = watir_definition.inline_span
        web_element.should_not be_nil
        web_element.should be_instance_of Fluent::WebElements::Span
      end

      it 'should return the text of a span' do
        watir_browser.should_receive(:span).and_return(watir_browser)
        watir_browser.should_receive(:text).and_return('testing')
        watir_definition.inline.should == 'testing'
      end
    end
  end
end