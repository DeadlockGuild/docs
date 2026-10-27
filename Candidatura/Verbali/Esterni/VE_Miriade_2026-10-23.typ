#import "../template.typ": *


#show: verbale.with(
  titolo: "Verbale - Miriade Srl (C5)",
  data: "2026-10-23",
  versione: "1.0.2",
  uso: "Esterno",
  redattore: "Carlo Nardin",
  verificatore: "Giacomo Ravazzolo",
  destinatari: ("Prof. Tullio Vardanega", "Prof. Riccardo Cardin", "Miriade Srl"),
  riassunto: "Chiarimenti su Disease Pack, assistente, permessi e requisiti opzionali.",
  registro_modifiche: (
    ([1.0.2], [2026-10-27], [Carlo Nardin], [Mattia Scomparin], [- Rettifica denominazione sociale proponente]),
    ([1.0.1], [2026-10-27], [Carlo Nardin], [Giacomo Ravazzolo], [- Aggiunta sezione per l'approvazione]),
    ([1.0.0], [2026-10-24], [Carlo Nardin], [Giacomo Ravazzolo], [- Prima stesura del verbale]),
  )
)

= Informazioni generali
== Luogo e data della riunione
- *Luogo*: Google Meet
- *Data*: 2026-10-23
- *Ora*: 15:00
- *Durata*: 40 minuti

== Partecipanti
*Team*
- Godwin Agbleze
- Carlo Nardin
- Giacomo Ravazzolo
- Mattia Scomparin

*Miriade Srl*
- Riferimento: Emanuele Righetto

= Ordine del giorno
+ Disease Pack: contenuti, ambito e gestione.
+ Assistente: fonti, limiti e documenti dell'utente.
+ Attori, permessi e messaggistica.
+ Tecnologie, dati di test e priorità dei requisiti opzionali.

= Discussione
== Disease Pack

/ Domanda: Il Disease Pack contiene anche "prompt e istruzioni specifiche per l'assistente". A cosa ci si riferisce? Sono istruzioni di comportamento o altro? Per il progetto dobbiamo realizzare solo il pack della Sanfilippo o anche uno scheletro di un secondo pack per dimostrare l'estendibilità?
/ Risposta: il contenuto del Disease Pack è proposto nel capitolato ma non è obbligatorio, quindi prompt e istruzioni sono una componente da discutere con la proponente. Vanno intese come istruzioni del pack che si possono aggiungere, come supporto, al contesto della domanda posta all'assistente AI. Il pack deve contenere tutto il necessario per non modificare il core e la configurazione quando si aggiunge un'altra patologia. Il progetto riguarda solo la sindrome di Sanfilippo, senza altri Disease Pack.

#v(1em)

/ Domanda: I contenuti del Disease Pack della Sanfilippo (fasi della malattia, template di checklist e scadenze, fonti documentali) saranno forniti direttamente da Miriade e dall'associazione, oppure dovremo ricavarli noi dopo la formazione iniziale e presentarli poi per la convalida?
/ Risposta: i contenuti sono forniti dall'associazione Sanfilippo Fighters.

#v(1em)

/ Domanda: Per quanto riguarda il Disease Pack, chi lo produce e lo mantiene: personale tecnico o figure cliniche? Nel secondo caso la piattaforma deve offrire strumenti per modificarlo, o basta che lo legga da file?
/ Risposta: per l'MVP il gruppo implementa il Disease Pack lavorando e interagendo con azienda e associazione, e lo carica nella piattaforma. Un attore come il medico non può modificarlo.

#v(1em)

/ Domanda: Il capitolato dice che l'assistente deve basarsi solo su fonti ufficiali verificate. Chi stabilisce se un documento è affidabile? Serve nella piattaforma un modulo apposito per caricare i documenti, verificarli e solo dopo renderli disponibili all'assistente, oppure ci vengono forniti già convalidati e basta caricarli?
/ Risposta: i documenti che compongono il Disease Pack sono da considerare già approvati e attendibili, utilizzabili quindi fin da subito, senza la necessità di una pipeline di caricamento e convalida.

== Assistente

/ Domanda: Nell'MVP l'assistente risponde a domande generali usando le fonti del Disease Pack e, senza fonti pertinenti, risponde "contatta il tuo Care Navigator". Questo vale anche quando l'utente chiede informazioni sui propri documenti, che l'assistente non può consultare? Come deve comportarsi?
/ Risposta: idealmente il progetto dovrebbe permettere all'assistente di accedere anche ai file dell'utente e rispondere a domande su di essi. Si potrebbe fare inserendo nel database vettoriale dell'assistente anche i documenti del paziente, a patto di garantire che vengano letti solamente i documenti del paziente stesso. Per l'MVP è importante che, se all'assistente viene chiesto di accedere o analizzare documenti a cui non può accedere, non inventi dati e dichiari il proprio limite. Questo può essere fatto tramite guardrail su Bedrock (nel caso si decida di utilizzare AWS), configurando l'assistente affinché non effettui supposizioni su ciò che non conosce.

#v(1em)

/ Domanda: Nell'MVP, dove l'assistente non analizza i documenti personali, le scadenze devono essere inserite manualmente con promemoria generati automaticamente a partire da quelle? Nell'evoluzione successiva l'AI potrà leggere il documento e proporre la scadenza, che diventa effettiva solo dopo conferma umana?
/ Risposta: l'aggiunta di scadenze sul database da parte dell'assistente è una caratteristica opzionale. Se non implementata, l'utente inserisce la scadenza manualmente.

#v(1em)

/ Domanda: La fase della malattia del paziente come viene aggiornata nel tempo? Possiamo prevedere un campo impostato manualmente dal Care Navigator? In tal caso, la timeline e la checklist mostrate all'utente dovranno basarsi su quel campo, dato che l'assistente AI non ha accesso ai documenti personali?
/ Risposta: nell'MVP l'intervento dell'assistente AI è limitato ai documenti caricati nel database vettoriale per il RAG. È fondamentale che non prenda alcuna decisione autonoma nei confronti del paziente. Può però proporre tappe e checklist in base alla fase della malattia, con conferma di un umano (il paziente stesso o la clinica), poichè l'assistente non ha la capacità di prendere decisioni in ambito medico.

#v(1em)

/ Domanda: Oltre ai documenti che andremo ad inserire, l'assistente può attingere a fonti esterne già esistenti e validate da altri? Oppure può utilizzare solo il materiale che gli viene fornito?
/ Risposta: per l'MVP l'assistente non attinge a fonti esterne ma utilizza il materiale presente nel Disease Pack. L'aspetto verrà approfondito con l'associazione, perché poterle usare rappresenterebbe un vantaggio.

#v(1em)

/ Domanda: Come vanno mostrate le fonti all'utente? Nel flusso di risposta è previsto che venga restituita la risposta accompagnata dai riferimenti alle fonti. Cosa si intende per riferimento?
/ Risposta: il modo in cui sono comunicate le fonti all'utente sarà deciso successivamente con l'azienda. In linea di massima ci si aspetta il link al documento di riferimento; in alternativa, oltre al link, è possibile inserire un box con un estratto del documento da cui proviene la risposta. Si noti che, se l'assistente è realizzato correttamente, questo può indicare automaticamente da quali documenti prende le informazioni.

== Attori, permessi e messaggistica

/ Domanda: Il capitolato indica che i permessi devono basarsi sia sul ruolo (RBAC) sia sulla relazione con il paziente. Quali sono gli attori ufficiali che dobbiamo considerare? C'è un elenco definitivo, oppure per l'MVP possiamo limitarci a un sottoinsieme di ruoli?
/ Risposta: gli attori saranno definiti meglio dopo l'aggiudicazione dell'appalto, ad esempio stabilendo se realizzare due account separati per famiglia e paziente oppure uno unico. Nel caso di profilo unico, gli altri attori importanti saranno: il Care Navigator, la clinica, il medico (che può accedere agli esami che richiede ed eventualmente a quelli esplicitamente condivisi dal paziente) e un ente pubblico come ad esempio la scuola. Una possibile aggiunta, esterna all'MVP, è un sistema dinamico che verifichi se un utente ha un certo permesso, così da rendere configurabili i permessi degli attori e poter aggiungere un nuovo tipo di utente in modo configurativo e non tramite codice. L'azienda si è offerta di mostrare esempi reali per aiutare a comprendere come realizzarlo.

#v(1em)

/ Domanda: Gli attori della rete devono poter comunicare tra loro dentro la piattaforma, ad esempio con messaggi o commenti, oppure è sufficiente che possano condividere documenti ed eventuali note?
/ Risposta: è auspicabile che nella piattaforma sia presente una modalità di messaggistica diretta per la comunicazione tra gli attori, centrata principalmente sull'invio di documenti e testo, in modo da centralizzare il rapporto tra gli attori all'interno della piattaforma.

== Tecnologie, dati di test e requisiti opzionali

/ Domanda: Miriade offre mentorship tecnica sull'architettura serverless, ma i costi dei servizi AWS e delle richieste ai modelli LLM sono a carico del gruppo o forniti da voi, ad esempio con un account o dei crediti AWS?
/ Risposta: le tecnologie presentate nel capitolato sono suggerite e non obbligatorie. L'azienda prevede la fornitura di account AWS e degli accessi ai servizi necessari per il progetto, in maniera ristretta, con ulteriore supporto, se necessario, su tutte le tecnologie nominate nel capitolato.

#v(1em)

/ Domanda: Per la fase di testing, trattandosi di dati sanitari sensibili, verranno forniti dei dati attinenti al dominio o sarà necessaria la generazione di mock data? In quest'ultimo caso, come suggerite di gestire la generazione di dati mock realistici per popolare l'applicazione durante i test?
/ Risposta: i dati forniti saranno non reali ma generati (mock): tramite pazienti fittizi con esami e documenti si verificherà se il sistema è conforme e se le sue parti interagiscono e funzionano correttamente.

#v(1em)

/ Domanda: Tra i requisiti opzionali (assistente vocale, mappa dei servizi, analisi predittiva) qual è l'ordine di importanza?
/ Risposta: l'ordine di priorità vede al primo posto la mappa dei servizi. La sua implementazione può essere discussa con l'azienda: i dati potrebbero essere recuperati tramite l'associazione, se dispone di elenchi di strutture ed esami, con un amministratore che mantenga i dati aggiornati, piuttosto che cercare di ottenerli dalle strutture. Seguono l'assistente vocale e l'analisi predittiva, che risulta essere il requisito opzionale più ambizioso.

= Tracciamento Azioni

#tabella_azioni(
  issue(21), [Redazione Verbale], [Carlo Nardin], [Giacomo Ravazzolo],
  issue(10), [Aggiornamento Documento Valutazione Capitolati (C5) con vincoli emersi], [Nikola Miljanovic], [Godwin Agbleze],
  [-], [Definizione delle istruzioni da fornire all'assistente tramite il Disease Pack, con la proponente], [-], [-],
  [-], [Valutazione dell'ammissione di eventuali fonti esterne per l'assistente, con la proponente], [-], [-],
  [-], [Scelta del formato con cui l'assistente mostrerà le fonti, con la proponente], [-], [-],
  [-], [Definizione dell'elenco definitivo degli attori], [-], [-],
  [-], [Definizione della fornitura dei dati per l'eventuale mappa dei servizi, con proponente e associazione], [-], [-]
)

_*Nota*: le voci prive di ID Issue e assegnatari rappresentano macro-attività la cui effettiva istanziazione e presa in carico è strettamente vincolata all'eventuale aggiudicazione del capitolato._

#v(1.5cm)
= Approvazione
Con la presente firma, la proponente conferma che il contenuto del presente verbale rispecchia fedelmente gli argomenti trattati.

#v(1cm)
#align(right)[
  *Per Miriade Srl* \
  Emanuele Righetto \
  #v(2cm)
  #line(length: 40%)
]
