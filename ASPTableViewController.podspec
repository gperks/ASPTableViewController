Pod::Spec.new do |s|

  s.name         = "ASPTableViewController"
  s.version      = "0.1.0"
  s.summary      = "A UITableViewController subclass that moves cells to their own controller classes, and makes the tree's data source data-driven."
  s.description  = <<-DESC
                   A UITableViewController subclass that:
                   
                   * moves cells to their own controller classes
                   * makes the tree's data source data-driven

                   This is especially useful when
                   * the collection structure is variable, or unknown at build time
                   * you have shared a cell style across several collection views.
                   DESC

  s.homepage     = "https://github.com/gperks/ASPTableViewController"
  s.license      = 'MIT'
  s.author       = { "A Single Pixel, LLC" => "gperks@asinglepixel.com" }
  s.source       = { :git => "https://github.com/gperks/ASPTableViewController.git", :tag => s.version.to_s }
  s.platform     = :ios, '7.0'
  s.ios.deployment_target = '7.0'

  s.source_files = 'Classes/*.{m,h}'
  s.public_header_files = 'Classes/*.h'

  s.requires_arc = true

end
