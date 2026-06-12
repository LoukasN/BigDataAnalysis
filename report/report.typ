#set text(font: "Times New Roman")
#align(center)[
  #image("images/Pada_logo.png", width: 30%)

  #align(top)[
    #set text(size: 18pt, weight: "bold")
    Πανεπιστήμιο Δυτικής Αττικής\
    Τμήμα μηχανικών πληροφορικής και υπολογιστών
  ]

  #align(horizon)[
    #set text(size: 26pt, weight: "bold")
    Διαχείριση Δεδομένων Μεγάλης Κλίμακας
  ]

  #align(bottom)[
    #set text(size: 16pt)
    Νικολάου Λουκάς (22390158)\
    Κατεχάκης Γεώργιος (22390087) \
    Χότζα Σέρτζιο (22390301)\
    Γιακουμής Κωνσταντίνος (21390035)
  ]

  #align(bottom)[
    #show link: underline
    #show link: set text(fill: blue)
    #set text(size: 14pt)
    #link(
      "https://github.com/LoukasN/BigDataAnalysis.git",
    )[Github Link]
  ]
]

#pagebreak()

#set text(size: 18pt)
#set page(numbering: "1")
#outline(title: "Περιεχόμενα")

#pagebreak()

#show heading.where(level: 1): set text(size: 20pt)
#show heading.where(level: 2): set text(size: 18pt)
#show heading.where(level: 3): set text(size: 16pt)
#show heading.where(level: 4): set text(size: 16pt)

#set text(size: 14pt)
= Dataset

== Περιγραφή dataset
#par[
  Χρησιμοποιήσαμε το MovieLens Dataset με 20 εκατομμύρια  data entries.
  Το dataset χωρίζεται σε 6 αρχεία csv με την στήλη movieId και userId
  να μοιράζονται μέσα στους πίνακες. Τα αρχεία που  έχουν ένα movieId
  ξεκινάνε από το 1 και ανεβαίνουν με μη σταθερό ρυθμό, αρχίζοντας να
  αυξάνονται κατά 1 και στην συνέχεια αυξάνονται κατά τυχαίο αριθμό.
]

+ *movie* #par[
    Υπάρχουν τίτλοι (title) ταινιών ξεκινώντας από το 1891 μέχρι το 2015.
    Το κάθε entry έχει και το είδος ή είδη (genres) όπως Drama, Comedy, etc
    με 246 να έχουν (no genres listed) για είδος (genres).
  ]
  #align(center)[
    #image("images/moviesTable.png", width: 100%)
  ]

+ *tag* #par[
    Περιέχει τα userId των χρηστών που έδωσαν tags στις ταινίες. Τα tag
    για κάθε movieId και τα timestamps που δείχνει πότε δόθηκε το tag από ένα
    συγκεκριμένο userId.
  ]
  #align(center)[
    #image("images/tagsTable.png", width: 100%)
  ]

+ *rating* #par[
    Περιέχει movieIds μαζί με τους χρήστες (userId), τις αξιολογήσεις (rating)
    που έδωσαν και τα timestamps. Μια ταινία (MovieId) μπορεί να έχει πολλές
    αξιολογήσεις (rating) από πολλούς διαφορετικούς χρήστες (userId).
  ]
  #align(center)[
    #image("images/ratingsTable.png", width: 70%)
  ] \ \

+ *link* #par[
    Το link συνδυάζει τα movieId με τα imdbid και τα tmdbid, άρα συνδέει τα
    identifiers των ταινιών με τα αντίστοιχα id των εξωτερικών πηγών imdb και tmdb.
  ]
  #align(center)[
    #image("images/linkTables.png", width: 50%)
  ]

+ *genome_tags* #par[
    Τα genome_tags περιέχουν την περιγραφή (tag) του κάθε tag (tagId).
  ]
  #align(center)[
    #image("images/genome_tagTable.png", width: 30%)
  ]

+ *genome_scores* #par[
    Τα genome_scores περιέχουν το relevance του κάθε tag (tagId) με την κάθε
    ταινία (movidId). Το relevance είναι από 0 μέχρι 1.
  ]
  #align(center)[
    #image("images/genome_scoreTable.png", width: 50%)
  ] \

#pagebreak()

- Οι σχέσεις μεταξύ των πινάκων φαίνονται στην παρακάτω εικόνα \

#align(center)[
  #image("images/tablesER.png", width: 100%)
]

#pagebreak()

== Cleaning

