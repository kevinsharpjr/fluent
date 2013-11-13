Change Log and History
======================

Version 0.4.0 / 2013-11-13
--------------------------

This release is relatively minor in terms of number of changes but it does change some aspects of how drivers are specified. Prior to this release, Fluent counted on there being a @browser instance in order to create a platform object. That is now a @driver instance. Further, Fluent used to default solely to testing with browsers and thus Watir WebDriver was used as a default. The ability to support drivers by default is now removed.

The reason for that is Fluent is now supporting Mechanize. While that is technically "just another browser" it is different enough in interface implementation, that it was no longer feasible to assume GUI-based browsers as a default option. What this means is that Fluent can now create a platform object for Mechanize.

Version 0.3.0 / 2013-10-29
--------------------------

This release has some added generators: label, hidden, headings (h1 through h6), form, and image. That means you can now interact with those elements via the Fluent interface.

Elements now map their type (i.e., Button) and their tag (i.e., "submit"). This allows for certain actions like getting the parent of elements, which is now an action that is available on each element.

Tables rows have been added as an element and that was done so that tables could be enumerated. This means table rows and columns can be more easily discovered. Finally, lists (unordered and ordered) have also been enumerated so that it is possible to get the text contents of those lists.

Version 0.2.0 / 2013-10-21
--------------------------

This is a significant update of Fluent. Some of the highlights:

* The Selenium platform object is now supported. This is *only* to show that multiple platforms can be supported. Selenium is not fully supported to the same level that Watir-WebDriver is.

* New web elements are handled as part of the generators mechanism. The new elements are: div, span, ordered and unordered lists along with their list items, text areas, and tables along with their cells.

* A new mechanism called "enclosers" has been introduced. One aspect of this is that frames and iframes are now supported. More specifically, elements within frames can be specified in element definitions. Another aspect of this is that it is possible to handle JavaScript messages in terms of alerts, confirmations, and prompts.

* A new mechanism called "evaluators" has been introduced. The idea of this is that you can evaluate aspects at the page level or the browser level. The evaluators provided are: url, remove cookies, refresh, run script, screenshot, markup, title, text, wait for app, and wait for pending requests.

* Element and page level wait states have been added. A 'wait until' method is provided for both page-level and element-level concerns. Element level wait states are also provided by 'when present' (also: 'when actionable'), 'when not present' (also: 'when not actionable'), 'when visible', and 'when not visible'.

* A factory mechanism has been provided so that context methods can be used to provide a more concise interface for using page and activity definitions. Currently the factory methods provided are 'on view' and 'on'.

* Various generic web element methods have been exposed: tag name, html, flash, style, attribute, fire event, class name, value, id, send keys, scroll into view, focus, hover, double click, and clear. These are provided so that you can use Fluent similar to how you would use Watir-WebDriver directly.

* A start has been made at providing specific web element methods. For example, for text fields, checkboxes, radios, and select lists, you can call methods against those objects just as you would if using Watir-WebDriver.

Version 0.1.0 / 2013-10-18
--------------------------

Initial development release of Fluent. At this point, the basic moving parts have been put in place in order for the framework to be usable.

Fluent ...

* ... can be included in page or activity definitions.

* ... is able to create platform objects based on a driver library.

* ... allows element definitions to be created.

* ... uses generators to create actions based on element definitions.

At this point, the only test library supported is Watir-WebDriver. The web elements that Fluent can recognize are button, checkbox, link, paragraph, radio, select_list, and text_field. The assertions that Fluent allows are url_is and title_is.