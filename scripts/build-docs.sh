#/bin/sh

pod install
jazzy --clean \
	--author 'Patrick and Felix'\
	--module-version 0.3 \
	--min-acl internal --no-hide-documentation-coverage --theme fullwidth --output ./docs --documentation='./*.md'
cp -r images ./docs/images



