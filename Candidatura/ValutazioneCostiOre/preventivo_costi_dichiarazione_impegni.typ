#import "../Verbali/template.typ": *
#set heading(supplement: [])

#show: verbale.with(
  titolo: "Preventivo costi e dichiarazione impegni",
  data: "2026-10-26",
  redattore: [
    Mattia Pasquato \
    Giacomo Ravazzolo
  ],
  verificatore: [
    Carlo Nardin\
    Godwin Agbleze
  ],
  registro_modifiche: (
    ([1.0.3], [2026-10-29], [Mattia Pasquato], [Carlo Nardin], [- Correzioni varie]),
    ([1.0.2], [2026-10-29], [Ravazzolo Giacomo], [Carlo Nardin], [- Correzione Tabella 1 e Grafico 1 e aggiunta in sezione @4]),
    ([1.0.1], [2026-10-28], [Ravazzolo Giacomo], [Godwin Agbleze], [- Stesura delle sezioni @3, @4 e @5]),
    ([1.0.0], [2026-10-26], [Mattia Pasquato], [Godwin Agbleze], [- Stesura delle sezioni @1, @2 e @6]),
  )
)

//Link allo strumento di stima
#let linkTool = "https://deadlockguild.github.io/docs/Candidatura/toolStimaOreECosti/stima_ore.html"

// Ruoli: costo orario, ore pianificate e colore nel grafico
#let ruoli = (
  (nome: "Responsabile", costo: 30, ore: 54, colore: rgb("#168aad")),
  (nome: "Amministratore", costo: 20, ore: 48, colore: rgb("#2a9d8f")),
  (nome: "Analista", costo: 25, ore: 90, colore: rgb("#e9c46a")),
  (nome: "Progettista", costo: 25, ore: 108, colore: rgb("#f4a261")),
  (nome: "Programmatore", costo: 15, ore: 132, colore: rgb("#e76f51")),
  (nome: "Verificatore", costo: 15, ore: 114, colore: rgb("#4a6fa5")),
)

#let componenti = 6
#let arancione = rgb("#c85815")
#let grigio = luma(110)

// Valori derivati
#let oreTotali = ruoli.map(r => r.ore).sum()
#let costoTotale = ruoli.map(r => r.ore * r.costo).sum()

// Formattazione numeri all'italiana: 11190 -> "11.190", 11190.0 -> "11.190,00 €"
#let migliaia(n) = {
  let s = str(n)
  let cifre = s.clusters()
  let out = ""
  for (i, c) in cifre.enumerate() {
    if i > 0 and calc.rem(cifre.len() - i, 3) == 0 { out += "." }
    out += c
  }
  out
}
#let euro(x) = {
  let centesimi = int(calc.round(x * 100))
  let decimali = calc.rem(centesimi, 100)
  migliaia(calc.div-euclid(centesimi, 100)) + "," + (if decimali < 10 { "0" } else { "" }) + str(decimali) + " €"
}
#let percento(quota) = {
  let decimi = int(calc.round(quota * 1000))
  str(calc.div-euclid(decimi, 10)) + "," + str(calc.rem(decimi, 10)) + "%"
}

// Grafico a ciambella: ogni fetta è un poligono che approssima l'arco
#let ciambella(dati, diametro: 150pt, spessore: 0.33) = {
  let r = diametro / 2
  let ri = r * (1 - spessore)
  let totale = dati.map(d => d.valore).sum()
  let punto(raggio, angolo) = (r + raggio * calc.sin(angolo), r - raggio * calc.cos(angolo))
  box(width: diametro, height: diametro, {
    let inizio = 0deg
    for d in dati {
      let ampiezza = d.valore / totale * 360deg
      let passi = calc.max(2, int(calc.ceil(ampiezza / 2deg)))
      let esterno = range(passi + 1).map(i => punto(r, inizio + ampiezza * i / passi))
      let interno = range(passi + 1).rev().map(i => punto(ri, inizio + ampiezza * i / passi))
      place(top + left, polygon(fill: d.colore, stroke: 1.5pt + white, ..esterno, ..interno))
      inizio += ampiezza
    }
    place(center + horizon, align(center)[
      #text(size: 16pt, weight: "bold")[#oreTotali h] \
      #text(size: 8pt, fill: grigio)[ore totali]
    ])
  })
}

