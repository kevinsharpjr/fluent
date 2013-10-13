Fluent
======

Fluent is a Ruby gem that provides a way to describe your application in terms of activity and page definitions. Those definitions can be referenced by test libraries using the DSL that Fluent provides. The initial focus will be to hook into browser driver libraries in order to test browser-based applications. The browser driver libraries that are currently supported by Fluent are [watir-webdriver](http://watirwebdriver.com/) and [selenium-webdriver](http://docs.seleniumhq.org/projects/webdriver/). (For the most part, Watir-WebDriver is just a friendly API around Selenium-WebDriver.)

The concept of "activity definitions" and "page definitions" are conceptually similar if not identical to the concept of [page objects](http://martinfowler.com/bliki/PageObject.html).

The goal of Fluent is to provide a DSL so that a [fluent interface](http://martinfowler.com/bliki/FluentInterface.html) can be used for constructing test execution logic. This fluent interface provides for compressibility of your test logic, allowing for more factoring, more reuse, and less repetition.

You can use Fluent directly as an automated testing solution or you can use it with other tools such as [RSpec](http://rspec.info/), [Cucumber](http://cukes.info/), or my own [Lucid](https://github.com/jnyman/lucid) tool.

Installation
------------

Add this line to your application's Gemfile:

    gem 'fluent'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install fluent

Using Fluent
------------

Details on how to use Fluent will be coming soon.

Contributing
------------

1. Fork the project.
2. Create a branch for your change.
3. Make your feature additions or bug fixes in your branch.
4. Create unit tests (in spec) for your changes.
5. Create acceptance tests (in specs) for your changes.
6. Commit your changes.
7. Push to the branch.
8. Create a new [pull request](https://help.github.com/articles/using-pull-requests).

Do note that pull requests are very welcome and are considered better than bug reports. Please create a topic branch for every separate change that you make. When you make commits, do not change the rakefile, version or history information.
