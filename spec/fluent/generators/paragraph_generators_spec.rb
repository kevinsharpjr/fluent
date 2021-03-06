require 'spec_helper'

class ParagraphGenerators
  include Fluent

  paragraph :purpose, id: 'purpose'
  paragraphs :content, id: 'content'
end

describe Fluent::Generators do
  let(:watir_browser)    { mock_browser_for_watir }
  let(:watir_definition) { ParagraphGenerators.new(watir_browser) }

  let(:paragraph_object) { double('paragraph_object') }
  let(:paragraph_definition) { Fluent::WebElements::Paragraph.new(paragraph_object, :platform => :watir_webdriver) }

  describe 'paragraph generators' do
    context 'when declared on a page definition' do
      it 'should generate methods for referencing the paragraph' do
        watir_definition.should respond_to(:purpose_object)
        watir_definition.should respond_to(:purpose_element)
        watir_definition.should respond_to(:purpose_paragraph)
      end

      it 'should generate methods for interacting with the paragraph' do
        watir_definition.should respond_to(:purpose)
        watir_definition.should respond_to(:purpose_exists?)
        watir_definition.should respond_to(:purpose_visible?)
        watir_definition.should respond_to(:purpose?)
        watir_definition.should respond_to(:purpose_?)
        watir_definition.should respond_to(:purpose_paragraph_exists?)
        watir_definition.should respond_to(:purpose_paragraph_visible?)
        watir_definition.should respond_to(:purpose_paragraph?)
        watir_definition.should respond_to(:purpose_paragraph_?)
      end

      it 'should generate methods for multiple paragraphs' do
        watir_definition.should respond_to(:content_elements)
      end
    end

    context 'when used by the watir platform' do
      it 'should locate the paragraph' do
        watir_browser.should_receive(:p).and_return(watir_browser)
        web_element = watir_definition.purpose_object
        web_element.should_not be_nil
        web_element.should be_instance_of Fluent::WebElements::Paragraph
      end

      it 'should locate multiple paragraphs' do
        watir_browser.should_receive(:ps).and_return(watir_browser)
        watir_browser.should_receive(:[]).and_return(paragraph_definition)
        watir_browser.should_receive(:map).and_return(watir_browser)
        web_elements = watir_definition.content_elements
        web_elements.should_not be_nil
        web_elements[0].should be_instance_of Fluent::WebElements::Paragraph
      end

      it 'should return the text of a paragraph' do
        watir_browser.should_receive(:p).and_return(watir_browser)
        watir_browser.should_receive(:text).and_return('testing')
        watir_definition.purpose.should == 'testing'
      end

      it 'should determine if a paragraph exists' do
        watir_browser.should_receive(:p).exactly(3).times.and_return(watir_browser)
        watir_browser.should_receive(:exists?).exactly(3).times.and_return(watir_browser)
        watir_definition.purpose_paragraph_exists?.should be_true
        watir_definition.purpose_exists?.should be_true
        watir_definition.purpose?.should be_true
      end

      it 'should determine if a paragraph is visible' do
        watir_browser.should_receive(:p).exactly(3).times.and_return(watir_browser)
        watir_browser.should_receive(:present?).exactly(3).times.and_return(watir_browser)
        watir_definition.purpose_paragraph_visible?.should be_true
        watir_definition.purpose_visible?.should be_true
        watir_definition.purpose_?.should be_true
      end
    end
  end
end