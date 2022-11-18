## Αναφορά Πρώτου Εργαστηρίου
### Αρχιτεκτονική Υπολογιστών

Σε αυτό το εργαστήριο γίνεται μία εισαγωγή στο πρόγραμμα **gem5**. Αρχικά, για τα ερωτήματα 1 και 2, γίνεται προσομοίωση του _Hello World_ σε _ARM_ επεξεργαστή με χρήση configuration file **starter_se.py**. Για το ερώτημα 3, υλοποιήθηκε ένα πρόγραμμα πρόσθεσης πινάκων και χρησιμοποιήθηκε για προσομοίωση στα μοντέλα *MinorCPU* και *TimingSimple CPU*. Για την περιγραφή των διάφορων μοντέλων του **gem5** οι πληροφορίες είναι από το [gem5.org](https://www.gem5.org).


1. Το σύστημα προς εξομοίωση έχει **cpu="minor"**, ενώ έχει διατηρήσει τις default παραμέτρους για όλα τα υπόλοιπα χαρακτηριστικά. Συγκεκριμένα:
    * Tο μοντέλο _minor_ περιέχει την **L1 cache**, που χωρίζεται σε **data (d-cache)** και **instruction (i-cache)** και είναι ξεχωριστή για κάθε πυρήνα, ενώ  υπάρχει  μια κοινή **L2 cache**, καθώς και μια **WalkCache** που χρησιμοποιείται για την μείωση των TLB misses. Οι caches έχουν line-size 64.  
    * Οι default παράμετροι είναι _**1** πυρήνας_ με _**1 Ghz** συχνότητα ρολογιού_, _μνήμη **DDR3_1600_8x8**_ με _μέγεθος **2GB**_ και _**2** κανάλια (mem-channels)_.


2.  1.  Τα παραπάνω επιβεβαιώνονται και από τα αρχεία **config.ini** και **config.json**. Πράγματι:  
        * Στο πεδίο **system.cpu_cluster.clk_domain** παίρνουμε τη συχνότητα από το **clock = 1000** (ticks) και αφού τα ticks αντιστοιχούν σε ps, η συχνότητα του ρολογιού είναι **1GHz**.
        * Στο πεδίο **system.cpu_cluster.cpus** βλέπουμε το **type=MinorCPU** και το **children=...** που επιβεβαιώνει από ποια κομμάτια αποτελείται ο επεξεργαστής.
        * Από τα πεδία **system.cpu_cluster.cpus.dcache**, **system.cpu_cluster.cpus.icache** και **system.cpu_cluster.l2** λαμβάνονται επιπλέον δεδομένα για το configuration των caches. Έτσι: 
            * η **instruction cache** έχει _associativity = 3_, _size = 49152 bytes_ και _write buffers = 8_ ενώ έχει _data latency = tag latency = 1_.
            * η **data cache** έχει _associativity = 2_, _size = 32768 bytes_ και _write buffers = 8_ ενώ έχει _data latency = tag latency = 2_. 
            * η **L2 cache** έχει _associativity = 16_, _size = 1048576 bytes_ και _write buffers = 16_ ενώ έχει _data latency = tag latency = 12_.
    2. Τα **sim_seconds** είναι τα δευτερόλεπτα που διήρκησε το πρόγραμμα _Hello World_ που προσομοιώνεται. Τα **sim_insts** είναι ο αριθμός των εντολών του προγράμματος που προσομοιώνεται από το _gem5_ και το **host_inst_rate** είναι ο αριθμός των εντολών που τρέχει το _gem5_ για την προσομοίωση ανά δευτερόλεπτο.
    3.  Το συνολικό νούμερο των _commited_ εντολών είναι **5027** (σύμφωνα με το πεδίο **system.cpu_cluster.cpus.committedInsts** του **stats.txt**).
    4. Από το **stats.txt** μπορούμε να δούμε τις προσπελάσεις στην μνήμη. Έτσι, η _L2 cache_ προσπελάστηκε συνολικά **474** φορές (**system.cpu_cluster.l2.overall_accesses::total**). Από αυτές, οι **327** (**system.cpu_cluster.l2.overall_accesses::.cpu_cluster.cpus.inst**) ήταν για _instructions_ και οι **147** (**system.cpu_cluster.l2.overall_accesses::.cpu_cluster.cpus.data**) για _data_.
     * Αν αυτό το στατιστικό δεν παρέχοταν στα αποτελέσματα, θα μπορούσαμε να το υπολογίσουμε από τα στατιστικά για την _L1 dcache_ και _icache_. Αυτό θα μπορούσε να γίνει, καθώς γνωρίζουμε ότι η _L2_ προσπελαύνεται μόνο όταν υπάρχει _miss_ στην _L1_. Όμως, θα πρέπει να λάβουμε υπόψιν και τους καταχωρητές _mshrs_ της _L1_, επειδή, αφού γίνει ένα _miss_, ελέγχεται εαν η εντολή/δεδομένο που ζητήθηκε περιέχεται σε αυτούς και μόνο στην περίπτωση που έχουμε και "δεύτερο miss" στην αναζήτηση αυτή θα προσπελαστεί η _L2_.  
     * Κοιτώντας λοιπόν τα πεδία **system.cpu_cluster.cpus.dcache.overall_mshr_misses::total** και **system.cpu_cluster.cpus.icache.overall_mshr_misses::total**, αυτά έχουν τις τιμές **147** και **327** αντίστοιχα, ίδιες με τις προσπελάσεις της _L2_ για _data_ και _instructions_ και ίδιες αθροιστικά με τις συνολικές.


 Oι τύποι των in order επεξεργαστών του _gem5_ συνοπτικά είναι:
* [Μinor CPU](https://www.gem5.org/documentation/general_docs/cpu_models/minor_cpu):
Είναι ένα in-order μοντέλο επεξεργαστή, με fixed pipeline, από το οποίο μπορεί να βρεθεί η θέση μιας εντολής στο pipeline κάθε χρονική στιγμή, ενώ δεν υποστηρίζει και multithreading. To pipeline του έχει την παρακάτω δομή: Fetch1-Fetch2-Decode-Execute με buffers μεταξύ των μερών Fetch1->Fetch2->Decode->Execute και στην αντίστροφη κατεύθυνση μεταξύ των Fetch1->Fetch2 (χρησιμοποιείται για την τροφοδότηση των αποτελεσμάτων του branch prediction). Ακόμη υπάρχει interface για την επικοινωνία ενός stage του pipeline με ένα προηγούμενου (input buffer slot reservation, and input buffer occupancy).
  Η Fetch1 χρησιμοποιείται για fetching cache lines από την instruction cache τις οποίες στην συνέχεια στέλνει μέσω του FIFO buffer στην Fetch2, όπου γίνεται decomposition τους σε instructions και το branch prediction, πριν γίνει το decode στο επόμενο στάδιο (Decode). Όπως είναι φανερό, η σειρά των cache lines του instruction fetch εξαρτάται από την ροή του προγράμματος, οπότε μπορεί να αλλάζει, με "change of stream" indications από τα pipeline stages Execute και Fetch2. Συγκεκριμένα, η Fetch2 ενημερώνει την Fetch1 για το branch prediction, για να ακολουθηθεί η κατάλληλη ροή του προγράμματος. H πρόσβαση στην μνήμη και το instruction execution, γίνονται στο Execute stage, το οποίο μπορεί να διαρκεί πολλούς κύκλους. Αν το prediction στο Execute Stage δεν είναι σωστό με προώθηση κατάλληλης εντολής προς το Fetch1, αλλάζει η ροή των cache lines, και προς το Fetch2 ανανεώνεται ο branch predictor.
* [Simple CPU](https://www.gem5.org/documentation/general_docs/cpu_models/SimpleCPU):
 Είναι ένα απλούστερο in order μοντέλο που χρησιμοποιείται για περιπτώσεις όπου δεν απαιτείται ένα περίπλοκο μοντέλο, όπως για όταν απλά θέλουμε να ελέγξουμε αν ένα πρόγραμμα τρέχει σε μία αρχιτεκτονική και δεν υποστηρίζει pipeline εντολών. Χωρίζεται σε τρεις κλάσεις:  
  * [BaseSimple CPU](https://www.gem5.org/documentation/general_docs/cpu_models/SimpleCPU#basesimplecpu):
      Είναι μία γενικότερη κλάση και οι επόμενες κληρονομούν τα χαρακτηριστικά της. Μερικά από αυτά είναι ότι κρατάει το _archtected state_ του process, ορίζει συναρτήσεις για το instruction fetching, για την αύξηση του PC και handlers για interrupts. Δεν μπορεί να χρησιμοποιηθεί μόνη της, αλλά μόνο με κάποια από τις δύο παρακάτω.
  * [AtomicSimple CPU](https://www.gem5.org/documentation/general_docs/cpu_models/SimpleCPU#atomicsimplecpu):
Κληρονομεί από την BaseSimple. Χρησιμοποιεί atomic memory accesses, δηλαδή προσεγγίζει το memory access time κάνοντας υπολογισμούς με τις παραμέτρους για το latency. Επιπλέον, έχει συναρτήσεις για να διαβάζει και να γράφει στη μνήμη αλλά και για να γνωρίζει τι γίνεται σε κάθε κύκλο. Συνδέει την CPU με την cache.      
  * [TimingSimpleCPU](https://www.gem5.org/documentation/general_docs/cpu_models/SimpleCPU#timingsimplecpu):
Και αυτή κληρονομεί από την BaseSimple και υλοποιεί τις ίδιες συναρτήσεις με την AtomicSimple. Η διαφορά είναι ότι κάνει timing memory accesses, δηλαδή περιμένει το αποτέλεσμα της cache και δίνει μια πιο ρεαλιστική προσέγγιση του memory access time.
3. 1.


H TimingSimpleCPU ήταν πιο αργή σαν gem5 πρόγραμμα, καθώς η simulated CPU δεν έχει pipeline και για αυτό κάνει stall σε κάθε memory access (στους πίνακες υπάρχουν εκατοντάδες memory accesses) περιμένοντας το αποτέλεσμα, ενώ για τον ίδιο λόγο απαιτείται η προσομοίωση λιγότερων παραγόντων, άρα η προσομοίωση είχε μικρότερη χρονική διάρκεια.
