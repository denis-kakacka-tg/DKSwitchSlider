# DKSwitchSlider

[![CI Status](https://img.shields.io/travis/Denis Kakačka/DKSwitchSlider.svg?style=flat)](https://travis-ci.org/Denis Kakačka/DKSwitchSlider)
[![Version](https://img.shields.io/cocoapods/v/DKSwitchSlider.svg?style=flat)](https://cocoapods.org/pods/DKSwitchSlider)
[![License](https://img.shields.io/cocoapods/l/DKSwitchSlider.svg?style=flat)](https://cocoapods.org/pods/DKSwitchSlider)
[![Platform](https://img.shields.io/cocoapods/p/DKSwitchSlider.svg?style=flat)](https://cocoapods.org/pods/DKSwitchSlider)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

DKSwitchSlider is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'DKSwitchSlider'
```

## Usage

```swift
import DKSwitchSlider
```

```swift
lazy var switcher: DKSwitchSlider = {
    let switcher = DKSwitchSlider()
    switcher.translatesAutoresizingMaskIntoConstraints = false
    switcher.onImage = UIImage(named: "icn-on")
    switcher.offImage = UIImage(named: "icn-off")
    switcher.thumbImage = UIImage(named: "icn-power")
    switcher.cornerRadius = 24
    switcher.thumbCornerRadius = 24
    switcher.isOn = true
    switcher.showLabel = true
    switcher.textColor = .white
    switcher.text = "ON"
    switcher.thumbBackgroundColor = .white
    switcher.thumbImageTintColor = .black
    switcher.onImageViewTintColor = .black
    switcher.offImageViewTintColor = .white
    switcher.addTarget(self, action: #selector(animateBackground), for: .valueChanged)

    return switcher
}()

override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(switcher)
}

@objc
func animateBackground(sender: DKSwitchSlider) {
    UIView.animate(withDuration: 0.25) {
        self.switcher.text = sender.isOn ? "ON" : "OFF"
        self.switcher.textColor = sender.isOn ? .white : .black
        self.view.backgroundColor = sender.isOn ? UIColor(red: 1, green: 206/255, blue: 84/255, alpha: 1) : .black
    }
}
```

## Author

Denis Kakačka, deniskakacka@gmail.com

## License

DKSwitchSlider is available under the MIT license. See the LICENSE file for more info.
