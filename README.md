# Τεκμηρίωση Linux για ΣΕΠΕΗΥ

Το παρόν repository αποτελεί τον πηγαίο κώδικα της σελίδας
https://ts.sch.gr/docs/linux.

## Development environment

```shell
sudo apt install python3-pip
pip install 'mkdocs-material<5' mkdocs-material-extensions mkdocs-minify-plugin mkdocs-redirects mkdocs-with-pdf
mkdocs serve
open http://localhost:7101
```

### Windows development environment

-   Στα Windows θα χρειαστεί να κάνετε εγκατάσταση την
    [Python3](https://www.python.org/downloads/).
-   ```shell
    > pip install "mkdocs-material<5" mkdocs-material-extensions
    mkdocs-minify-plugin mkdocs-redirects mkdocs-with-pdf
    ```
-   Αντιγραφή του
    [el.html](https://github.com/pe86/linux/blob/main/dev/el.html) στον φάκελο `site-packages\material\partials\language` των windows. Για να βρείτε που ακριβώς βρίσκεται ο φάκελος `site-packages` δείτε τη γραμμή `Lacation` της εντολής `pip show mkdocs-material`.
-   Αν κατά την εκτέλεση του `mkdocs serve` εμφανιστεί το ακόλουθο error:

    ```shell-session
    > mkdocs serve
    INFO     -  Building documentation...
    cannot load library 'gobject-2.0-0': error 0x7e.  Additionally, ctypes.util.find_library() did not manage to locate a library called 'gobject-2.0-0'
    ```

    τότε θα πρέπει να εγκαταστήσετε και το [GTK3](https://github.com/tschoonj/GTK-for-Windows-Runtime-Environment-Installer/releases/).

    **Προσοχή**: Μετά την εγκατάσταση κάντε επανεκκίνηση ώστε να ενημερωθεί η μεταβλητή συστήματος `Path` των Windows.

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
sed 's|\[...px\](Αρχείο:\(.*.png\) "wikilink")|[![](\1)](\1)|' -i *.md */*.md */*/*.md */*/*/*.md
find . -mindepth 1 -type d | while read -r d; do if [ -f "$d.md" ]; then mv "$d.md" "$d/index.md"; fi; done
```

