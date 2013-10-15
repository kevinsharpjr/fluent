require_relative '../spec_helper'

class ParagraphGenerators
  include Fluent

  paragraph :purpose, id: 'purpose'
end

describe Fluent::Generators do
  let(:watir_browser)    { mock_browser_for_watir }
  let(:watir_definition) { ParagraphGenerators.new(watir_browser) }

  describe 'paragraph generators' do
    context 'when declared on a page definition' do
      it 'should generate methods for referencing the paragraph' do
        watir_definition.should respond_to(:purpose_object)
        watir_definition.should respond_to(:purpose_element)
      end
    end

    context 'when used by the watir platform' do
      it 'should locate the paragraph' do
        watir_browser.should_receive(:p).and_return(watir_browser)
        web_element = watir_definition.purpose_object
        web_element.should_not be_nil
        web_element.should be_instance_of Fluent::WebElements::Paragraph
      end
    end
  end
end