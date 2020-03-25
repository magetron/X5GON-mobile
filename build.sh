#/bin/sh

/bin/rm -rf static

mkdir static
cd static
mkdir archive
cd ..

cp *.html static
cp *.md static
cp -r css static
cp -r docs static
cp -r images static
cp -r js static
cp -r webfonts static
cp -r external static

cd static

perl -pe 's|<div id="nav-placeholder"></div>|`cat nav.html`|ge' -i *.html

perl -pe 's|<div id="footer-placeholder"></div>|`cat footer.html`|ge' -i *.html

research_md_html="research-md.html"

echo "<zero-md>" > $research_md_html
echo "<template>" >> $research_md_html
echo "<style>" >> $research_md_html
cat css/markdown.css >> $research_md_html
echo "</style>" >> $research_md_html
echo "<xmp>" >> $research_md_html
cat research.md >> $research_md_html
echo "</xmp>" >> $research_md_html
echo "</template>" >> $research_md_html
echo "</zero-md>" >> $research_md_html

perl -pe 's|<zero-md .* src="research.md"></zero-md>|`cat research-md.html`|ge' -i research.html

/bin/rm -rf external
/bin/rm -rf research.md
/bin/rm -rf nav.html
/bin/rm -rf footer.html
/bin/rm -rf $research_md_html

cd ..

cp archive/*.html static/archive
cp archive/*.md static/archive
cp -r archive/css static/archive
cp -r archive/docs static/archive
cp -r archive/images static/archive
cp -r archive/js static/archive/
cp -r archive/webfonts static/archive
cp -r archive/external static/archive

cd static/archive

perl -pe 's|<div id="nav-placeholder"></div>|`cat nav.html`|ge' -i *.html

perl -pe 's|<div id="footer-placeholder"></div>|`cat footer.html`|ge' -i *.html

research_md_html="research-md.html"

echo "<zero-md>" > $research_md_html
echo "<template>" >> $research_md_html
echo "<style>" >> $research_md_html
cat css/markdown.css >> $research_md_html
echo "</style>" >> $research_md_html
echo "<xmp>" >> $research_md_html
cat research.md >> $research_md_html
echo "</xmp>" >> $research_md_html
echo "</template>" >> $research_md_html
echo "</zero-md>" >> $research_md_html

perl -pe 's|<zero-md .* src="research.md"></zero-md>|`cat research-md.html`|ge' -i research.html

/bin/rm -rf external
/bin/rm -rf research.md
/bin/rm -rf nav.html
/bin/rm -rf footer.html
/bin/rm -rf $research_md_html

cd ../..





