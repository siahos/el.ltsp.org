# Zoom

Το zoom είναι εφαρμογή τηλεδιασκέψεων που μπορεί να χρησιμοποιηθεί μέσω υπολογιστή ή φορητή συσκευή 
και επιτρέπει σε χρήστες να συνδεθούν σε online συναντήσεις ή σεμινάρια με βιντεοκλήση.

## Εγκατάσταση

Η εγκατάσταση του Zoom γίνεται εύκολα με ένα πακέτο deb. Αυτό όμως εξαρτάται από ένα πακέτο ονόματι ibus, 
άρα εγκαθίσταται κι αυτό αυτόματα. Το ibus είναι ένα εξελιγμένο πληκτρολόγιο για πολλές γλώσσες, 
μέχρι και κινέζικα. Έτσι όμως καταλήγουμε να έχουμε δύο ενδείξεις γλώσσας στην γραμμή εργασιών.

Πρίν εγκαταστήσουμε το deb θα πρέπει να εγκαταστήσουμε ένα κενό υποκατάστατο του ibus χρησιμοποιώντας το equivs:

```shell
sudo apt install equivs
mkdir equivs
cd equivs
equivs-control equivs-ibus
pluma equivs-ibus
```

Έτσι δημιουργήθηκε ένα αρχείο περιγραφής πακέτου και άνοιξε με έναν κειμενογράφο. Αλλάζουμε τα περιεχόμενα σε κάτι τέτοιο:

```shell
### Commented entries have reasonable defaults.
### Uncomment to edit them.
# Source: <source package name; defaults to package name>
Section: misc
Priority: optional
Homepage: https://packages.debian.org/equivs
Standards-Version: 3.9.2

Package: equivs-ibus
# Version: <enter version here; defaults to 1.0>
# Maintainer: Your Name <yourname@example.com>
# Pre-Depends: <comma-separated list of packages>
# Depends: <comma-separated list of packages>
# Recommends: <comma-separated list of packages>
# Suggests: <comma-separated list of packages>
Provides: ibus
# Replaces: <comma-separated list of packages>
# Architecture: all
# Multi-Arch: <one of: foreign|same|allowed>
# Copyright: <copyright file; defaults to GPL2>
# Changelog: <changelog file; defaults to a generic changelog>
# Readme: <README.Debian file; defaults to a generic one>
# Extra-Files: <comma-separated list of additional files for the doc directory>
# Links: <pair of space-separated paths; First is path symlink points at, second is filename of link>
# Files: <pair of space-separated paths; First is file to include, second is destination>
#  <more pairs, if there's more than one file to include. Notice the starting space>
Description: Dummy package to satisfy unwanted dependencies
 This one provides ibus in order to be able to install zoom.
```

Στη συνέχεια και ενώ είμαστε στον ίδιο φάκελο, δημιουργούμε και εγκαθιστούμε το ψευτο-πακέτο:

```shell
equivs-build equivs-ibus
sudo dpkg -i ./equivs-ibus*.deb
```

Μετά από όλα αυτά, μπορούμε να εγκαταστήσουμε το zoom χωρίς να εγκατασταθεί παράλληλα και το ibus.

```shell
wget https://zoom.us/client/latest/zoom_amd64.deb
sudo apt install ./zoom_amd64.deb
```
Μετά την εγκατάσταση, μπορείτε να εκκινήσετε την εφαρμογή από το μενού
***Εφαρμογές*** ▸ ***Διαδίκτυο*** ▸ ***Zoom***.

ΠΡΟΣΟΧΗ: Αν εγκαταστήσατε το zoom πρίν διαβάσετε τον οδηγό και το παραπάνω πρόβλημα παρουσιάστηκε ήδη, 
μπορείτε να ετοιμάσετε και να εγκαταστήσετε το πακέτο equivs-ibus όπως παραπάνω και ύστερα να απεγκαταστήσετε το ibus:

```shell
sudo apt purge ibus
```

## Απεγκατάσταση

Εάν χρειαστεί, η απεγκατάσταση του Zoom μπορεί να επιτευχθεί είτε μέσα από
το `synaptic` είτε δίνοντας την παρακάτω εντολή σε ένα τερματικό:

```shell
sudo apt purge zoom
```
