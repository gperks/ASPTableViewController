# ASPTableViewController

A UITableViewController subclass that:

* moves cell logic to their own controller classes
* makes the tree's data source data-driven
* can load the table structure from JSON

This is especially useful when:

* the data structure is variable, or unknown at build time
* you have a shared cell style across several table views.
