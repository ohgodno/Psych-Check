# PivotSlider

![PivotSlider](https://github.com/Lab111/pivot-slider/blob/master/Assets/PivotSlider.gif)

PivotSlider shows the track of value from the pivot.

- [Installation](#installation)
- [Configuration](#configuration)
- [Usage](#usage)
- [License](#license)

## Installation

### CocoaPods

CocoaPods manages library dependencies for your Xcode projects. For usage, see [CocoaPods Guides - Using CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html#adding-pods-to-an-xcode-project).

```
target '<Your Project Name>' do
    pod 'PivotSlider', '~> 1.2'
end
```

### Carthage

Carthage is intended to be the simplest way to add frameworks to your Cocoa application. For usage, see [Carthage - Adding frameworks to an application](https://github.com/Carthage/Carthage#adding-frameworks-to-an-application).

```
github "lab111/pivot-slider" ~> 1.2
```

## Configuration

PivotSlider consists of three UI components, `track`, `valueTrack`, and `thumb`, which are all of type `UIView`. So you can configure them just the same way you configure `UIView`. For example,

```swift
self.pivotSlider.track.backgroundColor = UIColor.black
self.pivotSlider.valueTrack.backgroundColor = UIColor.red
self.pivotSlider.thumb.layer.cornerRadius = 10.0
```

PivotSlider uses four values to define itself:

- `var minimumValue: Float = -1.0`
- `var maximumValue: Float = 1.0`
- `var pivotValue: Float = 0.0`
- `var value: Float = 0.0`

Other than that, `isContinuous` indicates whether changes in the slider’s value generate continuous update events. If it's `false`, you will only be notified when the user releases the slider’s thumb.

## Usage

```swift
import PivotSlider

self.pivotSlider = PivotSlider(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
self.view.addSubview(self.pivotSlider)
```

PivotSlider uses the [Target-Action](https://developer.apple.com/library/content/documentation/General/Conceptual/Devpedia-CocoaApp/TargetAction.html#//apple_ref/doc/uid/TP40009071-CH3) design pattern to notify your app when the user moves the slider. To be notified when the slider’s value changes, register your action method with the `valueChanged` event. At runtime, the slider calls your method in response to the user sliding `thumb`. Here is an example:

```swift
self.pivotSlider.addTarget(self, action: #selector(self.doSomething(with:)), for: .valueChanged)

func doSomething(with pivotSlider: PivotSlider) {
    print(pivotSlider.value)
}
```

## License

PivotSlider is released under the MIT license. For details, see [LICENSE](https://github.com/lab111/pivot-slider/blob/master/LICENSE).
