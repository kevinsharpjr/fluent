Change Log and History
======================

Version 0.1.0 / 2013-10-18
--------------------------

Initial development release of Fluent. At this point, the basic moving parts have been put in place in order for the framework to be usable.

Fluent ...

* ... can be included in page or activity definitions.

* ... is able to create platform objects based on a driver library.

* ... allows element definitions to be created.

* ... uses generators to create actions based on element definitions.

At this point, the only test library supported is Watir-WebDriver. The web elements that Fluent can recognize are button, checkbox, link, paragraph, radio, select_list, and text_field. The assertions that Fluent allows are url_is and title_is.