#par[
  Στην αρχή για τα αρχεία movie και rating εντοπίσαμε 16 διπλές ταινίες και
  αφαιρέσαμε την δεύτερη εμφάνιση, ενώνοντας τα genres, αν διέφεραν. Στην
  συνέχεια, στο rating αντικαταστήσαμε τα διπλότυπα movieId με αυτά που
  κρατήσαμε στο προηγούμενο βήμα. Ενώσαμε movie και rating, κάνοντας
  αντιστοίχηση κάθε ταινία με το rating του κάθε χρήστη, έχοντας αποτέλεσμα να
  μην επιλεχθούν ταινίες που δεν είχαν αντιστοίχηση με κανένα rating. Επιπλέον,
  αφαιρέσαμε ταινίες που δεν έχουν έτος κυκλοφορίας.
]

== Feature engineering

#par[
  Με το feature engineering χρησιμοποιήσαμε το dataset για να βρούμε καινούργιες
  σχέσεις μεταξύ των δεδομένων.
]

#par[
  Φτιάξαμε ένα python script που υπολογίζει το μέσο rating κάθε ταινίας
  (avg_movie_rating), πόσα rating είχε κάθε ταινία (rating_count), πόσο κοντά
  ήταν τα ratings μεταξύ τους (rating_std), το έτος κυκλοφορίας (release_year) και
  πόσα είδη έχει (genre_count). Άρα καταλήξαμε σε αυτόν τον πίνακα:
]

#align(center)[
  #image("images/feature_tables.png", width: 100%)
]

#par[
  Τέλος, με βάση τα διαφορετικά είδη που υπάρχουν για τις ταινίες φτιάξαμε τον
  τελικό πίνακα που για κάθε είδος ταινίας δίνει τιμή 0 ή 1 στην αντίστοιχη
  στήλη του είδους.
]

#align(center)[
  #image("images/final_datatable.png", width: 100%)
]

=== Παρατηρήσεις
- #par[
    Τα βήματα του Cleaning και του Feature engineering έγιναν παράλληλα καθώς
    με την δημιουργία καινούργιων feature βρίσκαμε πως κάποιες εγγραφές ήταν
    ελλιπείς.
  ]

- #par[
    Αγνοήσαμε τα timestamps καθώς δεν είχαν κάποια χρήση στα στατιστικά μας
    δεδομένα. Επιπλέον αφαιρέσαμε τα userId καθώς είχε υπολογιστή ένα μέσο
    rating για κάθε ταινία από όλους τους users που είχαν κάνει rate την ταινία.
  ]

== Τελικό Dataset

Ξεκινήσαμε με ένα movie.csv που είχε 27.278 ταινίες και το rating.csv 20.000.263
ratings. Καταλήξαμε με ένα αρχείο (Processed_Movies.tab) που έχει μόνο 26.691
εγγραφές. Παρακάτω θα χρησιμοποιηθούν δεδομένα μόνο από το αυτό το αρχείο.

= Διερευνητική ανάλυση δεδομένων

== Στατιστικά & Visualization

Τα διαγράμματα που ακολουθούν είναι μια αναπαράσταση των στατιστικών δεδομένων
του dataset.

#align(center)[
  #image("images/scatterRatingPerYear.png", width: 120%)
]

#list[
  Το παραπάνω διάγραμμα scatterplot δείχνει την μέση αξιολόγηση κάθε ταινίας προς
  τον χρόνο που κυκλοφόρησε. Για κάθε δεκαετία μετά το 1950 δίνετε διαφορετικό
  χρώμα.
]

#pagebreak()

#align(center)[
  #image("images/avgMovieRatingGraph.png", width: 100%)
]

#list[
  Εδώ φαίνεται το πλήθος των αξιολογήσεων που έχουν δοθεί.
]

#align(center)[
  #image("images/moviesPerGenreBar.png", width: 120%)
]

#list[
  Σε αυτό το διάγραμμα φαίνεται το πλήθος των ταινιών που ανήκουν σε κάθε είδος.
]

#align(center)[
  #image("images/avgRatingPerGenre.png", width: 120%)
]

#list[
  Το παραπάνω διάγραμμα δείχνει την μέση αξιολόγηση των ταινιών που ανήκουν σε
  κάθε είδος.
]

= Εφαρμογή Αλγορίθμων

#par[
  Για Classification Models χρησιμοποιήθηκε το Decision Tree και το Neural
  Network. Για Advanced Technique χρησιμοποιήθηκε το Association Rules.
]

== Classification Models

=== Decision Tree

#let ratingLow = $0 <= "avg_movie_rating" < 3$
#let ratingMid = $3 <= "avg_movie_rating" < 4$
#let ratingHigh = $4 <="avg_movie_rating" <= 5$

