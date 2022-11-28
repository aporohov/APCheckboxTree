# APCheckboxTree
![Language](https://img.shields.io/badge/language-Swift%205-orange.svg)

Easy-to-use library to build checkbox tree out of plain item models. Based on `UIView` and fully customizable.

## Requirements <a name="requirements"></a>
* Swift 5
* iOS >= 13.0

## Installation

### [Swift Package Manager](https://swift.org/package-manager/)

1. File > Swift Packages > Add Package Dependency
2. Copy & paste `https://github.com/aporohov/APCheckboxTree.git` then follow the instruction

### [CocoaPods](http://cocoapods.org)

1. Install the latest release of CocoaPods: `gem install cocoapods`
2. Add this line to your Podfile: `pod 'APCheckboxTree'`
3. Install the pod: `pod install`

## Usage
### Configure tree view
```
let tree = APCheckboxTree()

tree.items = [
    APCheckboxItem(title: "Fruits",
                   children: [
                    APCheckboxItem(title: "Orange"),
                    APCheckboxItem(title: "Apple",
                                   isSelected: true)
                   ])
]
```
### Delegate *APCheckboxTreeDelegate*
```
extension MyViewController: APCheckboxTreeDelegate {
    func checkboxItemDidSelected(item: APCheckboxItem) {
        print(item)
    }
}
```
### Tree style
1. Disable items group open/close animation:
```
tree.style.isCollapseAnimated = false
```
2. Make tree items always visible:
```
tree.style.isCollapseAvailable = false
```
### Setup custom Icons
```
tree.style.images.checkboxOn = UIImage(named: "icCheckboxOn")
tree.style.images.checkboxOff = UIImage(named: "icCheckboxOff")
```
### Customize Item View style
```
tree.style.itemViewStyle.titleFont = .systemFont(ofSize: 16)
tree.style.itemViewStyle.minHeight = 54
```
