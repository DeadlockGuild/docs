#import "../template.typ": *

#show: verbale.with(
  titolo: "Verbale Incontro #1",
  data: "2027-10-14",
  versione: "1.0.0",
  uso: "Interno",
  redattore: "Carlo Nardin",
  verificatore: "Giacomo Ravazzolo",
  riassunto: "Incontro conoscitivo iniziale. Analisi delle disponibilità orarie, prima valutazione dei capitolati, definizione degli strumenti operativi e assegnazione prime task.",
  registro_modifiche: (
    ([1.0.0], [2027-10-18], [Carlo Nardin], [Giacomo Ravazzolo], [- Prima stesura del verbale]),
  )
)

= Informazioni generali
== Luogo e data della riunione
- *Luogo*: Google Meet
- *Data*: 2027-10-14
- *Ora*: 15:00
- *Durata*: 1 ora

== Partecipanti
- Godwin Agbleze
- Nikola Miljanovic
- Carlo Nardin
- Mattia Pasquato
- Giacomo Ravazzolo
- Mattia Scomparin

= Ordine del giorno
+ Conoscenza reciproca e allineamento sulle disponibilità temporali.
+ Valutazione preliminare dei capitolati d'appalto.
+ Scelta strumenti organizzativi e operativi.

= Discussione
== Disponibilità e impegni
Confronto conoscitivo iniziale per condividere la situazione universitaria ed extra-accademica. Questo ha permesso di stimare il tempo effettivo a disposizione di ciascuno, ponendo attenzione alle esigenze degli studenti-lavoratori per una pianificazione sostenibile.

== Valutazione Capitolati
A seguito delle presentazioni in aula, il gruppo ha condiviso le prime impressioni. È stato stabilito l'obiettivo di analizzare approfonditamente i documenti dei vari capitolati proposti prima di formulare ipotesi o prendere decisioni.

== Strumenti e Organizzazione
Il gruppo ha definito il proprio nome e stabilito gli strumenti operativi:
- *Gmail*: fornitore recapito posta elettronica.
- *Telegram*: comunicazioni interne.
- *GitHub*: repository di progetto.
- *Typst*: redazione della documentazione di progetto.

= Tracciamento Azioni

#table(
  columns: (1fr, auto, auto),
  align: left,
  stroke: 0.5pt + luma(200),
  fill: (col, row) => if row == 0 { rgb("#c85815") } else if calc.rem(row, 2) == 0 { luma(245) } else { white },
  
  text(fill: white, weight: "bold")[Titolo], 
  text(fill: white, weight: "bold")[Assegnatario], 
  text(fill: white, weight: "bold")[Verificatore],
  
  [Analisi approfondita dei capitolati], [Team], [-],
  [Creazione bozze per il logo], [Nikola Miljanovic], [Godwin Agbleze],
  [Creazione Gmail e Repo GitHub], [Mattia Pasquato], [Mattia Scomparin],
  [Stesura Verbale 2027-10-14], [Carlo Nardin], [Giacomo Ravazzolo]
)

#v(1cm)
*Prossimo incontro:* 2027-10-20 su Google Meet.
