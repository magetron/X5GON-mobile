#/bin/sh

source ./scripts/build-docs.sh
cp -r docs/ ../x5gon-mobile-public-web/

cd ../x5gon-mobile-public-web/
git add .
git commit -m "update docs"
git push -f -u origin gh-pages
cd ../x5gon-mobile

