#set text(lang: "it", font: ("Atkinson Hyperlegible Next", "Liberation Sans"), weight: 400)
#show strong: set text(font: "Atkinson Hyperlegible Next", weight: 700)
#set page(margin: (x: 2.5cm, y: 2.5cm))
#set heading(numbering: "1.")
#set par(justify: true)
#set list(marker: [•])
#show link: it => text(fill: rgb("#c85815"), weight: "bold")[#it]


#align(center)[
  #v(1cm)
  // Assicurati che il percorso del logo sia corretto
  #figure(image("../../assets/logo_nobg.png", width: 35%), outlined: false, numbering: none)
  #v(0.5cm)
  #text(size: 14pt, weight: "bold")[UNIVERSITÀ DEGLI STUDI DI PADOVA] \
  #text(size: 12pt)[Corso di Laurea in Informatica] \
  #text(size: 12pt)[Ingegneria del Software -- A.A. 2026/2027]
  
  #v(1.2cm)
  #line(length: 100%, stroke: 1.5pt + rgb("#c85815"))
  #v(1.2cm)
  
  #text(size: 28pt, font: "Montserrat", weight: 800, fill: rgb("#c85815"))[Valutazione dei Capitolati] \
  #v(0.5cm)
  #text(size: 14pt)[Data: 2026-10-27] \
  #text(size: 14pt)[Versione: 1.0.0]
  
  #v(1.5cm)
  #grid(
    columns: (1fr, 1fr),
    align: (right, left),
    inset: (x: 10pt, y: 5pt),
    row-gutter: 0.7em, 
    text(weight: "bold")[Redattore:], [Godwin Agbleze \ Nikola Miljanovic \ Carlo Nardin \ Giacomo Ravazzolo],
    text(weight: "bold")[Verificatore:], [Godwin Agbleze \ Nikola Miljanovic \ Giacomo Ravazzolo \ Mattia Scomparin],
    text(weight: "bold")[Destinatari:], [Prof. Tullio Vardanega \ Prof. Riccardo Cardin],
  )
  
  #v(1.0cm)
  #line(length: 100%, stroke: 1.5pt + rgb("#c85815"))
  #v(1.0cm)
]

#pagebreak(weak: true)

#set page(
  numbering: "1",
  header: [
    #grid(
      columns: (1fr, auto, 1fr),
      align: horizon,
      line(length: 100%, stroke: 1.5pt + rgb("#c85815")),
      box(inset: (x: 10pt))[#image("../../assets/logo_text_nobg.png", width: 85pt)],
      line(length: 100%, stroke: 1.5pt + rgb("#c85815"))
    )
  ],
)


#heading([Registro delle modifiche], numbering: none, outlined: false)
#text(
  size: 10pt,
  table(
    columns: (0.7fr, 1.5fr, 2fr, 2fr, 4fr),
    align: horizon + left,
    table.header([*Ver.*], [*Data*], [*Redattore*], [*Verificatore*], [*Descrizione*]),
    [1.0.0], [2026-10-27], [Carlo Nardin], [Nikola Miljanovic], [- Prima stesura del documento]
  )
)


#pagebreak(weak: true)


#show outline.entry.where(level: 1): it => {
  v(12pt, weak: true)
  strong(it)
}
#outline(indent: auto)
#pagebreak()


= Capitolato C0: AIRA

== Informazioni generali
- *Progetto*: AIRA (AI Requests Automation)
- *Proponente*: Sanmarco Informatica SPA
- *Committente*: Prof. Tullio Vardanega e Prof. Riccardo Cardin

== Descrizione
Il progetto si pone l’obiettivo di risolvere uno dei principali problemi del contesto Business-to-Business: la gestione manuale di un’enorme quantità di informazioni provenienti da canali di comunicazione eterogenei, quali e-mail con allegati, messaggi testuali e vocali, immagini e cartelle filesystem. Tali informazioni giungono in forma non strutturata, il che rende complessa la centralizzazione dei dati e rallenta il loro inserimento negli applicativi aziendali, esponendo l’azienda a errori e imprecisioni.

L’azienda proponente individua la realizzazione di un tool guidato dall’intelligenza artificiale che raccoglie i dati dalle diverse fonti, ne estrae il significato semantico organizzandolo in template strutturati e li inoltra alle piattaforme aziendali tramite servizi API REST. In questo modo il processo viene velocizzato e l’intervento manuale ridotto al minimo.

