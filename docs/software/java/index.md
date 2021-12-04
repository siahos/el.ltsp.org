# Java

Κάποιες εφαρμογές απαιτούν την ύπαρξη ενός περιβάλλοντος Java. Υπάρχουν δύο
εναλλακτικά πακέτα για Java, η έκδοση OpenJDK που αναπτύσσεται από την
κοινότητα, και η Oracle Java.

## OpenJDK

Η OpenJDK είναι προτιμητέα στις περισσότερες περιπτώσεις για την εκτέλεση
σύγχρονων τοπικών εφαρμογών Java. Δεν διαθέτει πια plugin για εκτέλεση μέσω
browser. Η εγκατάστασή της γίνεται είτε από το `synaptic` είτε εκτελώντας
την παρακάτω εντολή σε ένα τερματικό:

```shell
sudo apt install default-jre
```

## Oracle Java

Η Oracle Java χρειάζεται για την εκτέλεση κάποιων παλιών ή προβληματικών
λογισμικών τα οποία δεν είναι συμβατά με την OpenJDK, αλλά και για την
εμφάνιση παλιών Java applets που εκτελούνται μέσω browser plugin όπως είναι
ελάχιστα εκπαιδευτικά λογισμικά της σελίδας <https://ts.sch.gr/software>.

Η εγκατάσταση της Oracle Java 8 μπορεί να επιτευχθεί είτε μέσω του `synaptic`
είτε ανοίγοντας ένα τερματικό και εκτελώντας την εντολή:

```shell
sudo apt-get install oracle-java8-installer
```

Εάν η λειτουργία που ενδιαφέρεστε αφορά τον περιηγητή Palemoon, θα πρέπει να
τον επανεκκινήσετε για να αρχικοποιηθεί σωστά το πρόσθετο.

### Java applets

Η εκτέλεση Java applets εντός των browsers είχε τεράστια θέματα ασφαλείας και
από τον Ιανουάριο του 2021 καταργήθηκε τελείως στους Google Chrome και
Mozilla Firefox. Πλέον η εκτέλεση Java applets είναι ιδιαίτερα επίπονη, και
απαιτεί τα παρακάτω βήματα:

 1. Εγκαταστήστε το [sch-webapp-launcher](sch-webapp-launcher) (δείτε τη
    σχετική σελίδα). Έτσι θα εγκατασταθεί αυτόματα και ο περιηγητής Palemoon
    που υποστηρίζει ακόμα την εκτέλεση Java applets.

 2. Ορίστε τον ιστοχώρο της Τεχνικής Στήριξης ως ασφαλή:
    - Ανοίξτε τον πίνακα ελέγχου της Java επιλέγοντας ***Σύστημα*** ▸
      ***Προτιμήσεις*** ▸ ***Άλλα*** ▸ ***Oracle Java 8 Plugin Control Panel***
      ή εκτελώντας `/usr/lib/jvm/java-8-oracle/bin/ControlPanel` σε ένα
      τερματικό.
    - Επιλέξτε την καρτέλα ***Security*** και το κουμπί ***Edit Site List…***
    - Πατήστε ***Add***, προσθέστε τη διεύθυνση <https://ts.sch.gr> και στη
      συνέχεια πατήστε ***OK***, ***Continue***, ***OK***, ***OK***.

 3. Πηγαίνετε στο μενού ***Εφαρμογές*** ▸ *** Εκπαίδευση*** ▸ ***Ιστότοπος
    εκπαιδευτικών λογισμικών***, το οποίο θα ανοίξει τη σελίδα
    <https://ts.sch.gr/software> με τον περιηγητή Palemoon. Επιλέξτε το
    λογισμικό Java που σας ενδιαφέρει, για παράδειγμα [Μαθηματατικά Γ΄ & Δ΄
    Δημοτικού](https://ts.sch.gr/repo/online-packages/dim-mathimatika-c-d/d05-web/index.html)
    ▸ [Χελωνοσελίδα](https://ts.sch.gr/repo/online-packages/dim-mathimatika-c-d/d05-web/classG/programs/JLogo.html).

 4. Θα εμφανιστεί ένας διάλογος *Security Warning*, στον οποίο πρέπει να
    επιλέξετε:

      - *Do you want to run this application?*

        ***☑ I accept the risk and want to run this application***

        ***Run***

      - *Block potentially unsafe components from being run?*

        ***Don't Block***

      - *Do you want to run this application?*

         ***Run***

## Προεπιλεγμένη Java

Είναι δυνατόν να εγκαταστήσετε ταυτόχρονα το OpenJDK για τοπικές εφαρμογές και
την Oracle Java για τα Java applets εντός του browser. Για να επιλέξετε ποια
από τις δύο θα χρησιμοποιείται για τοπικές εφαρμογές, εκτελέστε σε ένα
τερματικό:

```shell
sudo update-alternatives --config java
```

Το αποτέλεσμα της εντολής αυτής μοιάζει κάπως έτσι:

```shell-session
There are 2 choices for the alternative java (providing /usr/bin/java).

Selection Path Priority Status
------------------------------------------------------------
* 0 /usr/lib/jvm/java-8-oracle/bin/java 1062 auto mode
1 /usr/lib/jvm/java-6-openjdk/jre/bin/java 1061 manual mode
2 /usr/lib/jvm/java-8-oracle/bin/java 1062 manual mode

Press enter to keep the current choice[*], or type selection number:
```

Δίνοντας την επιλογή `1`, ως προεπιλεγμένη Java του συστήματος θα οριστεί η
OpenJDK.
