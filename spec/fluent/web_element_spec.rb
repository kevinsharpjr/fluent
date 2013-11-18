require 'spec_helper'

describe 'Web Elements' do
  let(:watir_browser)    { mock_browser_for_watir }
  let(:watir_definition) { ::Fluent::WebElements::WebElement.new(watir_browser, :platform => :watir_webdriver) }

  it 'should return the text contained by a web element' do
    watir_browser.should_receive(:text).and_return('testing')
    watir_definition.text.should == 'testing'
  end
  
  it 'should perform a click event on a web element' do
    watir_browser.should_receive(:click)
    watir_definition.click
  end

  it 'should determine if a web element is enabled' do
    watir_browser.should_receive(:enabled?).twice.and_return(true)
    watir_definition.enabled?.should == true
    watir_definition.should be_enabled
  end

  it 'should determine if a web element is disabled' do
    watir_browser.should_receive(:enabled?).twice.and_return(false)
    watir_definition.disabled?.should == true
    watir_definition.should be_disabled
  end

  it 'should retrieve the style of a web element' do
    watir_browser.should_receive(:style).with('display').and_return('none')
    watir_definition.style('display').should == 'none'
  end

  it 'should retrieve the class name of a web element' do
    watir_browser.should_receive(:attribute_value).and_return('class')
    watir_definition.class_name
  end
end