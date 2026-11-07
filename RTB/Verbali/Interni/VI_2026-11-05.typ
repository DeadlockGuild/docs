#import "../template.typ": *

#show: verbale.with(
  titolo: "Verbale Incontro #5",
  data: "05/11/2026",
  versione: "1.0.0",
  uso: "Interno",
  redattore: "Nikola Miljanovic",
  verificatore: "Mattia Scomparin",
  destinatari: ("Prof. Tullio Vardanega", "Prof. Riccardo Cardin",),
  riassunto: "Considerazioni generali a seguito dell'aggiudicazione dell'appalto. Riflessioni sulle correzioni del professore in merito alla candidatura. Discussione sulla rotazione e assegnazione dei ruoli e frequenza degli incontri.",
  registro_modifiche: (
    ("1.0.0", "09/11/2026", "Nikola", "Mattia Scomparin", "Prima stesura"),
  ),
)

= Informazioni generali

== Luogo e data della riunione

- *Luogo*: Google Meet
- *Data*: 2026-11-05
- *Ora*: 18:30
- *Durata*: 1 ora e 30 minuti

== Partecipanti

- Godwin Agbleze
- Mattia Pasquato
- Giacomo Ravazzolo
- Nikola Miljanovic
- Mattia Scomparin
- Carlo Nardin

= Ordine del giorno

+ Modalità di miglioramento a seguito di valutazione della candidatura.
+ Discussione su assegnazione e rotazione dei ruoli.
+ Riflessioni sulla frequenza degli incontri.
+ Controllo board di progetto e avanzamento.
+ Nuovi documenti e loro struttura.
+ Analisi approfondita delle tecnologie e invio mail di conferma aggiudicazione a Miriade (C5).

= Discussione

== Valutazione del professore

Il gruppo ha discusso attivamente in merito alla valutazione e alle correzioni del prof. Vardanega relativamente alla candidatura presentata per il capitolato C5. La domanda è stata accolta con esito più che positivo con la conseguente aggiudicazione dell'appalto. La discussione si è soffermata in particolare sul commento del professore in merito alla struttura della tabella per il tracciamento delle azioni contenuta nei verbali, a questo proposito, il gruppo si è prefissato di provvedere ad un'analisi e ristrutturazione della stessa sulla base delle indicazioni fornite. La nuova struttura sarà adottata già dal presente verbale.

#fonte_decisione([D\_1], [Necessità di modificare la struttura della tabella per il tracciamento delle azioni.])

== Assegnazione e Rotazione dei Ruoli

In vista dell'effettivo inizio dei lavori, è stato necessario decidere la suddivisione iniziale dei ruoli; a questo proposito, il gruppo ha accolto il consiglio del professore in merito alla non-rigidità dei ruoli: qualora necessario, in base allo stato attuale del progetto e al grado di avanzamento, verrà di volta in volta valutata una possibile variazione delle ore di alcuni incarichi a favore di altri. In questa fase iniziale è stata concordata all'unanimità la necessità di un prevalente lavoro degli analisti e degli amministratori per lo studio iniziale delle tecnologie e per la predisposizione della struttura di lavoro. La discussione ha portato alle seguenti assegnazioni:

- #strong[1] responsabile
- #strong[2] amministratori
- #strong[2] analisti
- #strong[1] verificatore

Le regole di rotazione dei ruoli rimangono, attualmente, quelle già definite nel documento "Preventivo Costi e Dichiarazione Impegni" pubblico sul sito ufficiale della documentazione del gruppo.

== Frequenza degli incontri

Per garantire un ottimale grado di aggiornamento e allo stesso tempo non caricare eccessivamente il gruppo con riunioni onerose in termini temporali, è stato concordato lo svolgimento di un incontro infrasettimanale il giovedì, indicativamente verso le ore 18:30, la cui durata deve corrispondere ad un "veloce meeting di aggiornamento".
Eventualmente sarà possibile organizzare un'ulteriore seduta straordinaria qualora la situazione lo richieda.

== Analisi board di progetto

Tema centrale della riunione è stata la discussione sulla board di progetto e l'inserimento delle nuove issue per lo sprint corrente.
Mattia Pasquato ha sollevato la necessità di inserire una nuova voce nel workflow che rifletta l'atto di approvazione al rilascio come decisione autocratica del Responsabile, si è deciso quindi di aggiungere un'ulteriore colonna nella board di progetto denominata "Ready for Release" per permettere il controllo e approvazione finale.
È stata inoltre recepita la direttiva del prof. Vardanega di definire formalmente le milestone di progetto e, a tal proposito, unitamente al bisogno di tracciare le ore di progetto si è deciso di implementare una dashboard grafica a cura di Mattia Pasquato.

#fonte_decisione([D\_2], [È necessario definire le milestone di progetto.])

#fonte_decisione([D\_3], [Aggiungere dashboard alla vista web per la documentazione di gruppo.])

== Analisi approfondita e primi contatti post-aggiudicazione

La prima fase del progetto, successiva all'aggiudicazione del capitolato, richiede un iniziale e intenso lavoro di analisi che sarà svolto dagli analisti incaricati Carlo Nardin e Godwin Agbleze; a tal fine saranno utilizzati i contenuti forniti nel capitolato da Miriade e le risposte date dall'azienda in sede di primo incontro Q&A.
Si è inoltre deciso di provvedere ad inviare una mail ai referenti di Miriade per la conferma di aggiudicazione e definire le modalità per la riunione di formazione tecnologica e di contesto offerta a supporto del progetto.

#fonte_decisione([D\_4], [È necessario svolgere un primo lavoro di analisi approfondita delle tecnologie in vista della riunione con Miriade.])

#fonte_decisione([D\_5], [Il responsabile invia la mail di conferma dell'aggiudicazione dell'appalto e richiede la possibilità di fissare il meeting di formazione.])

= Tracciamento Azioni

#tabella_decisioni(
  (id: [D\_1], azioni: (
      (azione: [Modifica della struttura tabella di tracciamento], issue: [#issue(70)], ass: [Nikola Miljanovic], ver: [Mattia Scomparin], scad: [-]),
  )),
  (id: [D\_2], azioni: (
      (azione: [Definire le milestone di progetto], issue: [#issue(69)], ass: [Mattia Pasquato], ver: [Mattia Scomparin], scad: [-]),
      (azione: [Aggiungere colonna "Ready for Release"], issue: [#issue(67)], ass: [Mattia Pasquato], ver: [Mattia Scomparin], scad: [-]),
  )),
  (id: [D\_3], azioni: (
      (azione: [Aggiungere dashboard al sito web della documentazione], issue: [#issue(65)], ass: [Mattia Pasquato], ver: [Mattia Scomparin], scad: [-]),
  )),
  (id: [D\_4], azioni: (
      (azione: [Analisi dettagliata delle tecnologie del capitolato aggiudicato (C5)], issue: [#issue(72)], ass: [Carlo Nardin e Godwin Agbleze], ver: [Mattia Scomparin], scad: [-]),
  )),
  (id: [D\_5], azioni: (
      (azione: [Invio mail a Miriade], issue: [#issue(64)], ass: [Giacomo Ravazzolo], ver: [Mattia Scomparin], scad: [-]),
  )),
)

= Tracciamento Decisioni Precedenti

Nessuna decisione precedente da tracciare.

*Prossimo incontro:* 2026-11-12 alle 18:30 su Google Meet.
