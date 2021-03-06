require 'spec_helper'
require 'mock_app'

describe Fluent::Evaluators do
  let(:watir_browser)    { mock_browser_for_watir }
  let(:watir_definition) { TestDefinition.new(watir_browser) }

  let(:mechanize_browser) { mock_browser_for_mechanize }
  let(:mechanize_definition) { TestDefinition.new(mechanize_browser) }

  describe 'browser-level actions' do
    context 'a definition using mechanize' do
      it 'should visit a page' do
        mechanize_browser.should_receive(:get).with('http://localhost:9292')
        mechanize_definition.visit('http://localhost:9292')
      end

      it 'should return all the markup on a page' do
        page = Mechanize::Page.new(URI('http://localhost:9292/'), { 'content-type' => 'text/html' }, '<h1>Content</h1>', '200')
        mechanize_browser.should_receive(:current_page).and_return(page)
        mechanize_definition.markup.should == '<h1>Content</h1>'
      end

      it 'should be able to get a cookie value' do
        data = {:name => 'test', :value => 'cookie', :path => '/'}
        jar = Mechanize::CookieJar.new
        cookie = Mechanize::Cookie.new(data)
        jar.add(URI('http://localhost:9292/'), cookie)

        mechanize_browser.should_receive(:cookie_jar).and_return(jar)
        result = mechanize_definition.get_cookie_value('test')
        result.should == 'cookie'
      end

      it 'should return nothing if a cookie value is not found' do
        data = {:name => 'test', :value => 'cookie', :path => '/'}
        jar = Mechanize::CookieJar.new
        cookie = Mechanize::Cookie.new(data)
        jar.add(URI('http://localhost:9292/'), cookie)

        mechanize_browser.should_receive(:cookie_jar).and_return(jar)
        result = mechanize_definition.get_cookie_value('testing')
        result.nil?.should be_true
      end
    end

    context 'a definition using watir-webdriver' do
      it 'should visit a page' do
        watir_browser.should_receive(:goto).twice.with('http://localhost:9292')
        watir_definition.visit('http://localhost:9292')
        watir_definition.navigate_to('http://localhost:9292')
      end
      
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

      it 'should be able to get a cookie value' do
        cookie = [{:name => 'test', :value => 'cookie', :path => '/'}]
        watir_browser.should_receive(:cookies).and_return(cookie)
        result = watir_definition.get_cookie_value('test')
        result.should == 'cookie'
      end

      it 'should return nothing if a cookie value is not found' do
        cookie = [{:name => 'test', :value =>'cookie', :path => '/'}]
        watir_browser.should_receive(:cookies).and_return(nil)
        result = watir_definition.get_cookie_value('testing')
        result.nil?.should be_true
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

      it 'should return the web element that has focus' do
        watir_browser.should_receive(:execute_script).and_return(watir_browser)
        watir_browser.should_receive(:tag_name).twice.and_return(:input)
        watir_browser.should_receive(:type).and_return(:submit)
        watir_definition.focused.class.should == Fluent::WebElements::Button
      end
    end
  end
end