#import "../template.typ": *

#show: verbale.with(
  titolo: "Verbale - Ergon Informatica Srl (C7)",
  data: "2026-10-22",
  versione: "1.0.3",
  uso: "Esterno",
  redattore: "Carlo Nardin",
  verificatore: "Mattia Pasquato",
  destinatari: ("Prof. Tullio Vardanega", "Prof. Riccardo Cardin", "Ergon Informatica Srl"),
  riassunto: "Chiarimenti su gestionale e Data Warehouse, widget e dashboard, assistente AI, ambiente di esecuzione e controllo degli accessi.",
  registro_modifiche: (
    ([1.0.3], [2026-10-29], [Carlo Nardin], [Mattia Scomparin], [- Aggiunta approvazione della proponente]),
    ([1.0.2], [2026-10-27], [Carlo Nardin], [Mattia Scomparin], [- Rettifica denominazione sociale proponente]),
    ([1.0.1], [2026-10-27], [Carlo Nardin], [Mattia Pasquato], [- Aggiunta sezione per l'approvazione]),
    ([1.0.0], [2026-10-25], [Carlo Nardin], [Mattia Pasquato], [- Prima stesura del verbale]),
  )
)

= Informazioni generali
== Luogo e data della riunione
- *Luogo*: Microsoft Teams
- *Data*: 2026-10-22
- *Ora*: 17:00
- *Durata*: 30 minuti

== Partecipanti
*Team*
- Godwin Agbleze
- Carlo Nardin
- Giacomo Ravazzolo
- Mattia Pasquato
- Mattia Scomparin

*Ergon Informatica Srl*
- Riferimento: Gianluca Carlesso

= Ordine del giorno
+ Gestionale, Data Warehouse e dati del caso di studio.
+ Widget e dashboard.
+ Assistente AI: validazione, limiti e trattamento dei dati.
+ Ambiente di esecuzione e controllo degli accessi.

= Discussione
== Gestionale, Data Warehouse e dati del caso di studio
/ Domanda: Quante e quali sono le tabelle del gestionale da normalizzare e arricchire?

/ Risposta: le tabelle del gestionale da normalizzare e successivamente analizzare saranno circa 20. Una è la tabella principale, detta tabella dei fatti, che può contenere fino a milioni di record; le altre sono tabelle satellite, dette tabelle di dimensione, che descrivono i dati rappresentati dalla tabella dei fatti. Nel Data Warehouse si utilizzerà uno schema _a stella_ (tabelle di dimensione collegate direttamente alla tabella dei fatti) o _a fiocco di neve_ (tabelle di dimensione ulteriormente suddivise in sotto-tabelle) per creare una struttura adeguata.

/ Domanda: Il gestionale è uno solo o bisogna prevedere diverse tipologie di ERP? Con più ERP i dati sarebbero conservati in modo diverso, e questo inciderebbe su come vengono copiati nel Raw Data Store. Il formato di scambio dei dati (ad esempio JSON) è legato a questa possibilità?

/ Risposta: si considera un solo gestionale ERP. L'aggiunta di altri gestionali è considerata, al momento, una futura implementazione.

/ Domanda: Con che frequenza i dati del Raw Data Store e del Data Warehouse devono essere allineati con il gestionale (ad esempio una volta al giorno, ogni ora, su richiesta)? Il caricamento può essere completo a ogni esecuzione, ricopiando tutti i dati del gestionale, o deve essere incrementale, cioè recuperare solo i dati nuovi o modificati?

/ Risposta: l'allineamento con il gestionale avviene con una frequenza schedulata, eventualmente decisa con l'utente finale. Non è completo a ogni esecuzione ma incrementale: recupera solo i dati nuovi e modificati.

/ Domanda: I dati del caso di studio reale, utili per lo sviluppo e i test, verranno consegnati come file statici (CSV/JSON), come dump di un database relazionale (es. PostgreSQL/MySQL) o tramite un accesso di test live all'ERP/middleware?

/ Risposta: l'azienda consegnerà i dati del caso di studio come dump di database oppure come file statici CSV o JSON. Il formato dipende da ciò che il gruppo decide di importare.

== Widget e dashboard
/ Domanda: Un widget contiene di fatto una query su DuckDB che recupera i dati da mostrare nella forma grafica scelta dall'utente o suggerita dall'AI?

/ Risposta: sì, i widget dovranno avere nel livello sottostante una query che dà luogo al widget stesso, come avviene negli strumenti di Business Intelligence già presenti. Si noti che, come indicato nel capitolato, il frontend non esegue direttamente le interrogazioni al livello dati, che sono rese disponibili tramite API.

/ Domanda: Esiste una lista precisa di KPI e tabelle da implementare obbligatoriamente?

/ Risposta: è richiesta una lista di base di widget: tabelle, griglie pivot, card, filtri e menu a tendina. La card è un indicatore con un valore corrente e uno di riferimento; una freccia verde o rossa indica se il valore corrente è, in percentuale, sopra o sotto quello di riferimento. Altri widget, come la cartina geografica, possono essere valutati in una lista di priorità.

/ Domanda: Alla prima apertura dell'applicazione, per un nuovo utente la dashboard deve apparire vuota, in modo che sia lui a scegliere cosa visualizzare aggiungendo i widget, oppure deve contenere già una configurazione di base (ad esempio alcuni KPI e grafici predefiniti sulle vendite) che poi può modificare?

/ Risposta: è preferibile che la dashboard sia inizialmente vuota. L'utente può avere a disposizione più dashboard e più visualizzazioni.

== Assistente AI: validazione, limiti e trattamento dei dati
/ Domanda: Quali richieste tipiche degli utenti vanno considerate come banco di prova per l'assistente AI? Con quali criteri si deciderà se una visualizzazione generata o una spiegazione fornita è corretta?

/ Risposta: per validare le risposte dell'assistente AI verrà creato un test case composto da test empirici, ciascuno con la domanda iniziale e il risultato atteso, osservando se l'assistente risponde come atteso. Il test case sarà molto utile perché ogni variazione del modello utilizzato richiederà di rieseguire i test, dato che i risultati potrebbero essere diversi.

/ Domanda: Il capitolato parla di controlli sulla coerenza delle risposte. Se una richiesta è ambigua o i dati non sono sufficienti, l'assistente deve chiedere chiarimenti o dichiarare i propri limiti, invece di rispondere per supposizioni?

/ Risposta: a fronte di una richiesta ambigua o con dati non sufficienti l'assistente AI non deve rispondere per supposizioni; è preferibile che dichiari i propri limiti, per non fornire dati non attendibili. Ciò si può ottenere in diversi modi, ad esempio guidando l'assistente a livello di prompt con regole mirate e specifiche che impongano di non dedurre nulla e di non inventare dati. Si noti che i dati letti e analizzati, situati nel Data Warehouse, sono organizzati per l'analisi stessa: fornire risposte risulta quindi più semplice, perché si rielaborano dati esistenti.

/ Domanda: Trattandosi di dati aziendali, ci sono vincoli sul loro trattamento? In particolare, è accettabile inviare informazioni a un servizio esterno, come l'API di un modello linguistico?

/ Risposta: i dati presenti nel Data Warehouse sono predisposti per le statistiche e si possono indicare quali dati e tabelle possono essere utilizzati, riferendo sempre solamente le informazioni strettamente necessarie per rispondere all'utente.

== Ambiente di esecuzione e controllo degli accessi
/ Domanda: Per la presentazione finale ci sono aspettative sull'ambiente di esecuzione? Va bene un avvio in locale riproducibile, oppure il prodotto deve essere disponibile su un server accessibile?

/ Risposta: nella parte iniziale il progetto può concentrarsi su uno sviluppo in locale; nella parte finale, a regime, deve essere disponibile in un ambiente accessibile esternamente.

/ Domanda: Oltre a far gestire a ogni utente le proprie dashboard, serve anche un controllo degli accessi ai dati? In tal caso, immaginate un modello basato sui ruoli (RBAC), ad esempio agente, oppure sulle relazioni (ReBAC), per cui ogni agente vede solo i propri clienti?

/ Risposta: è richiesto un controllo degli accessi ai dati basato sui ruoli. Sono previsti principalmente gli amministratori, che si occupano del design e della costruzione delle dashboard e hanno accesso a tutta la base di dati, e gli utenti finali, che accedono solo alle dashboard e ai relativi dati per cui hanno ricevuto accesso. Un aspetto interessante può essere la possibilità di impostare, per il singolo utente e la singola dashboard, ulteriori filtri e caratteristiche.

= Tracciamento Azioni
#tabella_azioni(
  issue(22), [Redazione Verbale], [Carlo Nardin], [Mattia Pasquato],
  issue(11), [Aggiornamento Documento Valutazione Capitolati (C7) con vincoli emersi], [Godwin Agbleze], [Mattia Scomparin],
  [-], [Definizione con l'utente finale della frequenza di allineamento dei dati con il gestionale], [-], [-],
  [-], [Scelta del formato di importazione dei dati del caso di studio (dump di database o file CSV/JSON)], [-], [-],
  [-], [Definizione della lista di priorità dei widget oltre a quelli di base, ad esempio la cartina geografica], [-], [-],
  [-], [Definizione di quali dati e tabelle possono essere utilizzati dall'assistente AI], [-], [-],
  [-], [Valutazione di filtri e caratteristiche aggiuntive per singolo utente/dashboard], [-], [-]
)

_*Nota*: le voci prive di ID Issue e assegnatari rappresentano macro-attività la cui effettiva istanziazione e presa in carico è strettamente vincolata all'eventuale aggiudicazione del capitolato._

#v(1.5cm)
= Approvazione
Con la presente firma, la proponente conferma che il contenuto del presente verbale rispecchia fedelmente gli argomenti trattati.

#v(1cm)
#align(right)[
  *Per Ergon* \
  Gianluca Carlesso  \
  #image("../../assets/approvazioni/Ergon_2026-10-22.png", width: 30%)
]