#par[
  Για το Decision Tree χρειάστηκε να διαχωρίσουμε τις ταινίες με βάση την μέση
  αξιολόγηση τους. Οι ταινίες χαρακτηρίστηκαν :\
  'Low' για #ratingLow, \
  'Medium' για #ratingMid, \
  'High' για #ratingHigh.\
  Επομένως προσθέσαμε στον πίνακα την νέα στήλη rating_class. Στην συνέχεια
  χρησιμοποιήσαμε το rating_class ως target του Decision Tree και κρύψαμε την
  μέση αξιολόγηση κάθε ταινίας. Επομένως, δημιουργήθηκε ένα Decision Tree που
  προσπαθεί να προβλέψει αν μια ταινία θα χαρακτηρίζεται ως Low, Medium ή High,
  μόνο από τα genres, rating_count, genre_count, release_year και rating_std.
]

#align(center)[
  #image("images/decisionTree.png", width: 100%)
]

#par[
  Στην εικόνα φαίνεται ένα κομμάτι του δέντρου. Κάθε φύλλο αντιστοιχεί στην
  κατηγορία στην οποία κατατάσσεται μια ταινία με βάση τα κριτήρια στο οποία
  περνάει στα πιο πάνω επίπεδα. Το ποσοστό σε κάθε φύλλο δίνει εμπιστοσύνη της
  πρόβλεψης για αυτή την κατηγοριοποίηση. Αν το χρώμα είναι κόκκινο χαρακτηρίζεται
  Low, πράσινο αν είναι Medium και μπλε αν είναι High. Όσο πιο σίγουρο για την
  πρόβλεψη της κατηγοριοποίησης, τόσο πιο έντονο το χρώμα του φύλλου.
]

=== Neural Network

#par[
  Το Νευρωνικό δίκτυο είναι ένα μαύρο κουτί. Δώσαμε rating_count, rating_std, genre_count, τα
  genres και το release_year. Ως στόχο έχει να υπολογίσει το rating_class όπως και
  το δέντρο παραπάνω. Έτσι, δημιουργήθηκε ένα νευρωνικό δίκτυο, με 100 κρυφούς
  νευρώνες, activation ReLU και ο αλγόριθμος βελτιστοποίησης Adam, με μέγιστο
  αριθμό επαναλήψεων τους 200.
]

== Advanced Technique

=== Association Rules

#par[
  Η τεχνική του Association Rules υλοποιήθηκε με την χρήση της python βιβλιοθήκης
  Associate. Περάσαμε τα genres και τα rating_class από ένα python script που
  για κάθε είδος ταινίας που το περιέχει βάζει "yes" και για κάθε rating_class
  (Low/Medium/High) τους αντιστοιχεί μια διακριτή τιμή. Στην συνέχεια εντοπίσαμε
  τους πιο συχνούς συνδυασμούς ειδών που υπήρχαν μεταξύ των ταινιών, για να
  δημιουργήσουμε κανόνες. Δημιουργούνται κανόνες (association rules) μεταξύ των
  genres και εντοπίζει αυτά που έχουν περισσότερες κοινές ταινίες.
]

#align(center)[
  #grid(
    columns: (2fr, 2fr),
    column-gutter: 20pt,
    row-gutter: 4pt,
    image("images/AssociationItemsets.png", width: 80%), image("images/AssociationRules.png", width: 123%),
    text(style: "italic", size: 10pt)[Frequent Itemsets], text(style: "italic", size: 10pt)[Association Rules],
  )
]

#par[
  Το Frequent Itemsets εντοπίζει τους πιο συχνούς συνδυασμούς όλων των genres
  και των rating_class μεταξύ τους. Το Association Rules χρησιμοποιεί τα δεδομένα
  που βρίσκει το Frequent Itemsets και συνδυάζει τα genres και rating_class
  μεταξύ τους για να υπολογίσει το lift, το οποίο δείχνει πόσο πιο συχνά
  εμφανίζονται μαζί δύο στοιχεία σε σχέση με το αν ήταν εντελώς ανεξάρτητα
  μεταξύ τους. Αν το lift είναι 1, δεν υπάρχει σχέση μεταξύ των στοιχείων του itemset,
  αν είναι μικρότερο του 1 υπάρχει αρνητική συσχέτιση και αν είναι μεγαλύτερο του 1
  υπάρχει αυξημένη συσχέτιση.
]

==== Παρατηρήσεις

#par[
  Αρχικά θέλαμε να φτιάξουμε ένα recommendation system, αλλά λόγω του όγκου του
  Dataset ήταν δύσκολο να διαχειριστούμε όλα τα δεδομένα. Επομένως, επιλέξαμε να
  χρησιμοποιήσουμε Association Rules.
]

== Big Data Approach

=== Spark

#par[
  Το spark λειτουργεί μοιράζοντας τις εγγραφές του csv αρχείου σε itemsets,
  όπου επεξεργάζονται αυτόνομα από άλλους επεξεργαστές και στο τέλος δημιουργούν
  ένα ενιαίο αποτέλεσμα.
]

