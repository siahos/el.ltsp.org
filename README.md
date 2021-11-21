# Τεκμηρίωση Linux για ΣΕΠΕΗΥ

Το παρόν repository αποτελεί τον πηγαίο κώδικα της σελίδας
https://ts.sch.gr/wiki/Linux.

## Development environment

```shell
sudo apt install python3-pip
pip install mkdocs-material mkdocs-minify-plugin mkdocs-redirects mkdocs-with-pdf
mkdocs serve
open http://localhost:8000
```

## Πώς έγινε η μετατροπή από mediawiki

* Εισαγωγή με το https://github.com/outofcontrol/mediawiki-to-gfm
* Αντιγραφή όλων των εικόνων με scp από το ts.sch.gr

Μετά:

```shell
# Μετακίνηση μόνο των σημαντικών εικόνων:
pngs=$(grep -hro '[^:([" *][^:([" *]*\.png' | sort -u)
for p in $pngs; do
    mv ../../images/$p .
    # TODO: σε κάποιες χρειάστηκε find -iname
done

# Διάφορες μαζικές διορθώσεις
sed 's|\[...px\](Αρχείο:\(.*.png\) "wikilink")|![\1](\1){: .right33}|' -i *.md */*.md */*/*.md */*/*/*.md
find . -mindepth 1 -type d | while read -r d; do if [ -f "$d.md" ]; then mv "$d.md" "$d/index.md"; fi; done
```

