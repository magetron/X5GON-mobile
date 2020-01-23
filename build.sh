/bin/rm -rf static

mkdir static

cp *.html static
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
cat external/research.md >> $research_md_html
echo "</xmp>" >> $research_md_html
echo "</template>" >> $research_md_html
echo "</zero-md>" >> $research_md_html

perl -pe 's|<zero-md .* src="external/research.md"></zero-md>|`cat research-md.html`|ge' -i research.html

/bin/rm -rf external
/bin/rm -rf nav.html
/bin/rm -rf footer.html
/bin/rm -rf $research_md_html

cd ..