== Finalità
Il progetto richiede lo sviluppo di AIRA, un tool multimodale guidato dall’intelligenza artificiale che monitora costantemente i canali esterni e, all’arrivo di una richiesta, la analizza estraendone i dati contenuti e identificandone l’entità. Le informazioni raccolte vengono poi organizzate in template strutturati per tipologia di entità (ad esempio ordini, ticket, eventi, case). In base all’entità rilevata, il sistema inoltra i dati validati ai sistemi aziendali di destinazione (portali B2B, ERP, CRM, ticketing) tramite API REST o e-mail, riducendo i passaggi manuali e i tempi e costi operativi. Il progetto prevede la realizzazione obbligatoria delle seguenti funzionalità:
- Monitoraggio continuo dei canali esterni configurati, con rilevamento del mittente e del testo e lettura degli eventuali allegati;
- Filtro sui dati in ingresso, per prevenire l’accesso non autorizzato e la commistione di informazioni;
- Elaborazione semantica delle richieste e delle intenzioni tramite LLM, per la validazione e la strutturazione dei dati;
- Avvio automatico di azioni di notifica ed esecuzione in base all’entità rilevata, configurabili come chiamate a servizi API REST verso gli applicativi aziendali oppure come invio automatico di e-mail;
- Interfaccia amministrativa web-based, per configurare i canali attivi, consultare lo storico dei log e gestire la persistenza locale dei dati.

== Tecnologie interessate
L’azienda proponente consiglia alcune tecnologie per la realizzazione del progetto, che non sono però vincolanti:
- Angular e TypeScript, per la realizzazione dell’interfaccia amministrativa;
- Java con Spring Boot, per il motore di elaborazione;
- SQLite, MariaDB o PostgreSQL, per la persistenza dei dati in un database relazionale;
- LLM e LangChain4j, per l’orchestrazione del modello linguistico e l’interpretazione semantica, con identificazione di entità e intenzione;
- Whisper e Google Speech per la trascrizione di messaggi vocali e file audio (speech-to-text), Tesseract ed EasyOCR per la lettura di testi da immagini e documenti scansionati (OCR);
- JSON o YAML, per la configurazione esternalizzata.

== Aspetti positivi
- L’azienda proponente si è resa disponibile ad affiancare gli studenti con figure professionali dedicate, che offriranno supporto tecnico, assistenza nel setup degli ambienti e guida nella risoluzione delle criticità.
- Il progetto offre l’opportunità di approfondire tecnologie attuali e di forte interesse, come l’elaborazione del linguaggio tramite LLM, il riconoscimento ottico dei caratteri (OCR) e la trascrizione automatica del parlato (speech-to-text), il tutto supportato da risorse di riferimento già indicate dall’azienda.
- Il progetto produce uno strumento di utilità concreta e applicabile in un contesto aziendale reale, adatto a gestire diverse tipologie di richiesta provenienti da più canali, con benefici diretti in termini di tempi, costi ed errori.

== Criticità e fattori di rischio
- L’aspetto modulare del progetto, pensato per aggiungere nuovi canali o funzionalità senza ripercussioni sul resto del sistema, e la copertura dei test possono rappresentare una sfida impegnativa.

== Conclusioni
Il progetto AIRA è una proposta valida e interessante che risponde a un’esigenza concreta del contesto Business-to-Business, si basa su tecnologie moderne e può contare sul supporto dell’azienda proponente. Il nostro interesse si è però orientato con maggiore convinzione verso un altro capitolato che abbiamo ritenuto più accattivante.


#pagebreak()


= Capitolato C1: AURA

== Informazioni generali
- *Progetto*: AURA (AI for Understanding, Reasoning and Automation)
- *Proponente*: Vimar S.p.A.
- *Committente*: Prof. Tullio Vardanega e Prof. Riccardo Cardin

== Descrizione
La domotica si è evoluta fino a diventare un sistema completo di automazione per la casa, che permette di controllare ogni aspetto dell'abitazione rendendola più intelligente ed efficiente. Il progetto proposto da Vimar vuole mostrare come questi impianti possano essere potenziati con l'intelligenza artificiale: l'utente potrà controllare la propria casa parlando in linguaggio naturale con un servizio AI già esistente, con richieste come “spegni le luci del soggiorno” o “ho freddo in camera”, senza la necessità di un'applicazione dedicata.

