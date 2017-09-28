PopoverKit
==========

> A lightweight, swift library for displaying popover.


[![Swift Version][swift-image]][swift-url]
[![Pod Version](http://img.shields.io/cocoapods/v/PopoverKit.svg)](http://cocoadocs.org/docsets/PopoverKit/)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](http://img.shields.io/badge/license-MIT-blue.svg)](http://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat)](http://cocoapods.org/pods/LFAlertController)

## Description

![](https://github.com/ZionChang/PopoverKit/blob/master/Demo/demo.gif)





## Usage

### if you use PopoverKit

```swift
// Present the view controller using the popover style.        
myPopooverViewController.pop.isNeedPopover = true

// Get the popover presentation controller and configure it.
myPopooverViewController.pop.popoverPresentationController?.sourceView = sender
myPopooverViewController.pop.popoverPresentationController?.sourceRect = sender.bounds
myPopooverViewController.pop.popoverPresentationController?.arrowDirection = .up

```

### if you use UIPopoverPresentationController(System)

```swift 
// Present the view controller using the popover style.
myPopooverViewController.modalPresentationStyle = .popover
present(myPopooverViewController, animated: true, completion: nil)
 
// Get the popover presentation controller and configure it.
let presentationController = myPopooverViewController.popoverPresentationController
presentationController?.sourceView = myView
presentationController?.sourceRect = sourceRect
```

As you see, so esay, just like system

## PopoverTableViewController

* Init your model(**PureTitleModel** or **NormalModel**)

```swift
let sortByDate = PureTitleModel(title: "按时间排序")
let sortBySize = PureTitleModel(title: "按大小排序")
let edit = NormalModel(iconName: "ic_note_edit", description: "编辑")
let delete = NormalModel(iconName: "ic_note_delete", description: "删除")

```

* Init **PopoverTableViewController**

```swift
let vc = PopoverTableViewController(items: [sortByDate, sortBySize])
vc.pop.isNeedPopover = true
vc.pop.popoverPresentationController?.barButtonItem = sender
vc.pop.popoverPresentationController?.arrowPointY = self.navigationController?.navigationBar.frame.maxY
vc.delegate = self
present(vc, animated: true, completion: nil)
```

* Or custom your own model(**PopoverCellConfiguration**)

```swift
/// Custom
struct CustomModel: PopoverCellConfiguration {
    
	public var width: CGFloat {
	    let cell = AjustFontPopoverCell()
	    config(cell: cell)
	    let width = cell.systemLayoutSizeFitting(UILayoutFittingCompressedSize).width
	    return width
	}
	    
	public var resuable: PopoverCellResuable.Type {
	    return AjustFontPopoverCell.self
	}
	    
	public func config(cell: UITableViewCell) {
	    guard let cell  = cell as? AjustFontPopoverCell else {
	        return
	    }
	    // config delegate...
	}
    
    
}
```


## Customization

### PopoverConfiguration

#### Property

```swift 
public enum PopoverConfiguration.Animation {
    case scale
    case alpha
}
```

* `arrowSize = CGSize(width: 12, height: 7)`
* `cornerRadius = CGFloat(4) `
* `animationDuration = TimeInterval(0.25)`
* `backgroundColor = UIColor.white`
* `dimmingViewColor = UIColor.black.withAlphaComponent(0.35)   `
* `showDimmingView = true`
* `animation: Animation = .scale`


## Requirements

- iOS 8.0+
- Xcode 8.0+
- Swift4


## Installation

### Carthage
Create a `Cartfile` that lists the framework. Follow the [instructions](https://github.com/Carthage/Carthage#if-youre-building-for-ios) to add `$(SRCROOT)/Carthage/Build/iOS/PopoverKit.framework` to an iOS project.

```ruby
github "ZionChang/PopoverKit"
```

Run `carthage update` to build the framework and drag the built `PopoverKit.framework` into your Xcode project.

To get the full benefits import `PopoverKit`

``` swift
import PopoverKit
```

### CocoaPods

You can use [CocoaPods](http://cocoapods.org/) to install `PopoverKit` by adding it to your `Podfile`:

```ruby
platform :ios, '8.0'
use_frameworks!
pod 'PopoverKit', '~> 0.2.0'
```

Then, run the following command:

```ruby
$ pod install
```

### Manually
1. Download and drop ```PopoverKit``` in your project.  
2. Congratulations!  

## TODO

- [] Ability to customize animation



[swift-image]:https://img.shields.io/badge/swift-4.0-orange.svg
[swift-url]: https://swift.org/

### License

PopoverKit is licensed under the MIT License, please see the LICENSE file.
