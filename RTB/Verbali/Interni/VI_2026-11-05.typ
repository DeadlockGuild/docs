#import "../template.typ": *

#show: verbale.with(
  titolo: "Verbale Incontro #5",
  data: "2026-11-05",
  versione: "0.1.2",
  uso: "Interno",
  redattore: "Nikola Miljanovic",
  verificatore: "Mattia Scomparin",
  destinatari: ("Prof. Tullio Vardanega", "Prof. Riccardo Cardin",),
  riassunto: "Considerazioni generali a seguito dell'aggiudicazione dell'appalto. Riflessioni sulle correzioni del committente in merito alla candidatura. Discussione sulla rotazione e assegnazione dei ruoli e frequenza degli incontri.",
  registro_modifiche: (
    ("0.1.2", "2026-11-11", "Nikola Miljanovic", "Mattia Scomparin", "Corretto formato della versione"),
    ("0.1.1", "2026-11-10", "Nikola Miljanovic", "Mattia Scomparin", "Correzioni minori"),
    ("0.1.0", "2026-11-06", "Nikola Miljanovic", "Mattia Scomparin", "Prima stesura"),
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

== Valutazione del committente

Il gruppo ha discusso attivamente in merito alla valutazione e alle correzioni del prof. Vardanega relative alla candidatura presentata per il capitolato C5. L'esito della domanda è stato più che positivo, portando alla conseguente aggiudicazione dell'appalto. La discussione si è soffermata, in particolare, sul commento del committente riguardo alla struttura della tabella per il tracciamento delle azioni contenuta nei verbali. A questo proposito, il gruppo si è prefissato di procedere a un'analisi e a una ristrutturazione della stessa, sulla base delle indicazioni fornite. La nuova struttura sarà adottata a partire dal presente verbale.

#fonte_decisione([D1], [Necessità di modificare la struttura della tabella per il tracciamento delle azioni.])

== Assegnazione e rotazione dei ruoli

In vista dell'effettivo inizio dei lavori e dell'avvio del primo sprint, è stato necessario definire la suddivisione iniziale dei ruoli. Il gruppo ha accolto il consiglio del committente in merito alla flessibilità degli stessi: qualora necessario, in base allo stato attuale del progetto e al grado di avanzamento, verrà valutata di volta in volta una possibile rimodulazione delle ore assegnate ai vari incarichi. In questa fase iniziale è stata concordata all'unanimità la necessità di un maggior coinvolgimento degli analisti e degli amministratori per lo studio preliminare delle tecnologie e per la predisposizione dell'ambiente di lavoro. La discussione ha portato alle seguenti assegnazioni:

- #strong[1] responsabile
- #strong[2] amministratori
- #strong[2] analisti
- #strong[1] verificatore

Le regole di rotazione dei ruoli rimangono, attualmente, quelle già definite nel documento "Preventivo Costi e Dichiarazione Impegni" pubblico sul sito ufficiale della documentazione del gruppo.

== Frequenza degli incontri

Per garantire un livello ottimale di aggiornamento ed evitare, al contempo, di sovraccaricare il gruppo con riunioni eccessivamente lunghe, è stato concordato lo svolgimento di un incontro infrasettimanale, fissato per il giovedì alle 18:30 circa, concepito come un "veloce meeting di aggiornamento". Qualora la situazione lo richieda, sarà comunque possibile organizzare ulteriori sedute straordinarie.

== Analisi board di progetto

Tema centrale della riunione è stata la discussione sulla board di progetto e l'inserimento delle nuove issue per lo sprint corrente.
Mattia Pasquato ha sollevato la necessità di inserire una nuova voce nel workflow che rifletta l'atto di approvazione al rilascio come decisione autocratica del responsabile, si è deciso quindi di aggiungere un'ulteriore colonna nella board di progetto denominata "Ready for Release" per permettere il controllo e approvazione finale.
È stata inoltre recepita la direttiva del prof. Vardanega di definire formalmente le milestone di progetto e, a tal proposito, unitamente al bisogno di tracciare le ore di progetto si è deciso di implementare una dashboard grafica a cura di Mattia Pasquato.

#fonte_decisione([D2], [È necessario definire le milestone di progetto.])

#fonte_decisione([D3], [Aggiungere dashboard alla vista web per la documentazione di gruppo.])

== Analisi approfondita e primi contatti post-aggiudicazione

La prima fase del progetto, successiva all'aggiudicazione del capitolato, richiede un iniziale e intenso lavoro di analisi che sarà svolto dagli analisti incaricati Carlo Nardin e Godwin Agbleze; a tal fine saranno utilizzati i contenuti forniti nel capitolato da Miriade e le risposte date dall'azienda in sede di primo incontro Q&A.
Si è inoltre deciso di inviare un'email ai referenti di Miriade per confermare l'aggiudicazione e definire le modalità dell'incontro di formazione tecnologica e di contesto offerto a supporto del progetto.

#fonte_decisione([D4], [È necessario svolgere un primo lavoro di analisi approfondita delle tecnologie in vista della riunione con Miriade.])

#fonte_decisione([D5], [Il responsabile invia la mail di conferma dell'aggiudicazione dell'appalto e richiede la possibilità di fissare il meeting di formazione.])

#pagebreak()

= Tracciamento azioni

#tabella_decisioni(
  (id: [D1], azioni: (
      (azione: [Modifica della struttura tabella di tracciamento], issue: [#issue(70)], ass: [Nikola Miljanovic], ver: [Mattia Scomparin], scad: [-]),
  )),
  (id: [D2], azioni: (
      (azione: [Definire le milestone di progetto], issue: [#issue(69)], ass: [Mattia Pasquato], ver: [Mattia Scomparin], scad: [-]),
      (azione: [Aggiungere colonna "Ready for Release"], issue: [#issue(67)], ass: [Mattia Pasquato], ver: [Mattia Scomparin], scad: [-]),
  )),
  (id: [D3], azioni: (
      (azione: [Aggiungere dashboard al sito web della documentazione], issue: [#issue(65)], ass: [Mattia Pasquato], ver: [Mattia Scomparin], scad: [-]),
  )),
  (id: [D4], azioni: (
      (azione: [Analisi dettagliata delle tecnologie del capitolato aggiudicato (C5)], issue: [#issue(72)], ass: [Carlo Nardin e Godwin Agbleze], ver: [Mattia Scomparin], scad: [-]),
  )),
  (id: [D5], azioni: (
      (azione: [Invio mail a Miriade], issue: [#issue(64)], ass: [Giacomo Ravazzolo], ver: [Mattia Scomparin], scad: [-]),
  )),
)

= Tracciamento decisioni precedenti

Nessuna decisione precedente da tracciare.

*Prossimo incontro:* 2026-11-12 alle 18:30 su Google Meet.
