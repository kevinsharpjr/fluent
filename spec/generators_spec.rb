require 'spec_helper'
require 'mock_app'

describe Fluent::Generators do
  let(:watir_browser)    { mock_browser_for_watir }
  let(:selenium_browser) { mock_browser_for_selenium }
  
  let(:watir_definition) { TestDefinition.new(watir_browser) }
  let(:selenium_definition) { TestDefinition.new(selenium_browser) }
  
  context 'any page definition' do
    context 'providing a page title to be verified' do
      it 'should specify and verify the page title' do
        watir_browser.should_receive(:title).twice.and_return('Test App')
        watir_definition.check_title

        selenium_browser.should_receive(:title).twice.and_return('Test App')
        selenium_definition.check_title
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

      it 'should allow frames to act as a context' do
        watir_browser.should_receive(:frame).with(id: 'frame').and_return(watir_browser)
        watir_browser.should_receive(:text_field).and_return(watir_browser)
        web_element = watir_definition.framedName_text_field
        web_element.should_not be_nil
        web_element.should be_instance_of Fluent::WebElements::TextField
      end

      context 'automatically looking for an element' do
        it 'should specify and verify an expected elements' do
          watir_definition.should_receive(:name_object).and_return(watir_browser)
          watir_browser.should_receive(:when_present).with(5).and_return(watir_browser)
          watir_definition.check_objects
        end

        it 'should raise an error if an expected elements are not verified' do
          class QuickDefinition
            include Fluent
            look_for :fakeLink
          end
          expect { QuickDefinition.new(watir_browser).check_objects }.to raise_error
        end
      end
    end

    context 'a definition using watir-webdriver' do
      context 'providing a url' do
        it 'should navigate to the page when viewed' do
          watir_browser.should_receive(:goto)
          watir_definition.view
        end
      end
    end

    context 'a definition using selenium-webdriver' do
      context 'providing a url' do
        it 'should navigate to the page when viewed' do
          selenium_browser.should_receive(:navigate).and_return(selenium_browser)
          selenium_browser.should_receive(:to)
          selenium_definition.view
        end
      end
    end
    
  end
end