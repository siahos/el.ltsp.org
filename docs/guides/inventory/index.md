# Απογραφή υποδομών ΤΠΕ-ΣΕΠΕΗΥ (Κτηματολόγιο)

Για να μπορέσετε να απογράψετε τους Η/Υ του εργαστηρίου ΣΕΠΕΗΥ στο Κτηματολόγιο
(inventory.sch.gr), χρησιμοποιήστε τις ακόλουθες εντολές:

## Για τον LTSP Server

Ανοίγουμε [τερματικό](../../glossary#terminal) και για τα χαρακτηριστικά:

## Της μητρικής (Motherboard)

1.  Όταν έχουμε επώνυμο, με brand name Η/Υ (π.χ. Lenovo ThinkCentre M91p):

    ```shell-session
    $ sudo dmidecode -t system | grep "Manufacturer\|Product Name\|Version"
    Manufacturer: LENOVO
    Product Name: 7033GP9
    Version: ThinkCentre M91p
    ```

2.  Όταν ΔΕΝ έχουμε επώνυμο Η/Υ και θέλουμε τον τύπο της μητρικής (π.χ. Asus H110M-D):

    ```shell-session
    $ sudo dmidecode -t baseboard | grep "Manufacturer\|Product Name\|Version"
    Manufacturer: ASUSTeK COMPUTER INC.
    Product Name: H110M-D
    Version: Rev X.0x
    ```

!!! tip ""
    Ανάλογα το μοντέλο επώνυμου ή μη Η/Υ, η χρήσιμη πληροφορία μπορεί
    να βρίσκεται στη γραμμή `Version` όπως στο παράδειγμα του Lenovo.

## Του επεξεργαστή (CPU)

Π.χ. Intel Core i3-6100 στα 3.70GHz με socket LGA1151:

```shell-session
$ sudo dmidecode -t processor | grep "Socket\|Version\|capable"
Socket Designation: LGA1151
Version: Intel(R) Core(TM) i3-6100 CPU @ 3.70GHz
        64-bit capable
```

!!! tip ""
    Η τελευταία γραμμή μας ενημερώνει αν η CPU είναι 32/64 bit.

## Της μνήμης (RAM)

Π.χ. Corsair 8GB DDR4 2133 Mhz:

```shell-session
$ sudo dmidecode -t memory | grep "Size\|Type\|Speed\|Manufacturer"
Error Correction Type: None
Size: 8 GB
Type: DDR4
Type Detail: Synchronous
Speed: 2133 MT/s
Manufacturer: Corsair
Configured Memory Speed: 2133 MT/s
Size: No Module Installed
Type: Unknown
Type Detail: None
Speed: Unknown
Manufacturer: Not Specified
Configured Memory Speed: Unknown
```

!!! warning "Προσοχή"
    Εδώ δεν εμφανίζεται η συνολική RAM αλλά η χωρητικότητα του κάθε
    module. Στο συγκεκριμένο παράδειγμα υπάρχει ΜΟΝΟ ένα module των
    8GB, που είναι και η συνολική μνήμη. Για τον υπολογισμό της
    συνολικής μνήμης, πρέπει ΠΑΝΤΑ να αθροίζονται οι γραμμές `Size`.

## Του σκληρού δίσκου (HDD/SSD)

1.  **HDD** (π.χ. Toshiba 1000GB):

    ```shell-session
    $ lsblk -o name,model,size,rota | grep "sd"
    sda    TOSHIBA_DT01ACA100       931,5G    1
    ├─sda1                          139,7G    1
    ├─sda2                          232,8G    1
    ├─sda3                            551G    1
    └─sda4                              8G    1
    ```

2.  **SSD** (π.χ. Corsair 120GB):

    ```shell-session
    $ lsblk -o name,model,size,rota | grep "sd"
    sda    Corsair_Force_LE200_SSD 111,8G    0
    ├─sda1                           499M    0
    ├─sda2                            99M    0
    ├─sda3                            16M    0
    ├─sda4                          55,4G    0
    └─sda5                          55,8G    0
    ```

!!! tip "Σημαντικό"
    Η τελευταία στήλη χαρακτηρίζει τον σκληρό δίσκο:

    -   1: HDD (με κινητά μέρη)
    -   0: SSD

    Τα sda με αριθμό (sdaX) είναι τα πιθανά partitions που υπάρχουν.
    Σε περίπτωση που είναι εγκατεστημένος και δεύτερος δίσκο θα εμφανιστεί ως sdb.

## Για τα clients

Ισχύουν οι ίδιες εντολές, με τη διαφορά ότι θα εκτελεστούν μέσω του ***Επόπτη***:

1.  Πάνω στην εικόνα του client που θέλουμε να καταγράψουμε: ***δεξί
    κλικ*** ▸ ***Εκτέλεση*** ▸ ***Άνοιγμα κονσόλας*** ▸ ***Διαχειριστή,
    τοπικά***.

2.  Στο παράθυρο (XTerm) που ανοίγει, μπορούμε να κάνουμε αντιγραφή (από τον
    οδηγό) την εντολή που θέλουμε και την επικολλούμε, πατώντας το ***μεσαίο
    κλικ*** (κλικ πατώντας τη ροδέλα του ποντικιού) ή με
    **`Shift`**+**`Insert`**. π.χ.

    ```shell-session
    root@pc01:~# sudo dmidecode -t memory | grep "Size\|Type\|Speed\|Manufacturer"
            Error Correction Type: None
            Error Correction Type: None
            Size: 1 GB
            Type: DDR2
            Type Detail: Synchronous
            Speed: 667 MT/s
            Manufacturer: JEDEC ID:CE 00 00 00 00 00 00 00
            Size: 1 GB
            Type: DDR2
            Type Detail: Synchronous
            Speed: 667 MT/s
            Manufacturer: JEDEC ID:AD 00 00 00 00 00 00 00
            Size: 1 GB
            Type: DDR2
            Type Detail: Synchronous
            Speed: 667 MT/s
            Manufacturer: JEDEC ID:7F 7F 7F 0B 00 00 00 00
            Size: 1 GB
            Type: DDR2
            Type Detail: Synchronous
            Speed: 667 MT/s
            Manufacturer: JEDEC ID:7F 98 00 00 00 00 00 00
            Size: 4 MB
            Type: Flash
            Type Detail: Non-Volatile
            Speed: Unknown
            Manufacturer: Not Specified
    ```
    Στο συγκεκριμένο παράδειγμα έχουμε **4 module DDR2 του 1GB στα 667Mhz της JEDEC**.

    !!! tip "Χρήσιμο"
        Αν θέλετε το αποτέλεσμα της εντολής να το αντιγράψετε/επικολλήσετε,
        τότε απλά ΜΟΝΟ το επιλέγετε και το κάνετε επικόλληση με ***δεξί κλικ***
        ▸ ***Επικόλληση*** ή με **`Ctrl`**+**`V`**. **Προσοχή**: Για να
        λειτουργήσει σωστά η αντιγραφή θα πρέπει να είναι ενεργοποιημένο το
        ***Select to Clipboard***. Για ενεργοποίηση, μέσα στο παράθυρο (XTerm)
        κρατάτε πατημένο το **`Ctrl`**+**`μεσαίο κλικ`**.

