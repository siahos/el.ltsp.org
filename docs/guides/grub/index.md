# GRUB

Όταν θέλετε να έχετε Η/Υ dual boot (Ubuntu/Windows), η σωστή σειρά εγκατάστασης
είναι **πρώτα τα Windows** και **τελευταίο το Ubuntu**, έτσι ώστε να
εγκατασταθεί/ενημερωθεί σωστά ο GRUB, με όλα τα διαθέσιμα λειτουργικά
συστήματα.

!!! warning "Προσοχή"
    Στις επόμενες ενότητες θα σας ζητηθεί να κάνετε boot με live USB stick.
    Επειδή όμως μπορεί να χρειαστεί να καλέσετε συναρτήσεις UEFI (π.χ. `sudo
    efibootmgr`), **προτείνεται** να είναι στο ίδιο mode (BIOS/UEFI) με το
    εγκατεστημένο Λ.Σ.

## BIOS (Legacy UEFI)

### Επιδιόρθωση GRUB {#bios-grub-repair}

Αν έχετε εγκαταστήσει **πρώτα Ubuntu σε BIOS mode** και στη συνέχεια προσθέσετε
σε διαφορετικό partition και Windows (BIOS mode), τότε το πιο πιθανό είναι **τα
Windows να επικαλύψουν (override) τον GRUB** με τον αντίστοιχο δικό τους, με
συνέπεια να κάνετε **boot πάντα σε Windows**.

Για να επιδιορθωθεί αυτό το πρόβλημα, αλλά και σε κάθε περίπτωση που θέλετε να
επιδιορθώσετε/επανεγκαταστήσετε τον GRUB (BIOS mode), θα πρέπει να κάνετε τα
εξής:

1.  [Εκκίνηση σε κατάσταση BIOS](../bios-uefi-boot/) (live USB stick).