== Finalità
Il progetto richiede lo sviluppo di un server MCP (Model Context Protocol) che integri gli impianti domotici Vimar con servizi di intelligenza artificiale generativa. Il server comunica con l'impianto tramite le KNX IoT 3rd-party API e le espone all'AI sotto forma di strumenti standardizzati, così che l'utente possa interrogare l'impianto, ottenere informazioni ed eseguire comandi attraverso il modello AI di sua scelta. Tra le funzionalità obbligatorie sono previste l'autenticazione con l'account MyVimar, la lettura e la scrittura sui dispositivi e la gestione di richieste base e avanzate (ambigue, implicite, con conferma per comandi estesi). Sono inoltre previste funzionalità desiderabili, come la gestione di più impianti contemporaneamente, le domande sullo storico, gli scenari composti e i trigger ed eventi.

Il progetto prevede la realizzazione di tre componenti:
- un'infrastruttura Cloud-ready basata su container, progettata evitando configurazioni manuali e privilegiando file di configurazione versionati (Infrastructure as Code), che ospita funzioni e servizi e deve poter essere rilasciata su AWS;
- un MCP server + client per interfacciarsi con le KNX IoT API;
- un agente o modello AI commerciale esterno collegato al server MCP.

Il progetto deve infine essere accompagnato da test di unità e di integrazione con copertura minima del 75% e da test end-to-end con copertura minima dell'80%.

== Tecnologie interessate
Il progetto prevede alcune tecnologie obbligatorie e ne suggerisce altre:
- Python con FastMCP (in alternativa TypeScript o Java) per sviluppare MCP server e client che collegano l'AI all'impianto;
- KNX IoT 3rd-party API per leggere e comandare l'impianto, con autenticazione tramite OAuth2 verso l'account MyVimar;
- Docker e docker-compose per l'infrastruttura Cloud, che deve poter essere costruita e replicata con un solo comando (è concesso l'uso di Terraform, AWS CDK v2, Ansible);
- Subscription per la ricezione delle notifiche di impianto;
- AWS per il rilascio dell'infrastruttura;
- PostgreSQL, MySQL, Redis sono consigliati qualora si preveda l'impiego di un database;
- GitHub Runners come CI (Continuous Integration) per automatizzare build, test e analisi statica (consigliato);
- AWS o DigitalOcean per un ambiente di sviluppo live in cui eseguire l'applicativo con gli ultimi aggiornamenti.

== Aspetti positivi
- L'azienda fornisce a ogni gruppo un kit fisico di impianto Smart, l'accesso alle API REST KNX IoT con la relativa documentazione e, se necessario, spazio e servizi su AWS.
- L'azienda offre un SAL (Stato Avanzamento Lavori) bisettimanale di 1 ora e la possibilità di presentare demo e avanzamenti ai professionisti di Ricerca e Sviluppo di Vimar, ottenendo confronti diretti e consigli utili.
- Ampio numero di tecnologie moderne con cui confrontarsi.

== Criticità e fattori di rischio
- MVP corposo.
- L'azienda, rispetto ad altre proponenti, si è resa meno disponibile, raccogliendo le domande in un documento condiviso e senza prevedere colloqui individuali con i gruppi fino all'assegnazione.

== Conclusioni
Il progetto ha interessato il gruppo fin da subito, per l’ambito concreto e per le tecnologie utilizzate. Tuttavia, le criticità emerse e l'elevato numero di gruppi interessati hanno portato alla decisione di non procedere con questo progetto.


#pagebreak()


= Capitolato C2: NEXUM Concierge

== Informazioni generali
- *Progetto*: NEXUM Concierge
- *Proponente*: Eggon
- *Committente*: Prof. Tullio Vardanega e Prof. Riccardo Cardin

== Descrizione
NEXUM è una piattaforma dedicata alla comunicazione aziendale e alla gestione di servizi e processi HR. È composta da un backoffice amministrativo, riservato a chi gestisce contenuti, persone e configurazioni aziendali, e da una PWA (Progressive Web App) attraverso cui il personale consulta le comunicazioni e utilizza i servizi disponibili. Il progetto proposto richiede di affiancare a queste interfacce un assistente conversazionale (Concierge) con cui il personale può, in linguaggio naturale, trovare informazioni, comprendere le procedure e accedere ai servizi aziendali riferiti all'ambito limitato di ferie e permessi.