#par[
  Με την χρήση της βιβλιοθήκης pyspark καταφέραμε να καθαρίσουμε τον μεγάλο όγκο
  δεδομένων και τα φέραμε στα 26.744, που είναι 53 αρχεία περισσότερα από το
  δικό μας cleaning process. Άρα το αρχείο spark_movie_agg.csv έχει τα
  αποτελέσματα του script και θα μπορούσε να χρησιμοποιηθεί αντί για το
  Processed_Movies.tab.
]

#align(center)[
  #image("images/sparkOutput.png", width: 100%)
]

=== Παρατηρήσεις
- Το spark.py έτρεξε σε μηχάνημα linux και το αποτέλεσμα φαίνεται στην παραπάνω
  εικόνα.

= Model Evaluation

#par[
  Συγκρίναμε τις αποδόσεις των μοντέλων Decision Tree και Neural Network, με
  βάση τα Accuracy, Precision/Recall, Confusion Matrix και ROC Curve. Το
  Accuracy δείχνει τις σωστές κατηγοριοποίησης, το Precision μετράει την σχέση
  των σωστών προβλέψεων προς τις συνολικές προβλέψεις,
  το Recall πόσα κατηγοριοποίησε σωστά, στο Confusion Matrix
  φαίνονται οι διαφορές στην κατηγοριοποίηση που δόθηκε σε σχέση με την
  πραγματική και στο ROC Curve δείχνει την αναλογία μεταξύ των false positive
  και των true positive.
]

#align(center)[
  #image("images/evaluationsTreeNeural.png", width: 40%)
]

#list[
  Για το Decision Tree:
  Το Accuracy (CA) είναι 66.8%, το Precision (Prec) 64.8% και το Recall 66.8%.

]
#list[
  Για το Neural Network:
  Το Accuracy (CA) είναι 67.8%, το Precision (Prec) 65.8% και το Recall 67.8%.
]

- Τα Confusion Matrix:

#align(center)[
  #grid(
    columns: (2fr, 2fr),
    column-gutter: 10pt,
    image("images/confusionTree.png", width: 100%), image("images/confusionNeural.png", width: 106.2%),
    text(style: "italic")[Decision Tree], text(style: "italic")[Neural Network],
  )
]

#let toCyan(body) = text(fill: rgb("#2BFDBE"), body)
#let toOrange(body) = text(fill: rgb("#FFA45F"), body)

- Το ROC Curve για #toCyan[Decision Tree] και #toOrange[Neural Network]:

  #align(center)[
    #image("images/ROCComboLow.png", width: 85%)
    #text(style: "italic", size: 10pt)[Low]
    #image("images/ROCComboMedium.png", width: 85%)
    #text(style: "italic", size: 10pt)[Medium]
    #image("images/ROCComboHigh.png", width: 85%)
    #text(style: "italic", size: 10pt)[High]
  ]

= Σύγκριση Μοντέλων

#par[
  Τα μοντέλα Decision Tree και Neural Network, είχαν σχεδόν ίδια αποτελέσματα σε
  Accuracy, Precision και Recall, με το Neural Network να είναι 1% καλύτερο
  σταθερά. Το Confusion Matrix στο Decision Tree δείχνει ότι ήταν ελάχιστα
  χειρότερο στην κατηγοριοποίηση των High και Low, αλλά ελάχιστα καλύτερο στα
  Medium, συγκριτικά με το Neural Network. Αυτό φαίνεται και στο ROC Curve που
  δείχνει πως το Neural Network είναι πιο σταθερό, δηλαδή έχει πιο σταθερή αναλογία
  μεταξύ των false positive και true positive.
]

#par[
  Επομένως, τα μοντέλα είχαν κοντινή απόδοση για το dataset που δημιουργήσαμε,
  με το Neural Network να είναι ελάχιστα πιο αποδοτικό.
]

= Συμπεράσματα

Η ανάλυση του dataset μας έδωσε πληροφορίες για της ταινίες και βρήκε ενδιαφέροντα
στατιστικά στοιχεία με βάση τις αξιολογήσεις των χρηστών. Επιπλέον,
ανακαλύφθηκαν συνδέσεις μεταξύ των ειδών, των ταινιών και των αξιολογήσεων τους.

Τα δεδομένα που βρέθηκαν είναι χρήσιμα για την ένταξη τους σε ένα εξωτερικό
recommendation system (ειδικά το Association Rules) και προσφέρουν μια ενδιαφέρουσα
οπτική γωνία ως προς τις ταινίες των προηγούμενων δεκαετιών.

== Κατανομή ρόλων

- Νικολάου Λουκάς - Data Engineer
- Κατεχάκης Γεώργιος - Data Analyst
- Χότζα Σέρτζιο - ML Engineer
- Κωνσταντίνος Γιακουμής - ML Engineer
