#import "../template.typ": *

#show: verbale.with(
  titolo: "Verbale Incontro #2",
  data: "2026-10-20",
  versione: "1.0.0",
  uso: "Interno",
  redattore: "Carlo Nardin",
  verificatore: "Giacomo Ravazzolo",
  riassunto: "Confronto sulle analisi dei capitolati e individuazione di quelli di maggiore interesse. Organizzazione iniziale del lavoro per la candidatura e per il Diario di Bordo.",
  registro_modifiche: (
    ([1.0.0], [2026-10-21], [Carlo Nardin], [Giacomo Ravazzolo], [- Prima stesura del verbale]),
  )
)

= Informazioni generali
== Luogo e data della riunione
- *Luogo*: Google Meet
- *Data*: 2026-10-20
- *Ora*: 18:30
- *Durata*: 2 ore

== Partecipanti
- Godwin Agbleze
- Nikola Miljanovic
- Carlo Nardin
- Mattia Pasquato
- Giacomo Ravazzolo
- Mattia Scomparin

= Ordine del giorno
+ Confronto sulle analisi dei capitolati e raccolta delle domande per i proponenti.
+ Approvazione del verbale precedente.
+ Organizzazione della repository e della documentazione (GitHub Pages).
+ Pianificazione dei documenti di candidatura e del Diario di Bordo (2026-10-26).

= Discussione
== Capitolati e domande ai proponenti
Le analisi individuali dei capitolati sono state confrontate. I capitolati di maggiore interesse per il gruppo sono *C0*, *C5* e *C7*. Le prime domande emerse durante la lettura sono state discusse oralmente.

Per gli incontri con i proponenti, le domande saranno raccolte in un unico elenco condiviso, così da evitare richieste duplicate alle aziende.

I capitolati sono stati divisi in tre blocchi (C0–C2, C3–C5, C6–C9). Ogni blocco è assegnato a un redattore e a un verificatore, come indicato nel Tracciamento Azioni. I tre redattori (Giacomo Ravazzolo, Nikola Miljanovic, Godwin Agbleze) si coordineranno per far confluire i contributi in un unico documento di valutazione.

== Ruoli e Diario di Bordo
La definizione dei ruoli e delle regole di rotazione è rimandata a dopo gli incontri con i proponenti.

Giacomo Ravazzolo si è proposto per preparare la presentazione del Diario di Bordo del 2026-10-26.

== Documentazione e Repository
La struttura del verbale del primo incontro è adottata come template per i verbali futuri.

La documentazione sarà pubblicata tramite GitHub Pages, per renderla facilmente consultabile.

Sulla repository sono state create le issue per i documenti necessari alla candidatura. La board delle issue verrà riorganizzata, con l'aggiunta dei campi necessari al tracciamento dei task.

= Tracciamento Azioni

#tabella_azioni(
  issue(1), [Organizzazione incontri e raccolta delle domande], [Mattia Scomparin], [Carlo Nardin],
  issue(2), [Creazione Verbale Secondo Incontro], [Carlo Nardin], [Giacomo Ravazzolo],
  issue(3), [Redazione Lettera di Presentazione], [Mattia Pasquato], [Carlo Nardin],
  issue(5), [Predisposizione GitHub Pages], [Carlo Nardin], [Mattia Pasquato],
  issue(7), [Sistemazione Board e campi Issue], [Mattia Pasquato], [Giacomo Ravazzolo],
  issue(8), [Presentazione Diario di Bordo], [Giacomo Ravazzolo], [Nikola Miljanovic],
  issue(9), [Redazione Documento Valutazione Capitolati - C0 C1 C2], [Giacomo Ravazzolo], [Mattia Scomparin],
  issue(10), [Redazione Documento Valutazione Capitolati - C3 C4 C5], [Nikola Miljanovic], [Godwin Agbleze],
  issue(11), [Redazione Documento Valutazione Capitolati - C6 C7 C8 C9], [Godwin Agbleze], [Mattia Scomparin]
)

#v(1cm)
*Prossimo incontro:* 2026-10-24, su Google Meet.