#let intestazioneTabella(..celle) = celle.pos().map(c => text(fill: white, weight: "bold", size: 9pt, c))

= Scopo del documento <1>

Il presente documento riporta la stima delle ore e dei costi compiuta dal gruppo *DeadlockGuild* per la realizzazione del progetto relativo al capitolato *C5 -- RareCare*. Al suo interno trovano spazio la descrizione dei ruoli di progetto e dei relativi compiti, la ripartizione oraria complessiva e individuale e l'analisi dei potenziali rischi con le relative strategie di mitigazione.

= Presentazione dei ruoli <2>
Il progetto prevede diversi ruoli, ciascuno con responsabilità e competenze specifiche, descritti di seguito.

== Responsabile
Il responsabile governa il team e rappresenta il progetto verso l’esterno, assume la responsabilità di scelta e di approvazione e partecipa al progetto per tutta la sua durata. Ha responsabilità di pianificazione e di gestione delle risorse, di controllo e di coordinamento delle relazioni con l’esterno. Deve possedere le capacità tecniche e le conoscenze necessarie per valutare rischi, scelte e alternative, assicurandosi che il progetto venga portato a termine nei tempi stabiliti e in conformità con le risorse assegnate.

== Amministratore
L’amministratore cura la configurazione e la gestione dell’infrastruttura e degli strumenti necessari al team. Assicura l’efficienza delle procedure e del way of working con un approccio proattivo volto a prevenire problemi e a supportare il flusso di lavoro. Il suo contributo è previsto prevalentemente nelle fasi iniziali di allestimento dell'ambiente di lavoro, per poi assestarsi su un impegno di mantenimento man mano che le attività proseguono.

== Analista
L’analista ricopre un ruolo fondamentale per il successo del progetto, poiché si occupa di comprendere il problema e di svolgere l'analisi dei requisiti software. Conosce in modo approfondito il dominio di riferimento e traduce le opportunità in requisiti chiari e definiti. Il suo lavoro si concentra principalmente nella fase iniziale del progetto, momento in cui occorre definire nel dettaglio ciò che il software dovrà realizzare.

== Progettista
Il progettista è responsabile della progettazione tecnica del sistema e della definizione dell'architettura software, identificandone le componenti e le relative relazioni sulla base dei requisiti stabiliti dall'analista. Possiede competenze tecniche aggiornate e determina le scelte realizzative per individuare la soluzione più efficiente ed efficace.

== Programmatore
Il programmatore è responsabile della scrittura del codice, seguendo le specifiche fornite dai progettisti. Utilizza le proprie competenze tecniche per la realizzazione e la manutenzione del prodotto, operando con un'autonomia limitata sulle decisioni architetturali.

== Verificatore
Il verificatore accompagna il progetto per tutta la sua durata e unisce competenze tecniche, esperienza professionale e conoscenza del way of working a buone capacità di giudizio e di relazione. Si occupa del controllo qualità, verificando che codice e documentazione rispettino gli standard di programmazione e i requisiti specificati.

= Preventivo dei costi <3>
Ogni componente del gruppo *DeadlockGuild* si impegna a dedicare 91 ore produttive al progetto, per un totale complessivo di 546 ore. Sulla base di questo impegno è stato elaborato il preventivo, che suddivide equamente il monte ore tra i ruoli necessari alla realizzazione del progetto.\
È possibile verificare i dati e testare i calcoli in tempo reale tramite il #link(linkTool)[tool interattivo di stima online].

