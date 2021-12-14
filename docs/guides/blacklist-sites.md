# Απαγόρευση πρόσβασης σε συγκεκριμένες ιστοσελίδες

Για γρήγορη απαγόρευση σελίδων, **χωρίς squid** και εφόσον έχετε ήδη
εγκαταστήσει τα [sch-scripts](../../glossary/#sch-scripts), από
[τερματικό](../../glossary/#terminal) εκτελείτε:

```
sudo pluma /etc/dnsmasq.d/blacklist.conf
```

Μέσα στο αρχείο που θα ανοίξει, βάζετε γραμμές του τύπου:


```text title="/etc/dnsmasq.d/blacklist.conf"
address=/facebook.com/127.0.0.1
address=/zoo.gr/127.0.0.1
```

Αποθηκεύετε και επανεκκινείτε το `dnsmasq`:

```
sudo service dnsmasq restart
```

Στη συνέχεια το facebook στα clients θα βγάζει ότι δεν βρέθηκε η σελίδα (και αν έχετε cisco router και στατική IP σε .10, και σε windows clients).

*Η αρχική επιμέλεια του οδηγού έγινε από τον alkisg <https://alkisg.mysch.gr/steki/index.php?topic=5060.0>*
