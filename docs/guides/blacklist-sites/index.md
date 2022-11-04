# Απαγόρευση ιστοχώρων

Σε εργαστήρια LTSP όπου έχουν ήδη εγκατασταθεί τα
[sch-scripts](../../glossary/index.md#sch-scripts), για να απαγορεύσετε την
πρόσβαση σε συγκεκριμένες ιστοσελίδες, από ένα
[τερματικό](../../glossary/index.md#terminal) εκτελέστε:

```shell
sudo pluma /etc/dnsmasq.d/local.conf
```

Μέσα στο αρχείο που θα ανοίξει, προσθέστε γραμμές του τύπου:

```text title="/etc/dnsmasq.d/local.conf"
# Απενεργοποίηση των ακόλουθων ιστοχώρων
address=/facebook.com/#
address=/zoo.gr/#
```

Αποθηκεύστε και επανεκκινήστε το `dnsmasq`:

```shell
sudo systemctl restart dnsmasq
```

Στη συνέχεια το facebook στους LTSP clients θα βγάζει ότι δεν βρέθηκε η σελίδα
(και αν έχετε Cisco ή Mikrotik router και στατική IP σε .10, και σε Windows
clients).
