#import "../template.typ": *

#show: verbale.with(
  titolo: "Verbale Incontro #7",
  data: "2026-11-18",
  versione: "0.1.0",
  uso: "Interno",
  redattore: "Carlo Nardin",
  verificatore: "Nikola Miljanovic",
  destinatari: ("Prof. Tullio Vardanega", "Prof. Riccardo Cardin"),
  riassunto: "Retrospettiva e chiusura dello Sprint 1, stato di avanzamento della documentazione, proposta di automazione del flusso di versionamento e pianificazione dello Sprint 2.",
  registro_modifiche: (
    ("0.1.0", "2026-11-25", "Carlo Nardin", "Nikola Miljanovic", "Prima stesura"),
  ),
)

= Informazioni generali

== Luogo e data della riunione

- *Luogo*: Google Meet
- *Data*: 2026-11-18
- *Ora*: 21:00
- *Durata*: 2 ore

== Partecipanti

- Godwin Agbleze
- Nikola Miljanovic
- Carlo Nardin
- Mattia Pasquato
- Giacomo Ravazzolo
- Mattia Scomparin

= Ordine del giorno

+ Retrospettiva e analisi delle criticità emerse nello Sprint 1.
+ Stato di avanzamento dei documenti di progetto (Analisi dei Requisiti, Glossario, Norme di Progetto).
+ Consuntivo orario e chiusura dello Sprint 1.
+ Proposta di automazione del flusso di versionamento della documentazione.
+ Pianificazione dello Sprint 2: organizzazione della board, rotazione dei ruoli, stime orarie e attività.

= Discussione

== Retrospettiva dello Sprint 1

Il responsabile uscente Giacomo Ravazzolo apre la riunione avviando la retrospettiva di chiusura dello Sprint 1, invitando i membri del gruppo a segnalare criticità e aspetti migliorabili emersi nel periodo appena concluso.

Dal confronto emergono tre principali aree di miglioramento:
- *Bilanciamento dei carichi di lavoro e dei ruoli*: il gruppo ha notato che gran parte delle attività iniziali è ricaduta sul ruolo di amministratore e che entrambi i membri assegnati a questo ruolo nello Sprint 1 sono studenti-lavoratori. In presenza di settimane lavorative intense, questo ha reso più difficile completare tutte le attività previste. Nei prossimi sprint si farà attenzione a distribuire i ruoli in modo più equilibrato, evitando di assegnare lo stesso ruolo a entrambi gli studenti-lavoratori nello stesso sprint.
- *Comunicazione tempestiva delle difficoltà*: il team riconosce la necessità di segnalare tempestivamente sul canale interno eventuali ritardi o impedimenti rispetto alle scadenze, così da permettere al responsabile di riorganizzare priorità e tempi o, quando possibile, ridistribuire i compiti tra i membri con lo stesso ruolo.
- *Dettaglio, granularità e scadenze delle issue*: alcune issue dello Sprint 1 avevano titoli troppo generici. Si stabilisce di compilare in modo più preciso la descrizione delle issue su GitHub per chiarire l'obiettivo di ciascun compito e di fissare le scadenze in base al completamento stimato della singola attività, anziché farle coincidere automaticamente con la fine dello sprint.

Nonostante un paio di attività rimaste in completamento, il gruppo valuta positivamente i progressi raggiunti nello Sprint 1 su infrastruttura, sito web, dashboard e prime stesure dei documenti.

#fonte_decisione([D9], [Adottare i correttivi emersi dalla retrospettiva dello Sprint 1 (descrizioni puntuali delle issue, scadenze realistiche, distribuzione equilibrata dei ruoli) e formalizzare la retrospettiva nel Piano di Progetto.])

== Stato di avanzamento della documentazione

