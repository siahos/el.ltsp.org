# Απομακρυσμένη πρόσβαση

Για απομακρυσμένη πρόσβαση (π.χ. από το σπίτι) στον εξυπηρετητή του ΣΕΠΕΗΥ σας,
θα σας φανούν χρήσιμες οι παρακάτω πληροφορίες.

## Anydesk

Το Anydesk είναι ένα δωρεάν πρόγραμμα τύπου teamviewer που δουλεύει σε όλα τα
λειτουργικά. Μπορείτε να το κατεβάσετε από [τη σελίδα
του](https://anydesk.com/el), να το εγκαταστήσετε, να ρυθμίσετε έναν κωδικό για
απομακρυσμένη πρόσβαση χωρίς επιβεβαίωση, και δεν χρειάζεται να ασχοληθείτε με
τις IP και τα DNS names που αναφέρονται στις παρακάτω ενότητες. Το μειονέκτημα
είναι ότι η κίνηση περνάει από τους servers της anydesk, οπότε υπάρχουν θέματα
ασφάλειας και επιδόσεων.

## Εξωτερική IP

Εάν από τον εξυπηρετητή του σχολείου επισκεφτείτε τη σελίδα
<https://ts.sch.gr/services/ip> θα δείτε την εξωτερική του IP, που είναι αυτή
στην οποία θα συνδεθείτε εάν θέλετε να χρησιμοποιήσετε SSH, VNC, X2GO ή RDP.

### Routers OTE

Τα σχολεία με routers του OTE (π.χ. Speedport) συνήθως έχουν δυναμική εξωτερική
IP, η οποία μπορεί να αλλάξει μετά από κάποιες ώρες ή μέρες. Εφόσον θέλουμε
απομακρυσμένη πρόσβαση, μπορούμε να ανοίξουμε ένα δελτίο στο helpdesk και να
ζητήσουμε στο ΠΣΔ να μας δώσει σταθερή εξωτερική IP ακόμα και αν έχουμε router
του ΟΤΕ. Εναλλακτικά μπορεί να χρησιμοποιηθεί μια υπηρεσία τύπου
<https://www.duckdns.org/>, η οποία αντιστοιχεί ονόματα π.χ.
sxoleio.duckdns.org σε δυναμικές IP. Είτε έχουμε σταθερή είτε δυναμική IP, από
το [web interface του router](http://192.168.1.1), θα πρέπει να γίνει port
forwarding της θύρας π.χ. 7100 στη θύρα 22 που χρησιμοποιεί το SSH.

### Routers ΠΣΔ

Τα σχολεία με MikroTik ή Cisco routers τα διαχειρίζεται το ΠΣΔ και τους δίνει 4
σταθερές εξωτερικές IP. Οι δύο από αυτές αντιστοιχούν στα παρακάτω ονόματα και
IP:

- srv-sxoleio.nom.sch.gr = 10.x.y.10
- srv1-sxoleio.nom.sch.gr = 10.x.y.11

Έτσι αν βάλετε τον server στην IP=10.x.y.10, θα μπορείτε να τον δείτε με το
όνομα srv-sxoleio.nomos.sch.gr (δηλαδή ίδιο με το όνομα της ιστοσελίδας του
σχολείου, αλλά με ένα srv- μπροστά).

## Πρόσβαση με SSH

Η υπηρεσία SSH για απομακρυσμένη πρόσβαση κονσόλας στον εξυπηρετητή κανονικά
ακούει στη θύρα 22, η οποία είναι προσβάσιμη μόνο από το υποδίκτυο διαχείρισης
ΣΕΠΕΗΥ (ΚΕΠΛΗΝΕΤ κτλ), και επομένως όχι από το σπίτι σας. Έτσι θα πρέπει να
καθορίσετε να ακούει και σε μια δεύτερη θύρα π.χ. 7100, η οποία είναι
προσβάσιμη, εκτελώντας από μία κονσόλα:

```shell
sudo cp /dev/stdin /etc/ssh/sshd_config.d/local.conf <<EOF
Port 22
Port 7100
EOF
```

Στη συνέχεια, από το σπίτι σας δίνετε την παρακάτω εντολή για να αποκτήσετε
πρόσβαση με SSH. Η εντολή ισχύει είτε από Linux είτε από Windows:

```shell
ssh -p 7100 administrator@srv-sxoleio.nom.sch.gr
```

## Πρόσβαση με VNC

Στο σπίτι, κατεβάζουμε το [RealVNC
Viewer](https://www.realvnc.com/en/connect/download/viewer/) είτε για Linux
είτε για Windows, και το εκτελούμε με την παρακάτω εντολή:

```shell
vncviewer -SecurityNotificationTimeout=0 -ColorLevel=pal8 -shared -listen
```

Στη συνέχεια ακολουθούμε τις παραπάνω οδηγίες για πρόσβαση με SSH, αλλά τελικά
δίνουμε την παρακάτω εναλλακτική εντολή:

```shell
ssh -p 7100 -tCR 5501:localhost:5500 administrator@srv-sxoleio.nom.sch.gr /usr/share/sch-scripts/reverse-vnc
```

Αυτή η εντολή θα συνδεθεί στην υπάρχουσα συνεδρία, εφόσον υπάρχει, ή στην οθόνη
σύνδεσης εάν κανείς χρήστης δεν είναι συνδεδεμένος.

## Πρόσβαση με RDP

Το πρωτόκολλο remote desktop των Windows υποστηρίζεται και από το Linux εφόσον
εγκαταστήσουμε το παρακάτω πακέτο:

```shell
sudo apt install xrdp
```

Μας επιτρέπει να συνδεθούμε σε δεύτερη συνεδρία στον εξυπηρετητή, χωρίς να
ενοχλήσουμε κάποιον που εργάζεται εκεί. Επειδή όμως η θύρα 3389 που
χρησιμοποιεί είναι κλειστή σε διάφορες περιπτώσεις (π.χ. στους MikroTik/Cisco
routers) για λόγους ασφαλείας, ακολουθούμε πάλι τις παραπάνω οδηγίες για
πρόσβαση με SSH, αλλά τελικά δίνουμε την παρακάτω εναλλακτική εντολή:

```shell
ssh -p 7100 -L 3390:localhost:3389 administrator@srv-sxoleio.nom.sch.gr
```

Αυτή θα κάνει μεν σύνδεση με SSH, αλλά θα προωθήσει και τη θύρα 3389 που
χρησιμοποιεί το RDP. Στη συνέχεια, στον υπολογιστή του σπιτιού, κάνουμε
απομακρυσμένη σύνδεση τύπου RDP στο localhost. Η σχετική εντολή από Linux
είναι:

Ενώ η σχετική εντολή από Windows είναι:

```shell
xfreerdp /v:localhost:3390 /relax-order-checks +glyph-cache /size:1600x900
```

## Πρόσβαση με SSH κλειδιά (ενότητα για προχωρημένους) {:#ssh-keys}

-   Αυτό μας εξασφαλίζει ότι ΜΟΝΟ όποιος έχει το σωστό SSH κλειδί (private)
    μπορεί να συνδεθεί μέσω της πόρτας 7100 στον LTSP server.
-   Εφαρμόζεται απαγόρευση password authentication στην πόρτα 7100, ώστε πλέον
    η πόρτα 7100, να μη δέχεται αιτήματα σύνδεσης με username/password από
    χρήστη ή bot.

Βήματα:

1.  Δημιουργούμε το αρχείο `/etc/ssh/sshd_config.d/local.conf` όπως
    περιγράφεται στην ενότητα [Πρόσβαση με SSH](#πρόσβαση-με-ssh).

2.  Δημιουργούμε τα SSH public/private keys (δύο αρχεία) όπως και το
    authorized_keys (ένα αρχείο):
    ```shell-session
    $ ssh-keygen -qf ~/.ssh/id_ed25519 -N '' -t ed25519
    $ ssh-copy-id administrator@localhost
    The authenticity of host 'localhost (127.0.0.1)' can't be established.
    ECDSA key fingerprint is SHA256:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx.
    Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
    /bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
    /bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
    administrator@localhost's password:

    Number of key(s) added: 1

    Now try logging into the machine, with:   "ssh 'administrator@localhost'"
    and check to make sure that only the key(s) you wanted were added.
    ```
3.  Ελέγχουμε αν τα αρχεία έχουν δημιουργηθεί επιτυχώς:
    ```shell-session
    $ ls -l .ssh/
    σύνολο 16
    -rw------- 1 administrator administrator 111 Νοε   5 19:55 authorized_keys
    -rw------- 1 administrator administrator 419 Νοε   5 19:49 id_ed25519
    -rw-r--r-- 1 administrator administrator 111 Νοε   5 19:49 id_ed25519.pub
    -rw-r--r-- 1 administrator administrator 666 Νοε   5 19:55 known_hosts
    ```
4.  Στο τέλος του αρχείου `/etc/ssh/sshd_config`:
    ```shell
    sudo xdg-open /etc/ssh/sshd_config
    ```
    προσθέτουμε τις ακόλουθες γραμμές:
    ```text
    Match LocalPort 7100
    PasswordAuthentication no
    ```
5.  Για να εφαρμοστούν οι αλλαγές:
    ```shell
    sudo systemctl restart ssh
    ```
6.  Αντιγράφουμε το `id_ed25519` (private key), από τον φάκελο `.ssh` του LTSP
    server, στον αντίστοιχο `.ssh` των windows/ubuntu, του προσωπικού μας
    υπολογιστή.
7.  Από τον προσωπικό μας υπολογιστή, συνδεόμαστε στον LTSP server μέσω
    [SSH](#πρόσβαση-με-ssh)/[VNC](#πρόσβαση-με-vnc)/[RDP](#πρόσβαση-με-rdp).
