require 'spec_helper'

class LinkGenerators
  include Fluent
  
  link :contact, id: 'contact'
end

describe Fluent::Generators do
  let(:watir_browser)    { mock_browser_for_watir }
  let(:watir_definition) { LinkGenerators.new(watir_browser) }

  describe 'link generators' do
    context 'when declared on a page definition' do
      it 'should generate methods for referencing the link' do
        watir_definition.should respond_to(:contact_object)
        watir_definition.should respond_to(:contact_element)
        watir_definition.should respond_to(:contact_link)
      end

      it 'should generate methods for interacting with the link' do
        watir_definition.should respond_to(:contact)
        watir_definition.should respond_to(:contact_exists?)
        watir_definition.should respond_to(:contact_visible?)
        watir_definition.should respond_to(:contact?)
        watir_definition.should respond_to(:contact_?)
        watir_definition.should respond_to(:contact_link_exists?)
        watir_definition.should respond_to(:contact_link_visible?)
        watir_definition.should respond_to(:contact_link?)
        watir_definition.should respond_to(:contact_link_?)
      end
    end

    context 'when used by the watir platform' do
      it 'should locate the link' do
        watir_browser.should_receive(:link).and_return(watir_browser)
        web_element = watir_definition.contact_object
        web_element.should_not be_nil
        web_element.should be_instance_of Fluent::WebElements::Link
      end

      it 'should click the link' do
        watir_browser.stub_chain(:link, :click)
        watir_definition.contact
      end

      it 'should determine if a link exists' do
        watir_browser.should_receive(:link).exactly(3).times.and_return(watir_browser)
        watir_browser.should_receive(:exists?).exactly(3).times.and_return(watir_browser)
        watir_definition.contact_link_exists?.should be_true
        watir_definition.contact_exists?.should be_true
        watir_definition.contact?.should be_true
      end

      it 'should determine if a link is visible' do
        watir_browser.should_receive(:link).exactly(3).times.and_return(watir_browser)
        watir_browser.should_receive(:present?).exactly(3).times.and_return(watir_browser)
        watir_definition.contact_link_visible?.should be_true
        watir_definition.contact_visible?.should be_true
        watir_definition.contact_?.should be_true
      end
    end
  end
end