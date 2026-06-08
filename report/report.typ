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
    Κωνσταντίνος Γιακουμής (21390035)
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

#show heading.where(level: 1): set text(size: 26pt)
#show heading.where(level: 2): set text(size: 22pt)

= Dataset

== Περιγραφή dataset
#set text(size: 16pt)
#par[
  Χρησιμοποιήσαμε το MovieLens Dataset με 20 data entries. Το dataset χωρίζεται
  σε 6 αρχεία csv με την στήλη movieId και userId να μοιράζονται μέσα στους
  πίνακες. Τα αρχεία που  έχουν ένα movieId ξεκινάνε από το 1 και
  ανεβαίνουν με μη σταθερό ρυθμό, αρχίζοντας να αυξάνονται κατά 1 και στην
  συνέχεια αυξάνονται κατά τυχαίο αριθμό.
]

+ *movie* #par[
    Υπάρχουν τίτλοι (title) ταινιών ξεκινώντας από το 1891 μέχρι το 2015.
    Το κάθε entry έχει και το είδος ή είδη (genres) όπως Drama, Comedy, etc
    με 246 να έχουν (no genres) για είδος (genres).
  ]
  #align(center)[
    #image("images/moviesTable.png", width: 110%)
  ]

+ *tag* #par[
    Περιέχει τα userId των ρηστών που έδωσαν tags στις ταινίες. Τα tag
    για κάθε movieId και τα timestamps που δείχνει πότε δόθηκε το tag από ένα
    συγκεκριμένο userId.
  ]
  #align(center)[
    #image("images/tagsTable.png", width: 110%)
  ] \

+ *rating* #par[
    Περιέχει movieIds μαζί με τους χρήστες (userId), τις αξιολογήσεις (rating)
    που έδωσαν και τα timestamps. Μια ταινία (MovieId) μπορεί να έχει πολλές
    αξιολογήσεις (rating) από πολλούς διαφορετικούς χρήστες (userId).
  ]
  #align(center)[
    #image("images/ratingsTable.png", width: 100%)
  ]

+ *link* #par[
    Το link συνδυάζει τα movieId με τα imdbid και τα tmdbid, άρα συνδέει τα
    identifiers των ταινιών με τα αντίστοιχα id των εξωτερικών πηγών imdb και tmdb.
  ]
  #align(center)[
    #image("images/linkTables.png", width: 70%)
  ]

+ *genome_tags* #par[
    Τα genome_tags περιέχουν την περιγραφή (tag) του κάθε tag (tagId).
  ]
  #align(center)[
    #image("images/genome_tagTable.png", width: 45%)
  ]

+ *genome_scores* #par[
    Τα genome_scores περιέχουν το relevance του κάθε tag (tagId) με την κάθε
    ταινία (movidId). Το relevance είναι από 0 μέχρι 1.
  ]
  #align(center)[
    #image("images/genome_scoreTable.png", width: 70%)
  ] \

- Οι σχέσεις μεταξύ των πινάκων φαίνονται στην παρακάτω εικόνα \

#align(center)[
  #image("images/tablesER.png", width: 110%)
]

#pagebreak()

== Cleaning

Πλήθος εγγραφών στο αρχικό dataset:
- movieId: 27.278
- userId: 138.493
- rating: 20.000.263
- tag: 38.642
- genre: 1.342

Πλήθος μοναδικών εγγραφών μετά από Processing:
- movieId: 27.262
- userId: 138.493
- rating: 20.000.263
- tag: 38.642
- genre: 1.342

#par[
  Στην αρχή για τα αρχεία movie και rating εντοπίσαμε 16 διπλές ταινίες και
  αφαιρέσαμε την δεύτερη εμφάνιση, ενώνοντας τα genres, αν διέφεραν. Στην
  συνέχεια, στο rating αντικαταστήσαμε τα διπλότυπα movieId με αυτά που
  κρατήσαμε στο προηγούμενο βήμα. Ενώσαμε movie και rating, κάνοντας
  αντιστοίχηση κάθε ταινία με το rating του κάθε χρήστη, έχοντας αποτέλεσμα να
  μην επιλεχθούν ταινίες που δεν είχαν αντιστοίχηση με κανένα rating.
  Έτσι, καταλήξαμε να έχουμε καθαρίσει τα δεδομένα και να είναι
  έτοιμα για feature engineering, όπου χρησιμοποιώντας το καθαρισμένο dataset,
  βρίσκουμε καινούργιες σχέσεις μεταξύ των δεδομένων.
]

== Feature engineering

#par[
  Φτιάξαμε ένα python script που υπολογίζει το μέσο rating κάθε ταινίας
  (avg_movie_rating), πόσα rating είχε κάθε ταινία (rating_count), πόσο κοντά
  ήταν τα ratings μεταξύ τους (rating_std) και το έτος κυκλοφορίας (release_year),
  πόσα είδη έχει (genre_count).
]

#align(center)[
  #image("images/feature_tables.png", width: 120%)
]

=== Παρατηρήσεις

#par[
]

= Διερευνητική ανάλυση δεδομένων

== Στατιστικά & Visualization

Η παρακάτω εικόνα δείχνει το συνολικό μέσο rating προς τον αριθμό των
συνολικών rating.

#align(center)[
  #image("images/avg_movie_rating.png", width: 120%)
]

Παρατηρούμε πως το 61% των ταινιών έχουν μέση αξιολόγηση από 3 μέχρι 4.
Επιπλέον υπάρχουν 7% ταινίες που έχουν μέση αξιολόγηση πάνω από 4 σε
σχέση με 13% που είναι κάτω από 2.5.
