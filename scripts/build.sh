#/bin/sh

/bin/rm -r $(PWD)/build

if [[ $1 == "-old-test" ]]; then
    xcodebuild test -workspace x5gon-mobile.xcworkspace -scheme x5gon-mobile -destination 'platform=iOS Simulator,name=iPhone 11 Pro Max,OS=13.3' 
fi

if [[ $1 == "-test" ]]; then
    xcodebuild test -workspace x5gon-mobile.xcworkspace -scheme x5gon-mobile -destination 'platform=iOS Simulator,name=iPhone 11 Pro Max,OS=13.4' 
fi


xcodebuild -workspace x5gon-mobile.xcworkspace -scheme x5gon-mobile OBJROOT=$(PWD)/build SYMROOT=$(PWD)/build -sdk iphonesimulator


