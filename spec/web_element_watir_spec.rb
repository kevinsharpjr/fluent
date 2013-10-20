require 'spec_helper'

describe 'Web Elements for Watir' do
  let(:watir_browser)    { mock_browser_for_watir }
  let(:watir_definition) { ::Fluent::WebElements::WebElement.new(watir_browser, :platform => :watir_webdriver) }

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

  it 'should be able to flash a web element' do
    watir_browser.should_receive(:flash).exactly(5).times.and_return(watir_definition)
    watir_browser.should_receive(:exists?).and_return(watir_definition)
    watir_definition.flash.should be_instance_of Fluent::WebElements::WebElement
  end

  it 'should be able to flash a web element a specified number of times' do
    watir_browser.should_receive(:flash).exactly(1).times.and_return(watir_definition)
    watir_browser.should_receive(:exists?).and_return(watir_definition)
    watir_definition.flash(1).should be_instance_of Fluent::WebElements::WebElement
  end

  it 'should retrieve the tag of a web element' do
    watir_browser.should_receive(:tag_name).and_return('div')
    watir_definition.tag_name.should == 'div'
  end

  it 'should retrieve the html of a web element' do
    watir_browser.should_receive(:html).and_return('<p>Testing</p>')
    watir_definition.html.should == '<p>Testing</p>'
  end
  
  it 'should retrieve the value of an attribute' do
    watir_browser.should_receive(:attribute_value).and_return(true)
    watir_definition.attribute('readonly').should be_true
  end

  it 'should be able to fire an event on a web element' do
    watir_browser.should_receive(:fire_event).and_return('onclick')
    watir_definition.fire_event('onclick')
  end

  it 'should retrieve the value of a web element' do
    watir_browser.should_receive(:value).and_return("value")
    watir_definition.value.should == 'value'
  end

  it 'should retrieve the id of a web element' do
    watir_browser.should_receive(:id).and_return('id')
    watir_definition.id.should == 'id'
  end

  it 'should send key presses to a web element' do
    watir_browser.should_receive(:send_keys).with([:control, 'a'])
    watir_definition.send_keys([:control, 'a'])
  end

  it 'should scroll elements into view' do
    watir_browser.should_receive(:wd).and_return(watir_browser)
    watir_browser.should_receive(:location_once_scrolled_into_view)
    watir_definition.scroll_into_view
  end

  it 'should be able to focus on a web element' do
    watir_browser.should_receive(:focus).and_return(watir_definition)
    watir_definition.focus
  end

  it 'should be able to hover over a web element' do
    watir_browser.should_receive(:hover).and_return(watir_definition)
    watir_definition.hover
  end
end