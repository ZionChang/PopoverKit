PopoverKit
==========

> A lightweight, swift library for displaying popover.


[![Swift Version][swift-image]][swift-url]
[![Pod Version](http://img.shields.io/cocoapods/v/PopoverKit.svg)](http://cocoadocs.org/docsets/PopoverKit/)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](http://img.shields.io/badge/license-MIT-blue.svg)](http://opensource.org/licenses/MIT)
[![Platform](https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat)](http://cocoapods.org/pods/LFAlertController)

## Description

![](https://github.com/eilianlove/PopoverKit/blob/master/Demo/demo.gif)





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


## Installation

### Carthage
Create a `Cartfile` that lists the framework. Follow the [instructions](https://github.com/Carthage/Carthage#if-youre-building-for-ios) to add `$(SRCROOT)/Carthage/Build/iOS/PopoverKit.framework` to an iOS project.

```ruby
github "eilianlove/PopoverKit"
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
pod 'PopoverKit', '~> 0.0.1'
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



[swift-image]:https://img.shields.io/badge/swift-3.0-orange.svg
[swift-url]: https://swift.org/

### License

PopoverKit is licensed under the MIT License, please see the LICENSE file.
