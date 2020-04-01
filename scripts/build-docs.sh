#/bin/sh

pod install
jazzy --clean --min-acl internal --no-hide-documentation-coverage --theme fullwidth --output ./docs --documentation='./*.md'
cp -r images docs/images
