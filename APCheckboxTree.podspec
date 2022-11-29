Pod::Spec.new do |s|
  s.name             = 'APCheckboxTree'
  s.version          = '1.0.0'
  s.summary          = 'Checkboxes tree structure based on UIView'

  s.description      = <<-DESC
Checkbox tree with nested items. Could be used as a tree or plain list. Fully customizable view.
                       DESC

  s.homepage         = 'https://github.com/aporohov/APCheckboxTree.git'
  s.authors          = { 'Artem Porohov' => 'aporohov@gmail.com' }
  s.license          = { :type => 'MIT', :file => 'LICENSE.md' }
  s.source           = { :git => 'https://github.com/aporohov/APCheckboxTree.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'
  s.swift_version = '5'
  
  s.source_files = 'Sources/**/*.{swift}'
  
  s.resource_bundles = {
    'APCheckboxTree' => ['Sources/APCheckboxTree/Resources/**']
  }
  
end
