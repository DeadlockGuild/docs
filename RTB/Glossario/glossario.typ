#import "template_glossario.typ": *

#show: glossario.with(
  titolo: "Glossario",
  data: "2026-11-11",
  versione: "0.2.0",
  registro_modifiche: (
    ("0.2.0", "2026-11-18", "Nikola Miljanovic", "Mattia Scomparin", "Correzioni di stile e di struttura del template del glossario"),
    ("0.1.0", "2026-11-17", "Nikola Miljanovic", "Mattia Scomparin", "Prima stesura del glossario e inserimento del primo lotto di termini"),
  ),
)

= Introduzione

== Scopo del documento

Il presente documento raccoglie e definisce in modo chiaro e formale il significato dei termini, degli acronimi, delle abbreviazioni e delle espressioni legate al dominio d’uso che compaiono all'interno della documentazione di progetto.

== Convenzione tipografica

Per segnalare immediatamente la presenza di una definizione, all'interno degli altri documenti di progetto ogni termine incluso in questo glossario è contrassegnato da una lettera "*G*" posta a pedice (ad esempio: termine#sub[*G*]).

La notazione a pedice viene applicata, di norma, alla prima occorrenza del termine all'interno di ciascun documento.

== Struttura del documento

Le voci sono organizzate in ordine alfabetico. Per ogni termine viene fornita la definizione nel contesto del progetto, segnalando all'occorrenza, sinonimi, acronimi e riferimenti a voci correlate.

#pagebreak()

= Glossario

// == A

== B

#voce([Backlog], [Elenco ordinato e aggiornato di tutte le attività, funzionalità o correzioni che devono essere realizzate per un progetto software.])

#voce([Branch], [Linea di sviluppo parallela e indipendente all'interno di un sistema di controllo versione (es. Git). Creando un nuovo branch è possibile lavorare su una nuova funzionalità o effettuare correzioni in un ambiente isolato, senza alterare il codice principale del progetto.])

#voce([Back-end], [Logica operativa di un prodotto software. Si occupa di elaborare le richieste dell'interfaccia, gestire la persistenza dei dati, controllare gli accessi e comunicare con eventuali servizi esterni.])

// == C

== D

#voce([Database], [Raccolta strutturata di dati memorizzati in modo permanente su un sistema informatico, progettata per permettere l'accesso, la gestione e l'aggiornamento rapido delle informazioni.])

#voce([Dashboard], [Interfaccia grafica centralizzata che raccoglie e visualizza in forma sintetica dati, metriche e indicatori di stato di un sistema. Permette di monitorare l'andamento delle operazioni principali e rilevare tempestivamente eventuali anomalie.])

#voce([Diagramma di Gantt], [Strumento grafico usato nella gestione dei progetti per pianificare e monitorare le attività nel tempo. Permette di visualizzare istantaneamente scadenze, sovrapposizioni e dipendenze tra le diverse fasi del lavoro.])

// == E

== F

#voce([Front-end], [Parte di un'applicazione web o software visibile all'utente, responsabile della presentazione dei contenuti e della gestione delle interazioni a schermo.])

== G

#voce([Git], [Sistema di controllo versione distribuito che traccia le modifiche effettuate ai file di un progetto nel tempo, consentendo di ripristinare stati precedenti e coordinare lo sviluppo parallelo tra più persone su rami indipendenti.])

#voce([GitHub], [Piattaforma web per l'hosting remoto di repository che utilizza Git come sistema di controllo versione. Integra funzionalità per lo sviluppo collaborativo, tra cui il tracciamento delle anomalie, la revisione del codice e l'automazione dei flussi di test e rilascio.])

#voce([GitHub Pages], [Servizio di hosting gratuito integrato direttamente in GitHub che permette di pubblicare siti web statici partendo dai file contenuti in una repository.])

// == H

// == I

// == J

// == K

// == L

// == M

// == N

// == O

== P

#voce([PoC], [Acronimo di #emph[Proof of Concept]. Prototipo realizzato in tempi brevi e con risorse limitate. Serve a dimostrare che un'idea, una tecnologia o un'architettura software sia effettivamente realizzabile dal punto di vista tecnico prima di entrare nello sviluppo definitivo.])

// == Q

// == R

== S

#voce([Sprint], [Intervallo di tempo fisso e breve (nel contesto del nostro progetto di 2 settimane) utilizzato nelle metodologie di sviluppo Agile, durante il quale il team si impegna a completare un insieme specifico di attività selezionate dal backlog. Ogni sprint comprende le fasi di pianificazione iniziale, sviluppo, test e revisione finale.])

== T

#voce([Typst], [Sistema di composizione tipografica moderno e open source basato su markup, nato per semplificare la scrittura professionale di documenti scientifici, tesi e documentazione tecnica.])

// == U

// == V

== W

#voce([WoW], [Acronimo di #emph[Way of Working]. Insieme condiviso di regole, pratiche, strumenti e processi che un team di sviluppo definisce e adotta per collaborare in modo organizzato ed efficace.])

// == X

// == Y

// == Z
