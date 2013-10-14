require 'spec_helper'

class PageDefinition
  include Fluent
end

describe Fluent do
  let(:watir_browser)    { mock_browser_for_watir }
  let(:watir_definition) { PageDefinition.new(watir_browser) }

  context 'a definition using watir-webdriver' do
    it 'should return a watir platform object' do
      watir_definition.platform.should be_kind_of Fluent::Platforms::WatirWebDriver::PlatformObject
    end
  end

  context 'a definition using an unrecognized driver' do
    it 'should raise an exception' do
      msg = 'Unable to create a platform object for unknown_browser.'
      expect { PageDefinition.new(:unknown_browser) }.to raise_error(Fluent::Errors::UnableToCreatePlatform, msg)
    end
  end
end
