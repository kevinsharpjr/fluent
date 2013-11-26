require 'spec_helper'
require 'mock_app'

describe Fluent::Evaluators do
  let(:watir_browser)    { mock_browser_for_watir }
  let(:watir_definition) { TestDefinition.new(watir_browser) }
  
  describe 'browser-level actions' do
    context 'a definition using watir-webdriver' do
      it 'should get the active url' do
        watir_browser.should_receive(:url).twice.and_return('http://localhost:9292')
        watir_definition.url.should == 'http://localhost:9292'
        watir_definition.current_url.should == 'http://localhost:9292'
      end

      it 'should be able to clear all of the cookies from the browser' do
        watir_browser.should_receive(:cookies).twice.and_return(watir_browser)
        watir_browser.should_receive(:clear).twice
        watir_definition.remove_cookies
        watir_definition.clear_cookies
      end

      it 'should be able to refresh the page contents' do
        watir_browser.should_receive(:refresh).twice.and_return(watir_browser)
        watir_definition.refresh_page
        watir_definition.refresh
      end

      it 'should run a script against the browser' do
        watir_browser.should_receive(:execute_script).twice.and_return('input')
        watir_definition.run_script('return document.activeElement').should == 'input'
        watir_definition.execute_script('return document.activeElement').should == 'input'
      end

      it 'should get a screenshot' do
        watir_browser.should_receive(:wd).twice.and_return(watir_browser)
        watir_browser.should_receive(:save_screenshot).twice
        watir_definition.screenshot('testing.png')
        watir_definition.save_screenshot('testing.png')
      end
    end
  end

  describe 'page-level actions' do
    context 'a definition using watir-webdriver' do
      it 'should return all the markup on a page' do
        watir_browser.should_receive(:html).twice.and_return('<h1>Page Title</h1>')
        watir_definition.markup.should == '<h1>Page Title</h1>'
        watir_definition.html.should == '<h1>Page Title</h1>'
      end

      it 'should return the title of a page' do
        watir_browser.should_receive(:title).twice.and_return('Page Title')
        watir_definition.page_title.should == 'Page Title'
        watir_definition.title.should == 'Page Title'
      end

      it 'should return all the text on a page' do
        watir_browser.should_receive(:text).twice.and_return('page text')
        watir_definition.page_text.should == 'page text'
        watir_definition.text.should == 'page text'
      end

      it 'should wait for jquery pending requests to finish' do
        watir_browser.should_receive(:execute_script).with('return jQuery.active').and_return(0)
        watir_definition.wait_for_pending_requests
      end

      it 'should return an exception if pending requests did not finish' do
        watir_browser.should_receive(:execute_script).at_least(1).times.with('return jQuery.active').and_return(1)
        expect { watir_definition.wait_for_pending_requests(0.1) }.to raise_error
      end

      it 'should wait for a condition to be true' do
        watir_browser.should_receive(:wait_until).with(5, 'some condition')
        watir_definition.wait_until(5, 'some condition')
      end

      it 'should wait for a condition to be true with any page level timeout' do
        Fluent.page_level_wait = 30
        watir_browser.should_receive(:wait_until).with(30, nil)
        watir_definition.wait_until
      end
      
      
    end
  end
end