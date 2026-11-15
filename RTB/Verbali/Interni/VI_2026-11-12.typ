#import "../template.typ": *

#show: verbale.with(
  titolo: "Verbale Incontro #6",
  data: "2026-11-12",
  versione: "0.1.0",
  uso: "Interno",
  redattore: "Nikola Miljanovic",
  verificatore: "Mattia Scomparin",
  destinatari: ("Prof. Tullio Vardanega", "Prof. Riccardo Cardin",),
  riassunto: "Brevi considerazioni sull'andamento dello sprint. Discussione in merito a struttura dei verbali e formato delle versioni nei file. Presentazione della prima bozza del glossario e del nuovo template del diario di bordo.",
  registro_modifiche: (
    ("0.1.0", "2026-11-14", "Nikola Miljanovic", "Mattia Scomparin", "Prima stesura"),
  ),
)

= Informazioni generali

== Luogo e data della riunione

- *Luogo*: Google Meet
- *Data*: 2026-11-12
- *Ora*: 18:30
- *Durata*: 50 minuti

== Partecipanti

- Godwin Agbleze
- Mattia Pasquato
- Giacomo Ravazzolo
- Nikola Miljanovic
- Mattia Scomparin
- Carlo Nardin

= Ordine del giorno

+ Considerazioni sull'andamento dello sprint.
+ Analisi della nuova tabella per il tracciamento delle azioni e nuovo sistema di versionamento.
+ Presentazione della prima versione del glossario.
+ Illustrazione del nuovo template per il diario di bordo.

= Discussione

== Andamento dello sprint corrente

Il responsabile Giacomo Ravazzolo apre la riunione chiamando il gruppo a esporre dubbi o difficoltà incontrate durante la prima metà dello sprint per affrontarne insieme la discussione e risolvere eventuali problemi.
Non essendo state segnalate criticità bloccanti, il confronto si sposta sulla revisione della board di progetto e delle issue aperte.
Il responsabile sottolinea quindi l'urgenza di avviare concretamente la stesura delle norme di progetto per formalizzare il "#emph[way of working]" del team, richiamando infine l'attenzione sull'analisi dei requisiti e delle tecnologie in vista del prossimo incontro con la proponente Miriade.

== Modifiche alla struttura dei verbali

Nikola Miljanovic presenta al gruppo la nuova struttura dei verbali, rivista per risolvere le criticità emerse a seguito  della valutazione della candidatura. Il formato aggiornato mette in risalto le decisioni prese e, grazie a una tabella di tracciamento riorganizzata, consente di collegare ciascuna delibera alle relative azioni e alle corrispondenti issue su GitHub.
Nikola Miljanovic propone inoltre un nuovo schema di versionamento per la documentazione al fine di riservare la release 1.0.0 al momento dell'approvazione da parte del responsabile. Il formato delle versioni sarà del tipo #strong[X.Y.Z] dove:

- Gli incrementi di #strong[X] (#strong[#emph[major changes]]) indicano modifiche sostanziali del file non retrocompatibili con le versioni precedenti.
- Gli incrementi di #strong[Y] (#strong[#emph[minor changes]]) rappresentano modifiche minori retrocompatibili con le versioni precedenti.
- Gli incrementi di #strong[Z] (#strong[#emph[patch]]) tracciano correzioni e hotfix.

== Presentazione del glossario

L'amministratore Nikola Miljanovic presenta al gruppo la struttura iniziale del glossario, destinato a essere integrato nella vista web della documentazione non appena sarà completato il primo lotto di voci. Segue un confronto sulla sezione introduttiva del documento e sulle modalità grafiche per evidenziare i lemmi all'interno del resto della documentazione di progetto.
Gli analisti Carlo Nardin e Godwin Agbleze comunicano a Nikola Miljanovic di aver già individuato, durante la fase iniziale dello studio dei requisiti e delle tecnologie del capitolato aggiudicato, diversi vocaboli tecnici pronti per essere catalogati.

== Restyling del diario di bordo

La riunione prosegue con l'analisi delle osservazioni rivolte dal committente a diversi gruppi durante la presentazione del diario di bordo di lunedì 9 novembre. È emerso infatti che l'impaginazione attuale gestisce male le proporzioni, attirando l'occhio del lettore sulle aree vuote anziché sui contenuti effettivi. Al termine del confronto, il team definisce il nuovo stile grafico, che verrà adottato a partire dal prossimo incontro di lunedì 16 novembre.

#fonte_decisione([D1], [Modificare il template del diario di bordo per gestire meglio le proporzioni.])

= Tracciamento Azioni

#tabella_decisioni(
  (id: [D6], azioni: (
      (azione: [Restyling del diario di bordo], issue: [#issue(77)], ass: [Nikola Miljanovic], ver: [Mattia Scomparin], scad: [2026-11-16]),
  )),
)

= Tracciamento Decisioni Precedenti

#tabella_decisioni_precedenti(
  (id: [D1], azioni: (
      (azione: [Modifica della struttura tabella di tracciamento], issue: [#issue(70)], stato: [Completato]),
  )),
  (id: [D2], azioni: (
      (azione: [Definire le milestone di progetto], issue: [#issue(69)], stato: [In Corso]),
      (azione: [Aggiungere colonna "Ready for Release"], issue: [#issue(67)], stato: [Completato]),
  )),
  (id: [D3], azioni: (
      (azione: [Aggiungere dashboard al sito web della documentazione], issue: [#issue(65)], stato: [Completato]),
  )),
  (id: [D4], azioni: (
      (azione: [Analisi dettagliata delle tecnologie del capitolato aggiudicato (C5)], issue: [#issue(72)], stato: [In Corso]),
  )),
  (id: [D5], azioni: (
      (azione: [Invio mail a Miriade], issue: [#issue(64)], stato: [Completato]),
  )),
)

*Prossimo incontro:* 2026-11-19 su Google Meet.