== Finalità
Il progetto richiede lo sviluppo di una chat conversazionale e di un backoffice per la gestione delle fonti, limitatamente all'ambito di ferie e permessi. Il personale dialoga in linguaggio naturale con il Concierge, in cui un modello linguistico interpreta la richiesta, mentre la gestione del dialogo ne mantiene il contesto e seleziona il percorso più adatto tra consultazione della conoscenza (regolamenti aziendali e manuali NEXUM), lettura dei dati personali e invio di richieste ai servizi NEXUM. Il Concierge deve quindi saper svolgere quattro azioni principali: rispondere a domande sulle regole aziendali, spiegare l'uso delle funzioni di NEXUM, mostrare i dati personali su ferie e permessi e preparare e registrare una richiesta dopo conferma dell'utente.

L'MVP prevede la realizzazione di:
- un'interfaccia conversazionale in grado di gestire il contesto del dialogo e di chiedere chiarimenti quando le informazioni sono ambigue;
- un backoffice per il caricamento e la gestione delle fonti aziendali;
- la costruzione e la consultazione della conoscenza a partire da regolamenti e manuali NEXUM, tenuti distinti, con indicazione di fonti e versioni e con astensione dalla risposta in caso di informazioni non sufficienti;
- una funzione di lettura dei dati personali su ferie e permessi;
- una funzione di registrazione delle richieste, con riepilogo completo e conferma esplicita prima dell'invio e restituzione dell'esito effettivo;
- la distinzione di due profili, personale (consulta le conoscenze autorizzate e opera sui propri dati) e amministratore (gestisce fonti e funzioni di backoffice), con relative autorizzazioni e gestione degli errori;
- la tracciabilità di fonti consultate ed esiti delle operazioni.

== Tecnologie interessate
Stack, modelli e servizi di intelligenza artificiale da utilizzare per il Concierge verranno concordati in un secondo momento con l'azienda. La piattaforma NEXUM, con cui il progetto dovrà interfacciarsi, utilizza le seguenti tecnologie:
- Angular e PrimeNG per il backoffice;
- Angular, Tailwind CSS e ZardUI per la PWA, con Firebase per le notifiche push;
- Ruby on Rails per esporre le API usate da entrambe le interfacce;
- OAuth2 e token JWT per l'autenticazione;
- PostgreSQL, Redis, AWS S3 e Sidekiq per i dati e i servizi.

== Aspetti positivi
- Il capitolato presenta in modo chiaro e definito il PoC (Proof of Concept) e l'MVP (Minimum Viable Product).
- Le finalità del progetto sono definite con precisione e hanno un'utilità pratica immediatamente riconoscibile.
- Le tecnologie da utilizzare vengono concordate con l'azienda, lasciando al gruppo un'ampia libertà di scelta.

== Criticità e fattori di rischio
- Le soglie quantitative dei requisiti di prestazione non sono ancora definite e verranno stabilite in relazione ai volumi di prova. Questa incertezza può comportare sfide e rallentamenti nello sviluppo.

== Conclusioni
Il capitolato è interessante e ben strutturato, ma rispetto agli altri è risultato meno accattivante e per questo il gruppo ha preferito orientarsi verso altre proposte.

= Capitolato C3: FossDot

== Informazioni generali
- *Progetto*: FossDot
- *Proponente*: Uranion EMEA Ltd
- *Committente*: Prof. Tullio Vardanega e Prof. Riccardo Cardin

== Descrizione
Il progetto chiede di realizzare un smart speaker open source (un assistente vocale da tavolo simile ad Amazon Echo o Google Nest) che sia però completamente aperto, modificabile e rispettoso della privacy.

L'ecosistema copre l'intera catena del valore di un assistente vocale da tavolo, articolandosi in quattro componenti principali:
- Selezione dell'hardware
- Firmware embedded (MVP)
- Servizio di bridging (Backend)
- Interfaccia di gestione

== Finalità
La finalità principale del progetto è superare i limiti strutturali, di privacy e commerciali dei dispositivi commerciali esistenti (come Amazon Echo, Google Nest e Apple HomePod), i quali risultano chiusi e legati indissolubilmente al cloud di un unico fornitore. Nello specifico, gli obiettivi chiave sono:
- Eliminare il vincolo di lock-in e offrire libertà di scelta
- Garantire la privacy e la conformità al GDPR
- Contrastare l'obsolescenza programmata
- Abilitare la cooperazione multi-dispositivo

