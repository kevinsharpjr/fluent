require_relative '../spec_helper'

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
      end
    end

    context 'when used by the watir platform' do
      it 'should locate the link' do
        watir_browser.should_receive(:link).and_return(watir_browser)
        web_element = watir_definition.contact_object
        web_element.should_not be_nil
        web_element.should be_instance_of Fluent::WebElements::Link
      end
    end
  end
end