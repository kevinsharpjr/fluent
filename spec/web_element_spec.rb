require 'spec_helper'

describe 'Web Elements' do
  let(:watir_browser)    { mock_browser_for_watir }
  let(:watir_definition) { ::Fluent::WebElements::WebElement.new(watir_browser, :platform => :watir_webdriver) }

  it 'should perform a click event on a web element' do
    watir_browser.should_receive(:click)
    watir_definition.click
  end
end