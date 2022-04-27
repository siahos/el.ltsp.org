# GRUB

Όταν θέλετε να έχετε Η/Υ dual boot (Ubuntu/Windows), η σωστή σειρά εγκατάστασης
είναι **πρώτα τα Windows** και **τελευταία τα Ubuntu**, έτσι ώστε να
εγκατασταθεί/ενημερωθεί σωστά ο GRUB, με όλα τα διαθέσιμα λειτουργικά
συστήματα.

!!! warning "Προσοχή"
    Στις επόμενες ενότητες θα σας ζητηθεί να κάνετε boot με live USB stick. Για
    την επιδιορθωση του GRUB **δεν είναι απαραίτητο** να είστε στο ίδιο mode
    (BIOS/UEFI) με το εγκατεστημένο Λ.Σ. Επειδή όμως μπορεί να χρειαστεί να
    καλέσετε συναρτήσεις UEFI (π.χ. `sudo efibootmgr`) καλό είναι το live USB
    stick να είναι στο ίδιο mode με το εγκατεστημένο Λ.Σ.

## BIOS (Legacy UEFI)

### Επιδιόρθωση GRUB {:#bios-grub-repair}

Αν έχετε εγκαταστήσει **πρώτα Ubuntu σε BIOS mode** και στη συνέχεια προσθέσετε
σε διαφορετικό partition και Windows (BIOS mode), τότε το πιο πιθανό είναι **τα
Windows να επικαλύψουν (override) τον GRUB** με τον αντίστοιχο δικό τους, με
συνέπεια να κάνετε **boot πάντα σε Windows**.

Για να επιδιορθωθεί αυτό το πρόβλημα, αλλά και σε κάθε περίπτωση που θέλετε να
επιδιορθώσετε/επανεγκαταστήσετε τον GRUB (BIOS mode), θα πρέπει να κάνετε τα
εξής:

1.  [Εκκίνηση σε κατάσταση BIOS](../bios-uefi-boot/) (live USB stick).

2.  Αναγνώριση του σωστού partition number που είναι εγκατεστημένο το Ubuntu.
    Από [τερματικό](../../glossary/#terminal):

    ```shell
    lsblk --fs
    ```

    !!! tip ""
        Συνήθως στη στήλη `FSTYPE` υπάρχει χαρακτηρισμός `ext4` και στη στήλη
        `LABEL` το λεκτικό `Ubuntu`.

3.  Από το αποτέλεσμα του προηγούμενου βήματος έχετε αναγνωρίσει που είναι
    εγκατεστημένο το Ubuntu. Όποτε από
    [τερματικό](../../glossary/#terminal):

    !!! warning ""
        Οι επόμενες εντολές θεωρούν δεδομένο ότι το Ubuntu ειναι εγκατεστημένο
        στο **sda1**.

    ```shell
    sudo -i
	mount /dev/sda1 /mnt
	for d in proc sys run dev dev/pts; do mount --bind /$d /mnt/$d; done
	chroot /mnt
    grub-install /dev/sda
    update-grub
	for d in dev/pts dev run sys proc; do umount /mnt/$d; done
	umount /mnt
	sync
	reboot
    ```

## UEFI

### Προεπιλεγμένος boot loader {:#uefi-current-boot-loader}

Αν έχετε εγκαταστήσει **πρώτα Ubuntu σε UEFI mode** και στη συνέχεια προσθέσετε
σε διαφορετικό partition και Windows (UEFI mode), τότε το πιο πιθανό είναι **τα
Windows να αλλάξουν τον προεπιλεγμένο boot loader** **`ubuntu`** με τον
αντίστοιχο δικό τους **`Windows Boot Manager`**, με συνέπεια να κάνετε **boot
πάντα σε Windows**.

Αρχικά για να επιδιορθωθεί αυτό το πρόβλημα, θα πρέπει να αλλάξετε το
προεπιλεγμένο boot loader. ώστε να είναι το **`ubuntu`**. Αυτό μπορεί να γίνει
με δύο τρόπους:

1.  Ορίζοντας από τις ρυθμίσεις του UEFI, 1ο boot loader το **`ubuntu`** . Για
    να έχετε πρόσβαση στις σχετικές επιλογές μπορείτε να δοκιμάστε τα πλήκτρα
    που περιγράφονται στο [Εκκίνηση σε κατάσταση BIOS ή
    UEFI](../bios-uefi-boot/).

2.  Από το περιβάλλον του **εγκατεστημένου** Ubuntu ή κάνοντας [Εκκίνηση σε
    κατάσταση UEFI](../bios-uefi-boot/) (live USB stick), μπορείτε να
    δείτε/αλλάξετε τα UEFI settings. Σε [τερματικό](../../glossary/#terminal):

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

    Στο προηγούμενο παράδειγμα προεπιλεγμένος είναι ο `0002` που αντιστοιχεί στον `Windows Boot Manager`. Από [τερματικό](../../glossary/#terminal) αλλάζετε τη σειρά ώστε στο επόμενο boot `BootCurrent` να είναι ο `Boot0000* ubuntu`:

    ```shell
    sudo efibootmgr -o 0000,0002,0004,0007,0008
    ```

### Επιδιόρθωση GRUB {:#uefi-grub-repair}

Σε κάθε περίπτωση που θέλετε να επιδιορθώσετε/επανεγκαταστήσετε τον GRUB (UEFI
mode), θα πρέπει να κάνετε τα εξής:

1.  [Εκκίνηση σε κατάσταση UEFI](../bios-uefi-boot/) (live USB stick).

2.  Αναγνώριση των σωστών partition number (Ubuntu/EFI). Από [τερματικό](../../glossary/#terminal):

    ```shell
    lsblk --fs
    ```

    -   Για το **Ubuntu partition number**, συνήθως στη στήλη `FSTYPE` υπάρχει
        χαρακτηρισμός `ext4` και στη στήλη `LABEL` το λεκτικό `Ubuntu`.
    -   Για το **EFI partition number**, στη στήλη `FSTYPE` υπάρχει
        χαρακτηρισμός `vfat`. Επίσης μπορείτε να το επιβεβαιώσετε με την εντολή
        `blkid`, από τη γραμμή που αναφέρει: `PARTLABEL="EFI System
        Partition"`.

3.  Από το αποτέλεσμα του προηγούμενου βήματος έχετε αναγνωρίσει που είναι
    εγκατεστημένο το Ubuntu και που το EFI. Όποτε από
    [τερματικό](../../glossary/#terminal):

    !!! warning ""
        Οι επόμενες εντολές θεωρούν δεδομένο ότι το **Ubuntu** είναι
        εγκατεστημένο στο **sda2** και το **EFI**  στο **sda1**.

    ```shell
    sudo -i
	mount /dev/sda2 /mnt
    mount /dev/sda1 /mnt/boot/efi/
	for d in proc sys run dev dev/pts; do mount --bind /$d /mnt/$d; done
	chroot /mnt
    grub-install /dev/sda
    update-grub
	for d in dev/pts dev run sys proc; do umount /mnt/$d; done
	umount /mnt/boot/efi
    umount /mnt
	sync
	reboot
    ```
