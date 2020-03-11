# X5GON-mobile

[![Build Status](https://travis-ci.com/magetron/X5GON-mobile.svg?token=1egyyzxUBmAzQpnmo8g4&branch=master)](https://travis-ci.com/magetron/X5GON-mobile)

## Deployment Manual

### Prerequisites

* `Git`
* `Xcode 11.3.1(macOS 15 Catilina+)`
* `iPhone running iOS 13.2+ or an iOS Simulator`
* `Homebrew (CLI-only)`

### Installation

`$ git clone https://github.com/magetron/x5gon-mobile.git`

#### To use GUI:

Double click to open `x5gon-mobile.xcodeproj` and select build target on top left corner.

Click `Build then Run the current scheme` to run.

#### To use CLI:

`$ brew install ios-sim`

`$ cd x5gon-mobile`

`$ xcodebuild -workspace x5gon-mobile.xcworkspace -scheme x5gon-mobile build`

`$ ios-sim launch --devicetypeid "iPhone-11-Pro-Max" "build/Release-iphonesimulator/x5gon-mobile.app"`

**Note**: It is possible to run iOS application with temporary signature on iPhone using CLI. However, given the complexity of steps, we do not recommend this deployment method at this stage.


