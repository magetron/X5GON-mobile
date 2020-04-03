#/bin/sh

pod install

jazzy --clean --author 'Patrick and Felix' --module-version 0.3 --build-tool-arguments -workspace,x5gon-mobile.xcworkspace,-scheme,x5gon-mobile,-sdk,iphonesimulator --min-acl internal --no-hide-documentation-coverage --theme fullwidth --output ./docs --documentation='./*.md'

cp -r images ./docs/images
cp -r user-manual/ ./docs/user-manual