== Tecnologie interessate
- hardware di elaborazione (single-board computer o microcontrollore) scelto dal gruppo, array di microfoni e altoparlante
- Rust e framework Embassy per lo sviluppo del firmware embedded
- Silero VAD per l'identificazione del parlato
- openWakeWorkd per il rilevamento delle "wake-word"
- faster-whisper per garantire l'efficienza dello speech-to-text
- Piper la sintesi vocale (text-to-speech)
- Rust con Runtime Tokio e Axum per servizio di bridging (server e API)
- Ollama per eseguire modelli linguistici in locale a garanzia della privacy
- Docker per il servizio server

== Aspetti positivi
- offre ottime competenze verticali da inserire nel proprio protfolio (uso di Rust per ecosistemi moderni, modelli IA locali e protocolli emergenti come MCP)
- libertà di scelta tecnologica e supporto aziendale
- proprietà intellettuale aperta (il progetto rimane del gruppo con licenza permissiva)

== Criticità e fattori di rischio
- problema troppo eterogeneo nel suo insieme (non si tratta solo di software ma anche di selezione di componenti fisici)
- gestire la cattura a distanza, il rilevamento delle "wake-word", la riduzione del rumore e le altre funzionalità specifiche del capitolato può rivelarsi troppo complesso
- per completare l'MVP e verificare il funzionamento del prodotto con diversi dispositivi e interfacce è richiesta una considerevole mole di test

== Conclusioni
A causa della forte eterogeneità tra hardware e software, della complessità nella gestione dei flussi audio in tempo reale e dell'onerosità per il completamento del MVP, il gruppo ha deciso di scartare questo capitolato e di orientarsi verso alternative più sostenibili.


#pagebreak()


= Capitolato C4: GVSPV

== Informazioni generali
- *Progetto*: GVSPV
- *Proponente*: M31 s.r.l.
- *Committente*: Prof. Tullio Vardanega e Prof. Riccardo Cardin

== Descrizione
Il progetto consiste nello sviluppo di una piattaforma software centralizzata e distribuita per il settore automotive, pensata per gestire l'intero ciclo di vita post-vendita di un veicolo.

Il sistema deve far collaborare tre attori principali attraverso livelli architetturali dedicati:
- La Casa Automobilistica (Central Management) che gestisce i cataloghi dei modelli, l'immatricolazione iniziale dei veicoli e l'emissione di eventuali campagne di richiamo di sicurezza.
- Le Concessionarie e i Centri di Assistenza (Operations) che gestiscono le vendite ai clienti finali, la ricezione delle richieste di manutenzione, la pianificazione degli appuntamenti e l'esecuzione dei richiami.
- I Proprietari Finali (Customer Services), a cui viene messo a disposizione un punto di accesso dedicato per consultare i dati dei propri veicoli, prenotare interventi di manutenzione e ricevere notifiche.

== Finalità
L'obiettivo principale del progetto è superare la frammentazione delle informazioni e dei sistemi nel settore post-vendita automotive centralizzando le informazioni, migliorando la collaborazione tra i vari attori coinvolti, offrendo un punto di accesso unificato e garantendo un accesso sicuro e profilato in base ai differenti ruoli utente.

== Tecnologie interessate
- Node.js e Nest.js con TypeScript
- Go
- PostgreSQL e MongoDB per la persistenza dei dati
- Redis
- NATS come message broker per la comunicazione asincrona
- Kubernetes per l'orchestrazione
- Angular per lo sviluppo frontend
- Architettura a microservizi

