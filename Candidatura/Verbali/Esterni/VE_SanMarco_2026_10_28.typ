#import "../template.typ": *

#show: verbale.with(
  titolo: "Verbale - San Marco Informatica S.p.A. (C0)",
  data: "2026-10-28",
  versione: "1.0.0",
  uso: "Esterno",
  redattore: "Mattia Scomparin",
  verificatore: "Godwin Agbleze",
  destinatari: ("Prof. Tullio Vardanega", "Prof. Riccardo Cardin", "San Marco Informatica S.p.A."),
  riassunto: "",
  registro_modifiche: (
    ([1.0.0], [2026-10-29], [Mattia Scomparin], [Godwin Agbleze], [- Prima stesura del verbale])
  ),
)

= Informazioni generali
== Luogo e data della riunione
- *Luogo*: Asincrono via e-mail
- *Data*: 2026-10-28

== Partecipanti
*Team*
- Godwin Agbleze
- Nikola Miljanovic
- Carlo Nardin
- Giacomo Ravazzolo
- Mattia Pasquato
- Mattia Scomparin

*San Marco Informatica S.p.A.*
- Riferimenti:
    - Linda Benozzato
    - Luca Marcon
    - Alberto Veronese

= Ordine del giorno
+ Canali di ingresso e entità da gestire
+ Destinazione e criterio di scelta degli applicativi
+ Gestione dei dati essenziali mancanti
+ Template delle entità e campi obbligatori
+ Livello di accuratezza e gestione dei casi incerti
+ Test di unità/integrazione e dati di esempio

= Discussione
== Canali di ingresso e entità da gestire
/ Domanda: Nel capitolato vengono citati diversi canali di ingresso: e-mail con allegati, messaggi di testo, messaggi vocali, cartelle del filesystem, immagini e meeting. Sono tutti obbligatori per il progetto, oppure alcuni sono da considerare opzionali o sviluppi successivi all’MVP? Analogamente, per quanto riguarda le entità che AIRA deve riconoscere (ordini, ticket, appuntamenti, opportunità commerciali, richieste di documenti contabili, ecc.), esiste un insieme minimo da gestire obbligatoriamente, con eventuali aggiunte facoltative, oppure devono essere implementate tutte quelle citate?

#terms.item(
  "Risposta",
  [Per la versione MVP, i canali d'ingresso prioritari sono:
    + E-mail (elaborazione del testo del messaggio e dei file allegati PDF/immagini)
    + Messaggi vocali di whatsapp (audio da trascrivere via speech-to-text)
    Tutti gli altri canali citati nel capitolato generale (cartelle di file system locale o remoto, fotografie da fotocamera, meeting) sono da considerarsi opzionali ed eventuali estensioni future da valutare dopo il completamento del flusso principale. \
    La priorità è la gestione degli ordini; le e-mail di richiesta supporto possono essere gestite come entità generica di assistenza/ticket, ma il focus fondamentale rimane l'ordine d'acquisto.
  ],
)

== Destinazione e criterio di scelta degli applicativi
/ Domanda: Una volta riconosciuta l’entità, AIRA organizza i dati estratti secondo il template corrispondente e li invia all’applicativo aziendale di destinazione. Per una stessa entità, dobbiamo prevedere più applicativi di destinazione dello stesso tipo (ad esempio due ERP diversi)? In questo caso, con quale criterio AIRA deve scegliere a quale inviare la richiesta?

/ Risposta: Ai fini dello sviluppo dell'MVP, non occorre implementare complessi motori di routing dinamico a scelta dell'utente, il flusso si può limitare a:
  - Identificare l'anagrafica dal mittente
  - Mappare i dati estratti dall'IA nel template JSON concordato
  - Effettuare la chiamata API REST verso le API MOCK fittizie che vi forniremo per simulare l'invio al sistema di destinazione

== Gestione dei dati essenziali mancanti
/ Domanda: AIRA monitora costantemente i canali di ingresso. Se in una richiesta mancano dei dati essenziali, come dobbiamo gestire il caso? La richiesta deve essere segnalata nell’interfaccia affinché un operatore la verifichi, oppure il sistema deve contattare direttamente il mittente indicando quali dati mancano e che la richiesta non può proseguire? Oppure è previsto un comportamento diverso a seconda dei casi?