#figure(
  table(
    columns: (1fr, auto, auto, auto, auto),
    align: (left + horizon, right + horizon, right + horizon, right + horizon, right + horizon),
    inset: 8pt,
    stroke: 0.5pt + black,
    fill: (col, row) => if row == 0 { arancione } else { white },
    
    table.header(..intestazioneTabella[Ruolo][Costo orario][Ore per ruolo][Ore per membro][Costo totale]),
    
    ..ruoli.map(r => (
      [*#r.nome*],
      str(r.costo) + " €/h",
      str(r.ore) + " h",
      str(calc.quo(r.ore, componenti)) + " h",
      euro(r.ore * r.costo),
    )).flatten(),

    table.cell(fill: white)[*Totale*],
    table.cell(fill: white)[],
    table.cell(fill: white)[*#oreTotali h*],
    table.cell(fill: white)[*#calc.quo(oreTotali, componenti) h*],
    table.cell(fill: white, text(weight: "bold", fill: arancione, euro(costoTotale))),
  ),
  caption: [Ripartizione di ore e costi, per ruolo e per persona],
)
\
Il grafico seguente mostra come si distribuiscono le 546 ore complessive tra i vari ruoli, in percentuale.

#figure(
  kind: image,
  grid(
    columns: (auto, auto),
    gutter: 16pt,
    align: horizon,
    ciambella(ruoli.map(r => (valore: r.ore, colore: r.colore))),
    table(
      columns: (auto, auto, auto),
      align: (center + horizon, left + horizon, right + horizon),
      inset: 5pt,
      stroke: none,
      ..ruoli.map(r => (
        box(width: 8pt, height: 8pt, radius: 2pt, fill: r.colore),
        [*#r.nome*],
        text(percento(r.ore / oreTotali)),
      )).flatten(),
    ),
  ),
)
\
= Rotazione dei ruoli <4>
Il gruppo adotta una metodologia agile e ruota i ruoli a ogni sprint, di durata iniziale pari a due settimane. Questo tempo permette a ciascun membro di apprendere il ruolo, approfondirlo e ottenere risultati concreti prima del cambio. La durata degli sprint potrà variare durante il progetto, ad esempio se i successivi raffinamenti mostrassero che un ritmo diverso è più efficace o se si presentassero imprevisti.

La rotazione dei ruoli segue queste regole:
- ogni membro dedica al progetto 91 ore produttive;
- le ore assegnate a ciascun ruolo non superano quelle stabilite nel preventivo;
- le ore di ciascun ruolo sono ripartite in modo il più possibile uniforme tra i membri, così che tutti ricoprano ogni ruolo almeno una volta;
- in ogni sprint è presente un solo responsabile;
- in ogni sprint ciascun membro ha un solo ruolo e non resta mai privo di incarico;
- un membro non riassume lo stesso ruolo in sprint ravvicinati;
- eventuali scostamenti di ore sono recuperati negli sprint successivi;
- all’inizio di ogni sprint il gruppo individua le attività da svolgere e le ore necessarie a ciascun ruolo per realizzarle.


= Analisi dei rischi <5>
Di seguito sono descritti i principali rischi individuati dal gruppo e le contromisure previste per ridurne l'impatto.

== Inesperienza e difficoltà di realizzazione
Progetti di questa portata possono risultare nuovi per il gruppo, e questo può causare stime errate, una comprensione incompleta dei requisiti o ritardi nelle attività. Per mitigare il rischio, chi ha più disponibilità affianca i colleghi in difficoltà, così da rispettare i tempi previsti. Inoltre, nelle riunioni il gruppo effettua una retrospettiva per analizzare le difficoltà e individuare come migliorare.

== Tecnologie sconosciute
Alcune delle tecnologie richieste dal progetto potrebbero non essere conosciute dai membri del gruppo, con il rischio di rallentamenti nelle attività di sviluppo. Per limitarlo, il gruppo dedica del tempo allo studio e alla sperimentazione di queste tecnologie, in modo da comprenderle e usarle correttamente, avvalendosi anche del supporto offerto dall'azienda proponente.

== Impegni personali
Nel corso del progetto possono presentarsi impegni esterni che riducono la disponibilità di un membro e ritardano le attività a lui assegnate. Per limitare questo rischio, il gruppo tiene conto di queste eventualità già in fase di pianificazione. Qualora un membro non riuscisse a svolgere le proprie attività, queste vengono temporaneamente ripartite tra gli altri componenti, e le ore mancanti vengono poi recuperate da chi si è assentato.

= Scadenza di consegna <6>
Alla luce delle analisi e delle valutazioni svolte, il costo complessivo del progetto risulta pari a *11.220,00 €*. Il gruppo *DeadlockGuild* si impegna a completare il capitolato *C5 -- RareCare* entro il *09/04/2027*. Rispetto alle 20 settimane di lavoro previste, sono state aggiunte delle settimane di riserva, destinate a far fronte a eventuali imprevisti e a garantire il rispetto dei tempi stabiliti.
