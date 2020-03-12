#/bin/sh

xcodebuild -workspace x5gon-mobile.xcworkspace -scheme x5gon-mobile OBJROOT=$(PWD)/build SYMROOT=$(PWD)/build -sdk iphonesimulator

ios-sim launch --devicetypeid "iPhone-11-Pro-Max" build/Debug-iphonesimulator/x5gon-mobile.app