== Aspetti positivi
- si tratta di un progetto con un dominio molto reale e ben strutturato (i processi del post-vendita del settore automotive sono standardizzati e logici, il che rende semplice la stesura dei casi d'uso)
- richiede l'uso di tecnologie molto richieste nel mercato dello sviluppo software come Nest.js, TypeScript, PostgreSQL e Angular

== Criticità e fattori di rischio
- possibile overengineering infrastrutturale: viene fatta intuire l'adozione di un'architettura distribuita a microservizi (gestione di cluster Kubernetes, gestione di comunicazione asincrona con un message broker, implementazione di un sistema di persistenza poliglotta)
- possibili difficoltà nella gestione delle campagne di richiamo (bisogna poter identificare migliaia di veicoli associati ad un comune difetto di fabbrica, coordinare la comunicazione casa madre-concessionarie e gestire le modalità di contatto e notifica verso i clienti)
- necessità di creare molteplici interfacce e dashboard profondamente diverse a seconda della tipologia di utente

== Conclusioni
In considerazione dei marcati rischi infrastrutturali e delle possibili difficoltà legate al dominio del progetto, il gruppo ha deciso di non voler approfondire ulteriormente il capitolato


#pagebreak()


= Capitolato C5: RareCare Navigator

== Informazioni generali
- *Progetto*: RareCare Navigator
- *Proponente*: Miriade s.r.l.
- *Committente*: Prof. Tullio Vardanega e Prof. Riccardo Cardin

== Descrizione
RareCare Navigator è una piattaforma digitale e mobile (cross-platform) dotata di un assistente virtuale basato su Intelligenza Artificiale, progettata per la gestione e il supporto delle persone affette da malattie rare e complesse.

La soluzione si compone di:
- Un Hub di Coordinamento Multilivello: Una dashboard collaborativa con controlli d'accesso granulari per connettere in sicurezza i diversi attori della rete di cura.
- Un Assistente RAG: implementato come chat AI per orientare i familiari tra protocolli clinici e pratiche burocratiche attingendo esclusivamente a fonti verificate.
- Un Fascicolo Digitale e Checklist Dinamiche: Un archivio cifrato per la gestione sicura dei documenti clinici/scolastici (come referti, PAI e PEI) e il tracciamento automatizzato di scadenze e promemoria.
- Un'Architettura Cloud Serverless e Modulare: Strutturata separando il Core della piattaforma dai pacchetti specifici di patologia (Disease Pack), così da risultare facilmente estendibile ad altre malattie rare.

== Finalità
La finalità principale del progetto è superare l'isolamento e la frammentazione dei servizi che le famiglie con pazienti affetti da malattie rare affrontano quotidianamente, alleggerendo il pesante carico organizzativo ed emotivo.

Il sistema intende affiancare e potenziare la figura del Care Navigator, sfruttando le moderne tecnologie per trasformare un percorso assistenziale spesso discontinuo in un'esperienza più integrata, accessibile e sicura per tutti, garantendo alle famiglie un punto di riferimento stabile e continuo.

== Aspetti positivi
- elevato impatto etico e sociale: si tratta di un progetto estremamente concreto (testato sul campo con Sanfilippo Fighters) con una finalità reale e tangibile
- la separazione tra il nucleo e i "pacchetti di patologia" permette di sperimentare e applicare in modo rigoroso i pattern tipici del Domain-Driven Design garantendo lo sviluppo di un'architettura portatile e "pulita"
- L'utilizzo delle principali tecnologie cloud (es. AWS) disponibili sul mercato arricchisce il nostro curriculum personale
- L'azienda ha fornito un capitolato estremamente dettagliato fornendo in questo modo un'ottima base di partenza, offrendo inoltre la propria disponibilità per una formazione specifica iniziale e periodici incontri di allineamento e chiarimenti per il gruppo

== Criticità e fattori di rischio
- rigidità normativa e di sicurezza da considerare nello sviluppo del progetto trattandosi di dati sanitari particolarmente sensibili
- occorre porre particolare attenzione alla gestione delle allucinazioni e implementare rigorosi metodi di controllo e validazione per le risposte fornite dai modelli IA
- fase iniziale lenta per lo studio delle tecnologie richieste (Flutter/React Native, il prodotto finale deve essere multi-piattaforma es. iOS, Android, Web)

== Conclusioni
Considerati i punti a sfavore il gruppo concorda, comunque, che le motivazioni a vantaggio del capitolato ne rendono interessante un'approfondimento con l'azienda proponente e un possibile sviluppo

= Capitolato C6: Sistema AI di caching semantico e dashboard FinOps

== Informazioni generali
- *Progetto*: Sistema AI di caching semantico e dashboard FinOps
- *Proponente*: Var Group S.p.A.
- *Committente*: Prof. Tullio Vardanega e Prof. Riccardo Cardin

== Descrizione
Il capitolato richiede di sviluppare un orchestratore di intelligenza artificiale e di integrarlo in un progetto già esistente. L'orchestratore sarà integrato con la funzionalità del caching semantico, cioè la capacità di comprendere le richieste dell'utente, salvarle e riconoscere richieste identiche formulate in modo diverso senza la necessità di interrogare un modello di IA per una risposta già presente in cache.

== Finalità
Il progetto si pone l'obiettivo di realizzare un orchestratore di intelligenza artificiale "intelligente", cioè che comprenda le richieste degli utenti, decida quale tra i modelli di IA interrogare e salvare le risposte in una cache per richieste identiche o simile da parti di altri utenti per ottenere un risparmio dei costi.
Viene inoltre richiesta la creazione di una dashboard FinOps (Financial Operations) che mostri i modelli interrogati dall'orchestratore, i costi generati, i risparmi ottenuti dall'utilizzo della cache.

== Tecnologie interessate
- Backend: Python (dalla versione 3.10 in poi), LiteLLM, FastAPI, Flask;
- Docker, Docker Compose;
- Redis;
- Qdrant o pgvector per l'archiviazione vettoriale;
- PostgreSQL per le metrice FinOps;
- Frontend: React (per le interfacce grafiche) con Chart.js (per la creazioni di grafici), in alternativa si può utilizzare Streamlit;
- Git. Github o Bitbucket per il versionamento del codice.

== Aspetti positivi
- Supporto costante e continuo della proponente attraverso sessioni di design thinking e stand-up periodici.

== Criticità e fattori di rischio
- Il progetto richiede di l'integrazione con un'applicazione già esistente.

== Conclusioni
Il progetto non ha suscitato molto l'interesse del gruppo.


#pagebreak()


= Capitolato C7: Smart Dashboard: Piattaforma di Business Intelligence potenziata da AI

== Informazioni generali
- *Progetto*: Smart Dashboard: Piattaforma di Business Intelligence potenziata da AI
- *Proponente*: Ergon Informatica S.r.l.
- *Committente*: Prof. Tullio Vardanega e Prof. Riccardo Cardin

== Descrizione
Il progetto prevede la creazione di una piattaforma che aiuti le aziende a elaborare e analizzare le grandi quantità di dati in loro possesso per la creazione report. La piattaforma ha l'obiettivo di rendere l'utente il più autonomo possibile sostenendolo con un sistema di IA che può descrivere i dati ottenuti dall'elaborazione, interagire con l'utente e supportare nella creazione di dashboard, grafici, tabelle.

== Finalità
Il progetto richiede lo sviluppo di una piattaforma BI (Business Intelligence) integrata con un layer di IA per consentire agli utenti la gestione dei dati in modo autonomo. La piattaforma richiede le seguenti funzionalità:
- un'interfaccia drag & drop configurabile e riutilizzabile;
- un assistente AI per supportare l'interazione con la web app;
- l'esportazione dei contenuti nelle dashboard nei formati PDF ed Excel;
- interattività e filtri dei dati;
- la personalizzazione ed usabilità. Temi chiaro e scuro, interfaccia responsive, tempo di caricamento contenuto anche su dataset ampi.

== Tecnologie interessate
Il proponente suggerisce le seguenti tecnologie:
- Frontend: React, Angular o Vue per le interfacce grafiche;
- Librerie di widget per i grafici, tabelle e indicatori;
- Backend: API REST, Python con l'utilizzo di Polars o Pandas per l'analisi e la manipolazione dei dati; Connettori ODBC o middleware JSON per il gestionale ERP;
- LLM via API: Claude o GPT;
- Database ottimizzati per interrogazioni massive sui dati, letture e recupero dei dati DuckDB (consigliato), con alternative ClickHouse, MonetDB o Apache DataFusion;
- Database relazionali: PostgreSQL, MySQL o MariaDB per la memorizzazione dei dati grezzi.

== Aspetti positivi
- Capitolato e documentazione interessanti.
- Disponibilità da parte della proponente.

== Criticità e fattori di rischio
- Le tecnologie suggerite sono sconosciute alla maggior parte dei membri del gruppo.

== Conclusioni
Nonostante le criticità riscontrate il progetto ha suscitato grande interesse nel gruppo per una potenziale candidatura.


#pagebreak()


= Capitolato C8: Sonar: Documentazione vivente di uno store Shopify

== Informazioni generali
- *Progetto*: Sonar: Documentazione vivente di uno store Shopify
- *Proponente*: Halue S.r.l. Società Benefit
- *Committente*: Prof. Tullio Vardanega e Prof. Riccardo Cardin

== Descrizione
Il capitolato richiede lo sviluppo di un sistema in grado di analizzare una piattaforma e-commerce e generare una documentazione su di essa che mostri: gli strumenti installati, le automazioni attive, le dipendenze presenti e la frequenza di utilizzo delle varie componenti dell'e-commerce.

== Finalità
Il progetto richiede lo sviluppo di un sistema con le seguenti funzionalità:
- un API che si colleghi ad una piattaforma e-commerce esterna e che scansioni l'interno della piattaforma;
- la generazione di una documentazione, sulla piattaforma e-commerce scansionata, esportabile in formato Markdown/HTML;
- la modellazione delle dipendenze presenti nella piattaforma e-commerce attraverso un grafo delle dipendenze.

== Tecnologie interessate
Il progetto richiede l'utilizzo delle seguenti tecnologie:
- Next.js con App Router;
- TypeScript;
- Vercel Workflows per lo sviluppo di processi backend, multi-data pipeline e agenti IA nel codice;
- Vercel Cron Jobs per l'esecuzione time-based di azioni;
- Supabase, PostgreSQL con RLS (Row-Level Security) per la persistenza dei dati;
- Supabase Auth (solo con Google) per l'autenticazione degli utenti;
- Shopify Admin GraphQL API per l'estensione delle funzionalità di Shopify admin;
- Git, GitHub per il versionamento del codice.

Inoltre sono fortamente consigliate o ammesse come alternative le seguenti tecnologie:
- GitHub Actions per l'automazione del workflow di sviluppo software dentro il repository GitHub;
- Vercel Blob per la persistenza di dati non strutturati (immagini, video, audio, documenti, ...)
- Vercel Queues per l'esecuzione di eventi;
- Vercel Sandbox per l'esecuzione di script e codice generato dagli agenti IA in un ambiente sicuro;
- AI Gateway + AI SDK;
- Drizzle o Prisma per la persistenza dei dati;
- Tailwind e shadcn/ui per lo sviluppo di interfacce grafiche;
- React Flow per la costruzione di diagrammi interattivi;
- Cytoscape.js (libreria JavaScript per l'implementazione di grafi);
- OpenTelemetry per la generazione, raccolta ed esportazione di dati di telemetria;
- Vitest, Playwright o MSW per la fase di testing.

== Aspetti positivi
- PoC e MVP ben definiti.
- L'ampio utilizzo di varie tecnologie.

== Criticità e fattori di rischio
- Incontri bisettimanali di 45 minuti per la demo dell'incremento e la revisione del prodotto sono pochi.
- Potenziale complessità per l'alto numero di tecnologie disponibili.

== Conclusioni
Il capitolato è stato scartato per le criticità riscontrate e l'interesse verso altri capitolati.


#pagebreak()


= Capitolato C9: SpecCheck: Skills OpenCode per tracciabilità tra casi d'uso, requisiti e codice sorgente

== Informazioni generali
- *Progetto*: SpecCheck: Skills OpenCode per tracciabilità tra casi d'uso, requisiti e codice sorgente
- *Proponente*: Zucchetti S.p.A.
- *Committente*: Prof. Tullio Vardanega e Prof. Riccardo Cardin

== Descrizione
Il progetto richiede la creazione di un validatore automatizzato con l'abilità di validare specifiche, codice di un progetto e di controllare la qualità e la coerenza del codice rispetto alle specifiche.
Il validatore è formato da 4 parti principali:
- skill (workflow llm): file guida scritti in lingua naturale (inglese o italiano) che indicano all'LLM le procedure operative da attivare automaticamente;
- comandi (invocazioni utente): istruzioni analoghe alle skill, ma lanciate in modo esplicito e diretto dallo sviluppatore;
- tool (procedure esecutive): script deterministici per compiti operativi specifici (es: lettura dei file o comandi di sistema);
- plugin (estensione di piattaforma): componenti software dedicate ad ampliare capacità e gestire elaborazioni complesse.

== Finalità
Il progetto richiede di sviluppare un validatore automatizzato per l'agente di harness OpenCode con le seguenti funzionalità:
- generazione di specifiche da casi d'uso. Il prodotto software deve eseguire il parsing dei diagrammi (Mermaid, XMI, immagini) e documenti Markdown per verificare che ogni caso d'uso sia tradotto nei requisiti di progetto;
- analisi del codice sorgente. Il prodotto software verifica il comportamento del codice generato dall'LLM per la verifica delle funzionalità richieste;
- lo sviluppo di un interfaccia di sintesi che mostra lo stato di copertura del progetto e lo stato dei test;
- un installer che tramite uno script (Bash o PowerShell) che integri il prodotto in OpenCode.

== Tecnologie interessate
Il progetto richiede l'utilizzo delle seguenti tecnologie:
- Bash o PowerShell per la creazione dello script di installazione.

== Aspetti positivi
- Opportunità di utilizzare diverse tecnologie interessanti ancora in evoluzione.

== Criticità e fattori di rischio
- Non vengono menzionate tecnologie specifiche per lo sviluppo del prodotto.

== Conclusioni
Il progetto non ha suscitato interesse nel gruppo per il tema trattato.
