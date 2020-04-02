#/bin/sh

pod install
jazzy --clean \
	--author 'Patrick and Felix'\
	--module-version 0.3 \
	--min-acl internal --no-hide-documentation-coverage --theme fullwidth --output ../x5gon-mobile-public-web/ --documentation='./*.md'
cp -r images ../x5gon-mobile-public-web/images

cd ../x5gon-mobile-public-web/
git add .
git commit -m "update docs"
git push -f -u origin gh-pages

cd ../x5gon-mobile


