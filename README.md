# OASA-telematics-playground
Playing around with the restful api of OASA telematics 

## Αποποίηση ευθύνης
Δεν έχω καμία σχέση με τον ΟΑΣΑ και δεν φέρω καμία ευθύνη για το πώς μπορούν να χρησιμοποιηθούν αυτά που περιγράφω εδώ.

## Ιδέα
Η ιδέα της «παιδικής χαράς» προήλθε αφότου ανακάλυψα την [επίσημη ιστοσελίδα τηλεματικής του ΟΑΣΑ](http://telematics.oasa.gr) και κοιτώντας τον κώδικα της ιστοσελίδας βρήκα το [σκριπτάκι σε javascript](http://telematics.oasa.gr/js/script.js) το οποίο χρησιμοποιείται για την ανάκτηση των δεδομένων από τη σχετική βάση. Στην πορεία βρήκα την καταπληκτική δουλειά του [gph03n1x](https://github.com/gph03n1x), το [OASA Telematics API Documentation](https://github.com/gph03n1x/OASA-Telematics-API-Documentation), όπου είναι συγκεντρωμένα σχεδόν όλα τα request του API.

### Bash
Η «συνομιλία» με το API γίνεται μέσω **BASH**, συνεπώς ιδανικά μπορείτε να τρέχετε κάποια διανομή **GNU/Linux**, αν και απ'όσο ξέρω τώρα πια και η Microsoft υποστηρίζει τη συγκεκριμένη γλώσσα (χωρίς τη χρήση του cygwin απαραιτήτως).

## Κατέβασμα των *ενδιαφέροντων* δεδομένων
### Προαπαιτούμενα
Απαραίτητα είναι τα προγράμματα **curl**, για το κατέβασμα των αρχείων json, και **jq** για την ανάγνωσή τους.

