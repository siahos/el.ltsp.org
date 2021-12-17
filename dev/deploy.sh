#!/bin/sh
# Script to deploy the site

(
    env
    cat /proc/cpuinfo
    free
    ip a
) >docs/github.txt

pip install mkdocs-minify-plugin
pip install 'mkdocs-material<5'
site_packages=$(pip show mkdocs-material | awk '/Location:/ { print $2 }')
cp dev/el.html "$site_packages"/material/partials/language*/
pip install mkdocs-material-extensions
pip install mkdocs-redirects
pip install mkdocs-section-index
pip install mkdocs-with-pdf
ENABLE_PDF_EXPORT=0 mkdocs gh-deploy --force
