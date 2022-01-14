#!/bin/sh
# Script to deploy the site

# Option 1: latest upstream
pip install mkdocs-material
# Option 2: a proposed branch
# pip install git+https://github.com/squidfunk/mkdocs-material.git@refactor/compatibility
# Option 3: an older version that is compatible with Firefox 52 and IE
# pip install 'mkdocs-material<5'
# site_packages=$(pip show mkdocs-material | awk '/Location:/ { print $2 }')
# cp dev/el.html "$site_packages"/material/partials/language*/
pip install mkdocs-minify-plugin
pip install mkdocs-material-extensions
pip install mkdocs-redirects
pip install mkdocs-section-index
pip install mkdocs-with-pdf
# Use a different site_url for ts.sch.gr/docs/linux vs pe86.github.io/linux
ENABLE_PDF_EXPORT=0 mkdocs gh-deploy --remote-branch ts-docs --force
sed 's,site_url:.*,site_url: https://pe86.github.io/linux,' -i mkdocs.yml
ENABLE_PDF_EXPORT=0 mkdocs gh-deploy --force
