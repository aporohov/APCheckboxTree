# APCheckboxTree
![Language](https://img.shields.io/badge/language-Swift%205-orange.svg)

Easy-to-use library to build checkbox tree out of plain item models. Fully customizable.

![TreeDemo](https://user-images.githubusercontent.com/2827846/204354043-81dd4d12-6c5c-4dae-97e4-9e75d398e409.gif) ![CustomViews](https://user-images.githubusercontent.com/2827846/204355396-13d122b5-8c32-4c0b-b0b5-31c630580b54.gif)

## Requirements <a name="requirements"></a>
* Swift 5
* iOS >= 13.0

## Installation

### [Swift Package Manager](https://swift.org/package-manager/)

1. File > Swift Packages > Add Package Dependency
2. Copy & paste this line then follow the instruction
```
https://github.com/aporohov/APCheckboxTree.git
```

### [CocoaPods](http://cocoapods.org)

Add this line to your Podfile and run `pod install`
```ruby
pod 'APCheckboxTree'
```

## Usage
### Configure tree view
```swift
// Create instance of tree view

let tree = APCheckboxTree()

// Setup items of checkbox tree

tree.items = [
    APCheckboxItem(title: "Fruits",
                   children: [
                    APCheckboxItem(title: "Orange"),
                    APCheckboxItem(title: "Apple",
                                   isSelected: true)
                   ])
]

// Add tree on the superview then ...
```
### *APCheckboxTreeDelegate*
```swift
extension MyViewController: APCheckboxTreeDelegate {
    func checkboxItemDidSelected(item: APCheckboxItem) {
        print(item)
    }
}
```
## Customize style
### Tree style
```swift
// Disable items group open/close animation

tree.style.isCollapseAnimated = false

// Make tree items always visible

tree.style.isCollapseAvailable = false
```
### Icons
```swift
tree.style.images.checkboxOn = UIImage(named: "icCheckboxOn")
tree.style.images.checkboxOff = UIImage(named: "icCheckboxOff")
```
### Fonts / Colors / Layout
```swift
tree.style.itemViewStyle.titleFont = .systemFont(ofSize: 16)
tree.style.itemViewStyle.minHeight = 54
tree.style.itemViewStyle.titleColor = .darkGray
```
