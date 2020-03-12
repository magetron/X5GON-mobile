#/bin/sh

pod install
jazzy --min-acl internal  --no-hide-documentation-coverage --theme apple --output ./docs --documentation='./*.md'
