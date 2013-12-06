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

    it 'should handle prompt message boxes' do
      watir_browser.should_receive(:wd).twice.and_return(watir_browser)
      watir_browser.should_receive(:execute_script).twice
      watir_definition.will_prompt('Testing') do
      end
    end

    it 'should be able to attach to a window by using the title' do
      watir_browser.should_receive(:window).with(:title => /Display\ Results/).and_return(watir_browser)
      watir_browser.should_receive(:use)
      watir_definition.within_window(title: 'Display Results')
    end

    it 'should be able to attach to a window by using the url' do
      watir_browser.should_receive(:window).with(:url => /results\.html/).and_return(watir_browser)
      watir_browser.should_receive(:use)
      watir_definition.within_window(url: 'results.html')
    end

    it 'should be able to convert a modal popup to a window' do
      watir_browser.should_receive(:execute_script)
      watir_definition.within_modal {}
    end
  end
end