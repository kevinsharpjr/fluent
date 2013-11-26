require 'spec_helper'

describe Fluent::DataSetter do
  let(:watir_browser)    { mock_browser_for_watir }
  let(:watir_definition) { TestDefinition.new(watir_browser) }

  it 'should set data in a text field' do
    watir_definition.should_receive(:name_set).with('jnyman')
    watir_definition.should_receive(:object_enabled_for).and_return(true)
    watir_definition.using('name' => 'jnyman')
  end

  it 'should set data in a text area' do
    watir_definition.should_receive(:summary_set).with('information')
    watir_definition.should_receive(:object_enabled_for).and_return(true)
    watir_definition.using('summary' => 'information')
  end

  it 'should not set data in a non-existent text field' do
    watir_browser.should_not_receive(:text_field)
    watir_definition.using('fake_field' => 'fake data')
  end

  it 'should not set data in a disabled text field' do
    watir_definition.should_not_receive(:name_set)
    watir_definition.should_receive(:name_element).and_return(watir_browser)
    watir_browser.should_receive(:enabled?).and_return(false)
    watir_definition.using('name' => 'test data')
  end

  it 'should check a checkbox field' do
    watir_definition.should_receive(:applyTax_check)
    watir_definition.should_receive(:object_enabled_for).and_return(true)
    watir_definition.using('applyTax' => true)
  end

  it 'should uncheck a checkbox field' do
    watir_definition.should_receive(:applyTax_uncheck)
    watir_definition.should_receive(:object_enabled_for).and_return(true)
    watir_definition.using('applyTax' => false)
  end

  it 'should not check data in a disabled checkbox field' do
    watir_definition.should_not_receive(:applyTax_check)
    watir_definition.should_receive(:applyTax_element).and_return(watir_browser)
    watir_browser.should_receive(:enabled?).and_return(false)
    watir_definition.using('applyTax' => true)
  end

  it 'should set a radio field' do
    watir_definition.should_receive(:set_includeTax)
    watir_definition.should_receive(:object_enabled_for).and_return(true)
    watir_definition.using('includeTax' => true)
  end

  it 'should not set data in a disabled radio field' do
    watir_definition.should_not_receive(:set_includeTax)
    watir_definition.should_receive(:includeTax_element).and_return(watir_browser)
    watir_browser.should_receive(:enabled?).and_return(false)
    watir_definition.using('includeTax' => true)
  end

  it 'should set data in a select list field' do
    watir_definition.should_receive(:concepts_select)
    watir_definition.should_receive(:object_enabled_for).and_return(true)
    watir_definition.using('concepts' => 'physics')
  end
  
end