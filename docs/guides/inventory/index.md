# Απογραφή υποδομών ΤΠΕ-ΣΕΠΕΗΥ (Κτηματολόγιο)

Για να μπορέσετε να απογράψετε τους Η/Υ του εργαστηρίου ΣΕΠΕΗΥ στο Κτηματολόγιο
(<http://inventory.sch.gr>), χρησιμοποιήστε τις ακόλουθες εντολές:

## Για τον LTSP Server

Ανοίξτε [τερματικό](../../glossary/index.md#terminal) και για τα χαρακτηριστικά:

## Της μητρικής (Motherboard)

1.  Όταν έχετε **επώνυμο**, με **brand name** Η/Υ (π.χ. Lenovo ThinkCentre
    M91p):

    ```shell-session
    $ sudo dmidecode -t system | grep "Manufacturer\|Product Name\|Version"
    Manufacturer: LENOVO
    Product Name: 7033GP9
    Version: ThinkCentre M91p
    ```

2.  Όταν **δεν έχετε επώνυμο** Η/Υ και θέλετε τον τύπο της μητρικής (π.χ. Asus
    H110M-D):

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

Π.χ. Corsair 8GB DDR4 2133 MHz:

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
    Εδώ δεν εμφανίζεται η συνολική RAM αλλά η χωρητικότητα του κάθε module. Στο
    συγκεκριμένο παράδειγμα υπάρχει **μόνο** ένα module των 8GB, που είναι και
    η συνολική μνήμη. Για τον υπολογισμό της συνολικής μνήμης, πρέπει **πάντα**
    να αθροίζονται οι γραμμές `Size`.

## Του σκληρού δίσκου (HDD/SSD)

1.  **HDD** (π.χ. Toshiba 1000GB):

    ```shell-session
    $ lsblk -o name,model,size,rota
    NAME   MODEL                      SIZE ROTA
    sda    TOSHIBA_DT01ACA100       931,5G    1
    ├─sda1                          139,7G    1
    ├─sda2                          232,8G    1
    ├─sda3                            551G    1
    └─sda4                              8G    1
    sr0    HL-DT-ST_DVDRAM_GH22NS40  1024M    1
    ```

2.  **SSD** (π.χ. Corsair 120GB):

    ```shell-session
    $ lsblk -o name,model,size,rota
    NAME   MODEL                     SIZE ROTA
    sda    Corsair_Force_LE200_SSD 111,8G    0
    ├─sda1                           499M    0
    ├─sda2                            99M    0
    ├─sda3                            16M    0
    ├─sda4                          55,4G    0
    └─sda5                          55,8G    0
    sr0    PLDS_DVDROM_DH16D7SH     1024M    1
    ```

!!! tip "Σημαντικό"
    Η τελευταία στήλη χαρακτηρίζει τον σκληρό δίσκο:

    -   1: HDD (με κινητά μέρη)
    -   0: SSD

    Τα sda με αριθμό (sdaX) είναι τα πιθανά partitions που υπάρχουν.
    Σε περίπτωση που είναι εγκατεστημένος και δεύτερος δίσκο θα εμφανιστεί ως sdb.

## Για τα clients

Ισχύουν οι ίδιες εντολές, με τη διαφορά ότι θα εκτελεστούν μέσω του ***Επόπτη***:

1.  Πάνω στην εικόνα του client που θέλετε να καταγράψετε: ***δεξί
    κλικ*** ▸ ***Εκτέλεση*** ▸ ***Άνοιγμα κονσόλας*** ▸ ***Διαχειριστή,
    τοπικά***.

2.  Στο παράθυρο ***XTerm*** που ανοίγει, μπορείτε να αντιγράψετε (από τον
    οδηγό) την εντολή που θέλετε και να την κάνετε επικόλληση, πατώντας το
    **μεσαίο κλικ** (κλικ πατώντας τη ροδέλα του ποντικιού) ή με
    **`Shift`**+**`Insert`**. π.χ.

    ```shell-session
    root@ltsp134:~# sudo dmidecode -t memory | grep "Size\|Type\|Speed\|Manufacturer"
        Error Correction Type: None
        Size: 4 GB
        Type: DDR3
        Type Detail: Synchronous
        Speed: 1333 MT/s
        Manufacturer: Samsung
        Size: No Module Installed
        Type: Unknown
        Type Detail: None
        Speed: Unknown
        Manufacturer: [Empty]
    ```
    Στο συγκεκριμένο παράδειγμα έχετε **1 module DDR3 των 4GB στα 1333 MHz της
    Samsung**.

    !!! tip ""
        Αν θέλετε να αντιγράψετε/επικολλήσετε, το αποτέλεσμα της εντολής, τότε
        απλά **μόνο το επιλέγετε** και το κάνετε επικόλληση με **μεσαίο κλικ**.

    !!! info "Πληροφορία"
        Ο οδηγός είναι μια προτεινόμενη λύση για την απογραφή. Για περισσότερες
        λύσεις ή και απορίες: [Απογραφή Υλικού
        (inventory.sch.gr)](https://alkisg.mysch.gr/steki/index.php?topic=6068.0)
