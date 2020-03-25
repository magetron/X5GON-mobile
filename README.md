# X5GON-mobile

[![Build Status](https://travis-ci.com/magetron/X5GON-mobile.svg?token=1egyyzxUBmAzQpnmo8g4&branch=master)](https://travis-ci.com/magetron/X5GON-mobile)

![onefetch](./images/onefetch.png)

## Deployment Manual

### Prerequisites

* Git
* Xcode 11.3.1(macOS 15 Catalina+)
* iPhone running iOS 13.2+ or an iOS Simulator
* Cocoapods
* Homebrew (CLI-only)
* ios-sim (CLI-only)

### Building, Testing and Installation

```zsh
$ git clone https://github.com/magetron/x5gon-mobile.git
$ pod install 
$ brew install ios-sim (cli-only)
```

#### To Use Xcode GUI:

**Build and Run**

Double click to open `x5gon-mobile.xcworkspace` and select build target on top left corner.

Click the `Run` Button to build and run.

![RUN-GUI](./images/gui-run.png)

**Build / Test**

Click the `Build` / `Test` Button for build / test only, respectively.

![BUILD-GUI](./images/gui-build.png)

#### To use CLI

**Build First (Test included)**

```zsh
$ source ./scripts/build.sh
```

**Then Run**

```zsh
$ source ./scripts/run.sh
```

**Note**: It is possible to run iOS application with temporary signature on an actual iPhone using CLI. However, given the complexity of steps, we do not recommend this deployment method at this stage.

**Test Only**

```zsh
$ xcodebuild test -workspace x5gon-mobile.xcworkspace -scheme x5gon-mobile -destination 'platform=iOS Simulator,name=iPhone 11 Pro Max,OS=13.3'
```

Change the specification, models and OS Version above to test on different platforms.

### Documentation

**Build Docs**

```zsh
$ source ./scripts/build-docs.sh
```

Static Documentation will be generated at `./docs`. Simply double click `./docs/index.html` to open with a browser or use `open ./docs/index.html` on `macOS`.

## Showcase

![header-iPhone](./images/header-iphone.png)