Il gruppo fa il punto sui documenti attualmente in lavorazione:
- *Analisi dei Requisiti*: Carlo Nardin e Godwin Agbleze illustrano la prima stesura del documento, impostata sui capitoli introduttivi, sulla descrizione generale del prodotto e sullo scheletro dei requisiti. La definizione dei casi d'uso e dei diagrammi viene rimandata a valle degli incontri con l'associazione Sanfilippo Fighters e Miriade Srl, poiché il workshop di Design Sprint servirà proprio a definire con chiarezza gli attori del sistema e i relativi flussi di interazione.
- *Glossario*: Nikola Miljanovic illustra lo stato del documento, già dotato di struttura introduttiva e di un primo nucleo di termini. Il gruppo concorda di adottare un popolamento graduale e incrementale, inserendo progressivamente i vocaboli effettivamente utilizzati nei documenti di progetto.
- *Norme di Progetto*: Mattia Pasquato illustra la prima versione del documento, già comprensiva delle sezioni introduttive e dei primi contenuti, su cui verranno aggiunte le sezioni successive nei prossimi sprint.

#fonte_decisione([D10], [Proseguire la stesura della documentazione di progetto (Analisi dei Requisiti e Norme di Progetto).])

== Consuntivo dello Sprint 1 e milestone di progetto

