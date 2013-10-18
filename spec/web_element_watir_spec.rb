require 'spec_helper'

describe 'Web Elements for Watir' do
  let(:watir_browser)    { mock_browser_for_watir }
  let(:watir_definition) { ::Fluent::WebElements::WebElement.new(watir_browser, :platform => :watir_webdriver) }

  it 'should return the text contained by a web element' do
    watir_browser.should_receive(:text).and_return('testing')
    watir_definition.text.should == 'testing'
  end

  it 'should determine if a web element exists' do
    watir_browser.should_receive(:exists?).and_return(true)
    watir_definition.exists?.should == true
  end

  it 'should determine if a web element does not exist' do
    watir_browser.should_receive(:exists?).and_return(false)
    watir_definition.exists?.should == false
  end

  it 'should determine if a web element is visible' do
    watir_browser.should_receive(:present?).twice.and_return(true)
    watir_definition.visible?.should == true
    watir_definition.should be_visible
  end

  it 'should determine if a web element is not visible' do
    watir_browser.should_receive(:present?).and_return(false)
    watir_definition.visible?.should == false
  end
end