/ Risposta: Per la versione MVP non è prevista una gestione automatica di chat/comunicazione bidirezionale avanzata con il mittente per richiedere le informazioni mancanti. Eventuali e-mail o messaggi automatici di risposta inviati sullo stesso canale possono servire come conferma di presa in carico o di esito finale dell'elaborazione; quando una richiesta presenta dati insufficienti per compilare i campi obbligatori del template JSON o non supera la soglia di confidenza stabilita, può essere contrassegnata come non riuscita. L'anomalia può infatti venire registrata nei log di sistema e mostrata nella dashboard di monitoraggio (in Angular) per essere consultata ed eventualmente gestita a posteriori dagli operatori di backoffice.

== Template delle entità e campi obbligatori
/ Domanda: I template di ciascuna entità e i relativi campi obbligatori saranno forniti dall’azienda in base alle specifiche delle API degli applicativi di destinazione? Oppure possiamo definirli noi come modello interno, adattandoli poi a quanto richiesto dai singoli applicativi?

/ Risposta: Verranno messi a disposizione del team esempi di strutture d'ordine sia in formato JSON (con la definizione dei campi obbligatori di testata e delle righe d'ordine) sia in formato e-mail e PDF di test: il vostro compito sarà quello di mappare l'output del modello linguistico affinché popoli correttamente il template JSON fornito.

== Livello di accuratezza e gestione dei casi incerti
/ Domanda: L’IA può commettere errori di lettura o interpretazione (ad esempio OCR su foto di scarsa qualità o codici articolo ambigui) e considerarli corretti. Quale livello di accuratezza Vi aspettate? Come dobbiamo gestire i casi incerti? Ad esempio, tramite una coda di revisione umana o altre modalità?

#terms.item(
  [Risposta],
  [Ci si aspetta una percentuale di successo di almeno l'80% – 85% sulle elaborazioni che popolano correttamente lo schema JSON di destinazione, non è richiesto il matching puntuale con il catalogo prodotti come obiettivo primario dell'MVP, focalizzandosi invece sulla precisione dell'estrazione dei dati dal testo/audio. \
    Si può poi applicare una soglia di confidenza parametrizzata: le elaborazioni che superano la soglia passano direttamente e automaticamente ai sistemi di destinazione senza intervento umano preventivo (no human-in-the-loop), mentre i casi dubbi o con confidenza sotto la soglia possono essere salvati nei log e mostrati sulla dashboard Angular per l'ispezione a posteriori del backoffice.],
)

== Test di unità/integrazione e dati di esempio
/ Domanda: Il capitolato richiede test di unità e di integrazione per verificare l’affidabilità dell’intera pipeline, inclusi i diversi canali e l’esecuzione corretta delle azioni. Questi test, o i dati di esempio su cui basarli (email, vocali, foto), saranno forniti dall’azienda, oppure dovremo crearli noi?

#terms.item(
  [Risposta],
  [I test di unità e di integrazione sono richiesti dal capitolato per verificare la stabilità della pipeline e la corretta esecuzione delle chiamate. \
    Condivideremo un set di dati contenente e-mail di prova, documenti PDF (ordini di vendita ed elenchi di articoli) mentre i file audio per il canale WhatsApp potranno essere registrati o generati autonomamente da voi partendo dai testi/PDF di prova forniti, simulando anche situazioni reali con rumori di fondo.],
)

= Tracciamento Azioni
#tabella_azioni(
  issue(35), [Redazione Verbale], [Mattia Scomparin], [Godwin Agbleze],
  issue(9), [Aggiornamento Documento Valutazione Capitolati (C0) con vincoli emersi], [Giacomo Ravazzolo], [Mattia Scomparin],
  [-], [Definire, con la proponente, il comportamento in caso di incertezza], [-], [-],
  [-], [Definire, con la proponente, il template JSON da utilizzare per l'estrazione dei dati in entrata], [-], [-],
  [-], [Valutazione di possibile aggiunta di canali di ingresso ulteriori], [-], [-],
)

_*Nota*: le voci prive di ID Issue e assegnatari rappresentano macro-attività la cui effettiva istanziazione e presa in carico è strettamente vincolata all'eventuale aggiudicazione del capitolato._

= Approvazione
Con la presente firma, la proponente conferma che il contenuto del presente verbale rispecchia fedelmente gli argomenti trattati.

#v(1cm)
#align(right)[
  *Per San Marco Informatica S.p.A.* \
  #v(2.0cm)
  #line(length: 40%)
]
