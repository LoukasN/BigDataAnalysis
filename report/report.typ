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

#show heading.where(level: 1): set text(size: 26pt)

= Data Set

#set text(size: 16pt)
#par[
  Χρησιμοποιήσαμε το MovieLens Dataset με 20 data entries. Το dataset χωρίζεται
  σε 6 αρχεία csv με την στήλη movieId και userId να μοιράζονται μέσα στους
  πίνακες. Άρα όλα τα αρχεία έχουν ένα id (movieId) ξεκινώντας από το 1 και
  ανεβαίνουν με μη σταθερό ρυθμό, αρχίζοντας να αυξάνονται κατά 1 και στην
  συνέχεια αυξάνονται κατά τυχαίο αριθμό.
]

Στατιστικά:
- movieId: 27.278
- userId: 138.493
- rating: 20.000.263
- tag: 38.642
- genre: 1.342

+ *movie* #par[
    Υπάρχουν τίτλοι (title) ταινιών ξεκινώντας από το 1995 μέχρι το 2015.
    Το κάθε entry έχει και το είδος ή είδη (genres) όπως Drama, Comedy, etc
    με κάποιες να έχουν (no genre) για είδος.
  ]

+ *tag* #par[
    Περιέχει τα userId των ρηστών που έδωσαν tags στις ταινίες. Τα tag
    για κάθε movieId και τα timestamps που δείχνει πότε δόθηκε το tag από ένα
    συγκεκριμένο userId.
  ]

+ *rating* #par[
    Περιέχει movieIds μαζί με τους χρήστες (userid), τις αξιολογήσεις (rating)
    που έδωσαν και τα timestamps. Μια ταινία (MovieId) μπορεί να έχει πολλές
    αξιολογήσεις (rating) από πολλούς διαφορετικούς χρήστες (userid).
  ]

+ *link* #par[
    Το link συνδυάζει τα movieId με τα imdbid και τα tmdbid, άρα συνδέει τα
    identifiers των ταινιών με τα αντίστοιχα id των εξωτερικών πηγών imdb και tmdb.
  ]

+ *genome_tags* #par[
]

+ *genome_scores*
