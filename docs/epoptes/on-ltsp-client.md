# Εκτέλεση από LTSP client

**TODO: μετάφραση από το <https://epoptes.org/documentation/run-fat/>**

Αυτή η σελίδα προϋποθέτει ότι έχετε ήδη εγκαταστήσει τα
[sch-scripts](../sch-scripts/Εγκατάσταση.md).

Ας υποθέσουμε ότι ο LTSP server εξυπηρετεί 3 εργαστήρια υπολογιστών.
Σε αυτή την περίπτωση, πώς θα μπορούσε να εκτελείται ο `epoptes` για κάθε ένα εργαστήριο;

Υπάρχουν δύο λύσεις:

-   «Απομακρυσμένα»
-   «Τοπικά»

Ο παρακάτω πίνακας τις συγκρίνει:

| Ερώτηση                     | Απομακρυσμένα                          | Τοπικά                                      |
|-----------------------------|----------------------------------------|---------------------------------------------|
| Που "εκτελείται" ο Επόπτης; | Στον LTSP server                       | Σε client εργαστηρίου                       |
| Ποιους "βλέπει" ο Επόπτης;  | Όλα τα clients σε όλα τα εργαστήρια    | Μόνο τα clients του εργαστήριου             |
| Το broadcast είναι γρήγορο; | Όχι γιατί γίνεται μεσω του LTSP server | Ναι, χρησιμοποιούνται απ' ευθείας συνδέσεις |
| Είναι ασφαλές;              | Ναι                                    | Όχι τόσο πολύ                               |

Επομένως, σε όλες τις περιπτώσεις η λύση «Τοπικά» είναι καλύτερη, εκτός από την
ασφάλεια, καθώς τότε το ιδιωτικό κλειδί του `epoptes` εκτίθεται στο τοπικό δίκτυο,
επιτρέποντας επιθέσεις [man-in-the-middle](https://el.wikipedia.org/wiki/Επίθεση_man-in-the-middle) αλλά
**όχι** [network sniffing](https://el.wikipedia.org/wiki/Packet_sniffer).

## Απομακρυσμένα

«Απομακρυσμένα» σημαίνει ότι συνδεόμαστε στον διακομιστή LTSP και η εκκίνηση
του ***Επόπτης*** γίνεται μέσω του LTSP server, παρόμοια με τα `epoptes
ltsp-remoteapps` στο παλαιότερο LTSP5.

Δεδομένου όμως ότι το νέο LTSP δεν υποστηρίζει `remoteapps`, απαιτούνται τα
ακόλουθα βήματα:

1. Προσθέστε στο `ltsp.conf` τα ακόλουθα:
   ```text title="ltsp.conf"
   [clients]
   POST_INIT_EPOPTES="sed 's|^Exec=/usr/bin/epoptes|Exec=ssh -X server dbus-launch epoptes|' -i /usr/share/applications/epoptes.desktop"
   ```
2. εκτελέστε την εντολή:
   ```shell
   ltsp initrd
   ```
3. και επανεκκινήστε τα clients.

Στη συνέχεια, θα πρέπει όλοι οι χρήστες της ομάδας `epoptes` να συνδεθούν σε
έναν client και να εκτελέσουν τις ακόλουθες εντολές **μία φορά**:

```shell
# Generate an SSH key if it doesn't already exist:
test -f ~/.ssh/id_rsa || ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa -N ''
# Enable "passwordless SSH" by trusting the key:
install -m 0600 ~/.ssh/id_rsa.pub ~/.ssh/authorized_keys
# Connect to the LTSP server once, in order to trust the server as well:
ssh -X server x-terminal-emulator
```
Μετά από αυτό, θα μπορούν να εκτελούν το ***Επόπτης***, από το μενού συστήματος.

## Τοπικά

Σε αυτή τη λύση, ένας LTSP client ανά εργαστήριο ονομάζεται `the epoptes PC`.
Σε αυτούς τους clients δίνουμε συγκεκριμένα ονόματα `hostnames`, για παράδειγμα
`a00` για το `lab-a`, ώστε να τους επιτρέπεται να εκτελούν την υπηρεσία
`epoptes` αλλά και το ***Επόπτης*** (GUI). Τα υπόλοιπα LTSP clients του
εργαστηρίου λαμβάνουν οδηγίες ώστε να συνδεθούν στον `the epoptes PC` και όχι
στον LTSP server. Για να γίνουν όλα αυτά, χρειάζονται οι ακόλουθες ρυθμίσεις
στο `ltsp.conf`. Συγχωνεύστε την ενότητα `[server]` με αυτήν που ήδη έχετε και
ΜΗ δημιουργήσετε νέα:

```text title="ltsp.conf"
[server]
# Διατήρηση του ιδιωτικού κλειδου (private key) του Επόπτη, στους εικονικούς δίσκους LTSP.
OMIT_IMAGE_EXCLUDES="etc/epoptes/server.key"

[lab-a]
# Οδηγία ώστε οι `lab-a` clients να συνδεθούν στο `a00.local`.
# Οι καταλήξεις `.local` προσθέτονται αυτόματα στα hostnames από την υπηρεσία `avahi`.
POST_INIT_EPOPTES="sed 's/.*SERVER=.*/SERVER=a00.local/' -i /etc/default/epoptes-client"

[mac:address:of:lab-a-epoptes-pc]
HOSTNAME=a00
# Στο epoptes client, εκκίνηση της υπηρεσία `epoptes`
KEEP_SYSTEM_SERVICES="epoptes"
IGNORE_EPOPTES=1

[mac:address:of:lab-a-client01]
HOSTNAME=a01
# Χρήση οδηγίας `INCLUDE` για αντιστοίχηση clients σε όνομα εργαστηρίου.
INCLUDE=lab-a
```

Τέλος, εκτελέστε τις ακόλουθες εντολές στον LTSP server ως `root`:

```shell
# Δημιουργία εικονικού δίσκου.
ltsp image /
# Ενημέρωση του /srv/tftp/ltsp/ltsp.img με τις αλλαγές στο `ltsp.conf`.
ltsp initrd
```
