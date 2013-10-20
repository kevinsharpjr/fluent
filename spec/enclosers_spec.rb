require 'spec_helper'

class EnclosersTest
  include Fluent
  
end

describe Fluent::Enclosers do
  let(:watir_browser) { mock_browser_for_watir }
  let(:watir_definition) { EnclosersTest.new(watir_browser) }

  context 'a definition using watir-webdriver' do
    it 'should handle alert message boxes' do
      watir_browser.should_receive(:alert).exactly(3).times.and_return(watir_browser)
      watir_browser.should_receive(:exists?).and_return(true)
      watir_browser.should_receive(:text)
      watir_browser.should_receive(:ok)
      watir_definition.will_alert do
      end
    end

    it 'should handle confirmation message boxes' do
      watir_browser.should_receive(:alert).exactly(3).times.and_return(watir_browser)
      watir_browser.should_receive(:exists?).and_return(true)
      watir_browser.should_receive(:text)
      watir_browser.should_receive(:ok)
      watir_definition.will_confirm(true) do
      end
    end
  end
end