Nel corso della chiusura dello sprint, il gruppo analizza le milestone proposte da Mattia Pasquato, fissandole in forma definitiva e caricandole sulla dashboard di progetto (completando quanto deliberato in #strong[D2]). Il gruppo si riserva di valutare l'introduzione di un'ulteriore milestone intermedia tra RTB e fine sviluppi una volta consolidata la progettazione.

Viene quindi registrato sulla dashboard il consuntivo orario dello Sprint 1 (2026-11-05 -- 2026-11-18), confrontando le ore di riferimento con le ore effettivamente svolte per ciascun ruolo (con Progettista e Programmatore a 0 ore in quanto non ancora attivi):
- *Responsabile* (Giacomo Ravazzolo): 3 ore stimate, 2 ore effettive;
- *Amministratori* (Mattia Pasquato, Nikola Miljanovic): 8 ore stimate complessive, 10 ore effettive;
- *Analisti* (Carlo Nardin, Godwin Agbleze): 8 ore stimate complessive, 6 ore effettive (escludendo dal conteggio il tempo dedicato allo studio preliminare);
- *Verificatore* (Mattia Scomparin): 4 ore stimate, 2 ore effettive.

Il totale dello Sprint 1 ammonta a 20 ore effettive a fronte di 23 ore stimate, confermando il maggiore carico di lavoro ricaduto sugli amministratori, in linea con quanto emerso in retrospettiva.

== Proposta di automazione del flusso di versionamento

Mattia Scomparin presenta una proposta finalizzata ad automatizzare il versionamento dei documenti e l'aggiornamento del registro delle modifiche tramite un flusso ispirato a #emph[GitFlow] e basato su GitHub Actions.

Il modello prevede l'introduzione di un branch `develop` affiancato a `main`: le Pull Request verificate verrebbero integrate in `develop`, attivando uno script automatico capace di incrementare la versione minore e compilare il registro delle modifiche a partire dagli assegnatari e dai revisori della Pull Request; il successivo merge da `develop` a `main`, approvato dal Responsabile, determinerebbe l'incremento della versione maggiore e la pubblicazione del documento. Durante la discussione sono stati analizzati anche i casi di #emph[hotfix] e la gestione dei documenti incrementali, concordando di evitare passaggi eccessivamente burocratici.

Il gruppo valuta positivamente la proposta e decide di dedicare una task nello Sprint 2 alla predisposizione e dimostrazione pratica del flusso in ambiente controllato, prima di deliberarne l'adozione definitiva.

#fonte_decisione([D11], [Avviare la revisione e la sperimentazione del flusso automatizzato di versionamento della documentazione proposto da Mattia Scomparin.])

== Pianificazione dello Sprint 2 e organizzazione della Board

Per migliorare la gestione del #emph[backlog], il gruppo decide di introdurre sulla Project Board la colonna *«Backlog»*, destinata a raccogliere le attività future o individuate in corso d'opera, mantenendo nella colonna *«Todo»* le sole attività pianificate per lo sprint corrente.

Viene quindi chiuso lo Sprint 1 e aperto lo *Sprint 2*, con periodo dal *2026-11-19* al *2026-12-02*. In coerenza con la rotazione dei ruoli e con i correttivi emersi in retrospettiva, il gruppo definisce la seguente assegnazione e le relative stime orarie (per un totale stimato di 28 ore):
- *Responsabile*: Godwin Agbleze (4 ore stimate);
- *Amministratori*: Carlo Nardin, Mattia Scomparin (10 ore stimate complessive);
- *Analisti*: Giacomo Ravazzolo, Mattia Pasquato (10 ore stimate complessive);
- *Verificatore*: Nikola Miljanovic (4 ore stimate);
- *Progettista* e *Programmatore*: non assegnati in questo sprint (0 ore).

Le attività dello Sprint 2, tracciate in dettaglio nella sezione successiva, si concentrano sull'avanzamento della documentazione di progetto, sui Diari di Bordo del periodo e sullo studio preliminare dei servizi AWS. Nel #emph[Backlog] sono state inoltre inserite alcune attività per le iterazioni future (#issue(90), #issue(91)).

#fonte_decisione([D12], [Introdurre la colonna «Backlog» sulla Project Board, chiudere lo Sprint 1 e avviare lo Sprint 2 aggiornando la dashboard di progetto e pianificando le attività di gestione del periodo (tra cui i Diari di Bordo).])

#pagebreak()

= Tracciamento Azioni

#tabella_decisioni(
  (id: [D9], azioni: (
      (azione: [Iniziare il documento Piano di Progetto], issue: [#issue(85)], ass: [Godwin Agbleze], ver: [Nikola Miljanovic], scad: [2026-11-27]),
  )),
  (id: [D10], azioni: (
      (azione: [Continuare con l'Analisi dei Requisiti], issue: [#issue(89)], ass: [Giacomo Ravazzolo, Mattia Pasquato], ver: [Nikola Miljanovic], scad: [2026-12-02]),
      (azione: [Proseguire con le Norme di Progetto], issue: [#issue(88)], ass: [Carlo Nardin], ver: [Nikola Miljanovic], scad: [2026-12-02]),
  )),
  (id: [D11], azioni: (
      (azione: [Revisione flusso di versionamento documenti], issue: [#issue(93)], ass: [Mattia Scomparin], ver: [Nikola Miljanovic], scad: [2026-11-26]),
  )),
  (id: [D12], azioni: (
      (azione: [Aggiornare dashboard per chiusura Sprint 1 e inizio Sprint 2], issue: [#issue(95)], ass: [Mattia Scomparin], ver: [Nikola Miljanovic], scad: [2026-11-22]),
      (azione: [Preparare Diario di Bordo per il 2026-11-23], issue: [#issue(84)], ass: [Mattia Scomparin], ver: [Nikola Miljanovic], scad: [2026-11-23]),
      (azione: [Preparare Diario di Bordo per il 2026-11-30], issue: [#issue(92)], ass: [Carlo Nardin], ver: [Nikola Miljanovic], scad: [2026-11-30]),
  )),
)

= Tracciamento Decisioni Precedenti

#tabella_decisioni_precedenti(
  (id: [D2], azioni: (
      (azione: [Definire le milestone di progetto], issue: [#issue(69)], stato: [Completato]),
  )),
  (id: [D4], azioni: (
      (azione: [Analisi dettagliata delle tecnologie del capitolato aggiudicato (C5)], issue: [#issue(72)], stato: [Completato]),
  )),
  (id: [D6], azioni: (
      (azione: [Restyling del diario di bordo], issue: [#issue(77)], stato: [Completato]),
  )),
  (id: [D7], azioni: (
      (azione: [Inviare email a Miriade Srl per comunicare l'adesione alle attività proposte], issue: [#issue(86)], stato: [Completato]),
  )),
  (id: [D8], azioni: (
      (azione: [Creare documento di base interno per lo studio dei servizi AWS citati nel capitolato], issue: [#issue(87)], stato: [In Corso]),
  )),
)

*Prossimo incontro:* 2026-11-26 alle 18:30 su Google Meet.

