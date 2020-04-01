#/bin/sh

pod install
jazzy --min-acl internal --no-hide-documentation-coverage --theme fullwidth --output ./docs --documentation='./*.md'
cp image/ docs/image