2.  Αναγνώριση του partition number στο οποίο είναι εγκατεστημένο το Ubuntu.
    Από [τερματικό](../../glossary/index.md#terminal):

    ```shell
    lsblk --fs
    ```

    !!! tip ""
        Συνήθως στη στήλη `FSTYPE` υπάρχει χαρακτηρισμός `ext4`.

3.  Από το αποτέλεσμα του προηγούμενου βήματος, έχετε αναγνωρίσει που είναι
    εγκατεστημένο το Ubuntu. Όποτε από [τερματικό](../../glossary/index.md#terminal):

    !!! warning ""
        Στις επόμενες εντολές όπου `sdx1` και `sdx`, αντικαταστήστε με τα
        σωστά.

    ```shell
    sudo -i
	mount /dev/sdx1 /mnt
	for d in proc sys run dev dev/pts; do mount --bind /$d /mnt/$d; done
	chroot /mnt
    grub-install /dev/sdx
    update-grub
	for d in dev/pts dev run sys proc; do umount /mnt/$d; done
	umount /mnt
	sync
	reboot
    ```

## UEFI

Αν έχετε εγκαταστήσει **πρώτα Ubuntu σε UEFI mode** και στη συνέχεια προσθέσετε
σε διαφορετικό partition και Windows (UEFI mode), τότε το πιο πιθανό είναι τα
Windows να αλλάξουν την προεπιλεγμένη καταχώρηση **`ubuntu`**, με την
αντίστοιχη δική τους **`Windows Boot Manager`**, με συνέπεια να κάνετε **boot
πάντα σε Windows**.

!!! warning "Προσοχή"
    Αυτό συνήθως μας δημιουργεί την εντύπωση ότι θέλει [Επιδιόρθωση ο
    GRUB](#uefi-grub-repair), κάτι όμως που **δεν είναι απαραίτητο να γίνει**.
    Αρκεί μόνο να **αλλάξετε** τον [Προεπιλεγμένο boot
    loader](#uefi-current-boot-loader).

### Προεπιλεγμένος boot loader {#uefi-current-boot-loader}

Για να αλλάξετε την προεπιλεγμένη καταχώρηση σε **`ubuntu`**, μπορείτε να το
κάνετε με δύο τρόπους:

1.  Ορίζοντας στις ρυθμίσεις του UEFI, ως πρώτη καταχώρηση στο boot sequence,
    το **`ubuntu`**. Για να έχετε πρόσβαση στις σχετικές επιλογές, μπορείτε να
    δοκιμάστε τα πλήκτρα που περιγράφονται στο [Εκκίνηση σε κατάσταση BIOS ή
    UEFI](../bios-uefi-boot/).

2.  Από το περιβάλλον του **εγκατεστημένου** Ubuntu ή κάνοντας [Εκκίνηση σε
    κατάσταση UEFI](../bios-uefi-boot/) (live USB stick), μπορείτε να
    δείτε/αλλάξετε το UEFI boot order. Σε
    [τερματικό](../../glossary/index.md#terminal):

    !!! tip ""
        Αν χρησιμοποιήσετε το live USB stick ίσως να χρειαστεί να κάνετε
        εγκατάσταση το `efibootmgr` με την εντολή: `sudo apt update; sudo apt
        install efibootmgr`.

    ```shell-session
    $ sudo efibootmgr
	BootCurrent: 0002
	Timeout: 1 seconds
	BootOrder: 0002,0000,0004,0007,0008
	Boot0000* ubuntu
	Boot0002* Windows Boot Manager
	Boot0004* Network Card
	Boot0007* CD/DVD Drive
	Boot0008* Hard Drive
    ```

    Στο προηγούμενο παράδειγμα, προεπιλεγμένη καταχώρηση είναι ο `0002`, που
    αντιστοιχεί στον `Windows Boot Manager`. Από
    [τερματικό](../../glossary/index.md#terminal), αλλάξτε τη σειρά ώστε στο επόμενο boot,
    `BootCurrent` να είναι ο `Boot0000* ubuntu`:

    ```shell
    sudo efibootmgr -o 0000,0002,0004,0007,0008
    ```

### Επιδιόρθωση GRUB {#uefi-grub-repair}

Σε κάθε περίπτωση που θέλετε να επιδιορθώσετε/επανεγκαταστήσετε τον GRUB (UEFI
mode), θα πρέπει να κάνετε τα εξής:

1.  [Εκκίνηση σε κατάσταση UEFI](../bios-uefi-boot/) (live USB stick).

2.  Αναγνώριση των partition numbers, Ubuntu και EFI. Από
    [τερματικό](../../glossary/index.md#terminal):

    ```shell
    lsblk --fs
    ```

    -   Για το **Ubuntu partition number**, συνήθως στη στήλη `FSTYPE` υπάρχει
        χαρακτηρισμός `ext4`.
    -   Για το **EFI partition number**, στη στήλη `FSTYPE` υπάρχει
        χαρακτηρισμός `vfat`. Επίσης μπορείτε να το επιβεβαιώσετε με την εντολή
        `blkid`, από τη γραμμή που αναφέρει: `PARTLABEL="EFI System
        Partition"`.

3.  Από το αποτέλεσμα του προηγούμενου βήματος, έχετε αναγνωρίσει που είναι
    εγκατεστημένο το Ubuntu και που το EFI. Όποτε από
    [τερματικό](../../glossary/index.md#terminal):

    !!! warning ""
        Στις επόμενες εντολές όπου `sdx2` (Ubuntu), `sdx1` (EFI) και `sdx`,
        αντικαταστήστε με τα σωστά.

    ```shell
    sudo -i
	mount /dev/sdx2 /mnt
    mount /dev/sdx1 /mnt/boot/efi/
	for d in proc sys run dev dev/pts; do mount --bind /$d /mnt/$d; done
	chroot /mnt
    grub-install /dev/sdx
    update-grub
	for d in dev/pts dev run sys proc; do umount /mnt/$d; done
	umount /mnt/boot/efi
    umount /mnt
	sync
	reboot
    ```
