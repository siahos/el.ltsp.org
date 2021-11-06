# Πώς έγινε η μετατροπή

* Εισαγωγή με το https://github.com/outofcontrol/mediawiki-to-gfm
* Αντιγραφή όλων των εικόνων με scp από το ts.sch.gr
* Μετακίνηση μόνο των σημαντικών εικόνων:

    ```shell
    pngs=$(grep -hro '[^:([" *][^:([" *]*\.png' | sort -u)
    for p in $pngs; do
        mv ../../images/$p .
    done
    ```
