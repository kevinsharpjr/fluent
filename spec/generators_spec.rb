require 'spec_helper'
require 'mock_app'

describe Fluent::Generators do
  let(:watir_browser)    { mock_browser_for_watir }
  let(:watir_definition) { TestDefinition.new(watir_browser) }
  
  context 'any page definition' do
    context 'providing a page title to be verified' do
      it 'should specify and verify the page title' do
        watir_browser.should_receive(:title).twice.and_return('Test App')
        watir_definition.check_title
      end

      it 'should raise an error if the page title is not verified' do
        msg = "Expected title: 'Test App'; Actual title: 'Testing'"
        watir_browser.should_receive(:title).twice.and_return('Testing')
        expect { watir_definition.check_title }.to raise_error(Fluent::Errors::TitleNotMatched, msg)
      end

      it 'should validate the title if provided a regular expression' do
        class QuickDefinition
          include Fluent
          title_is (/\w+/)
        end

        watir_browser.should_receive(:title).twice.and_return('Symbiote')
        QuickDefinition.new(watir_browser).check_title
      end
    end
    
    context 'providing a url' do
      it 'should navigate to the page when viewed' do
        watir_browser.should_receive(:goto)
        watir_definition.view
      end
    end
  end
end