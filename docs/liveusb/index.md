# Live USB

Αν και τα περισσότερα λειτουργικά συστήματα διατίθεται σε μορφή .iso,
συνηθίζεται πλέον να γράφονται σε USB sticks, για λόγους ταχύτητας και ευκολίας
αλλά και επειδή πολλοί υπολογιστές δεν έχουν πια μονάδα CDROM.

Υπάρχουν πολλά προγράμματα που μπορούν να δημιουργήσουν live USB sticks
από ένα .iso image. Ακολουθήστε τις οδηγίες των σελίδων τους για να τα
δημιουργήσετε.

## Ventoy

Το [ventoy](https://ventoy.net) είναι μία από τις καλύτερες επιλογές και
υποστηρίζει Windows και Linux. Έχει το πλεονέκτημα ότι αφού δημιουργήσετε ένα
USB stick, στη συνέχεια μπορείτε να προσθέτετε ή να αφαιρείτε .iso αρχεία
τοποθετώντας τα σε έναν υποφάκελο, χωρίς να χρειαστεί να ξαναφορμάρετε το
stick.

## Windows

Τα παρακάτω λογισμικά εκτελούνται σε Windows και μπορούν να δημιουργήσουν
live USB sticks για οποιοδήποτε λειτουργικό:

- [Rufus](https://rufus.ie/) ([σχετικό tutorial για
  ubuntu.iso](https://ubuntu.com/tutorials/tutorial-create-a-usb-stick-on-windows))
- [Easy2boot](https://www.easy2boot.com/)

## Ubuntu

Τα παρακάτω λογισμικά εκτελούνται σε Linux και μπορούν να δημιουργήσουν live
USB sticks για οποιοδήποτε λειτουργικό:

- [Startup disk
  creator](https://ubuntu.com/tutorials/tutorial-create-a-usb-stick-on-ubuntu)
- [Unetbootin](https://fossbytes.com/create-bootable-usb-media-from-iso-ubuntu/)
-  [dd](https://fossbytes.com/create-bootable-usb-media-from-iso-ubuntu/)

## LiveUSB

Το <https://github.com/alkisg/liveusb> προηγήθηκε του ventoy και υποστηρίζει κι
αυτό προσθήκη .iso με αντιγραφή/επικόλληση. Όμως δεν έχει γραφικό interface και
δεν προτείνεται η χρήση του παρά μόνο σε λίγες περιπτώσεις που οι άλλες μέθοδοι
δεν δουλεύουν, για παράδειγμα εάν θέλουμε να ξεκινήσουμε το
[ubuntu-mate-18.04.5-desktop-i386.iso](https://cdimage.ubuntu.com/ubuntu-mate/releases/18.04/release/ubuntu-mate-18.04.5-desktop-i386.iso)
σε υπολογιστή με UEFI.
