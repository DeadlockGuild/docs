#import "../Verbali/template.typ": *

#show: lettera.with(
  titolo: "Valutazione costi e ore",
  data: "2026-10-26",
)

// Link allo strumento di stima (lo stesso della sezione Tools del sito)
#let linkTool = "https://deadlockguild.github.io/docs/Candidatura/toolStimaOreECosti/stima_ore.html"

// Parametri fissi del progetto
#let componenti = 6
#let oreMinPersona = 80
#let oreMaxPersona = 95
#let costoMinimo = 12000 * 6 / 7

// Ruoli: costo orario, ore pianificate e colore nel grafico
#let ruoli = (
  (nome: "Responsabile", descrizione: "Coordina piani, scadenze e attività del gruppo; approva i rilasci", costo: 30, ore: 60, colore: rgb("#2a78d6")),
  (nome: "Amministratore", descrizione: "Assicura l'efficienza di procedure, strumenti e tecnologie del way of working", costo: 20, ore: 48, colore: rgb("#eb6834")),
  (nome: "Analista", descrizione: "Svolge le attività di analisi dei requisiti", costo: 25, ore: 78, colore: rgb("#1baf7a")),
  (nome: "Progettista", descrizione: "Svolge le attività di progettazione (design)", costo: 25, ore: 108, colore: rgb("#eda100")),
  (nome: "Programmatore", descrizione: "Svolge le attività di codifica", costo: 15, ore: 138, colore: rgb("#e87ba4")),
  (nome: "Verificatore", descrizione: "Svolge le attività di verifica", costo: 15, ore: 114, colore: rgb("#008300")),
)

#let arancione = rgb("#c85815")
#let verde = rgb("#2e8540")
#let grigio = luma(110)

// Valori derivati
#let oreTotali = ruoli.map(r => r.ore).sum()
#let costoTotale = ruoli.map(r => r.ore * r.costo).sum()
#let oreMin = oreMinPersona * componenti
#let oreMax = oreMaxPersona * componenti

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

// Indicatore orizzontale: fascia valida in verde, cursore sul valore attuale
#let indicatore(valore, minimo, massimo, fondoScala, etichetta, tacche) = {
  let x(v) = v / fondoScala * 100%
  let fine = if massimo == none { fondoScala } else { massimo }
  block(width: 100%, height: 46pt, {
    place(top + left, dy: 16pt, box(width: 100%, height: 10pt, radius: 5pt, fill: luma(233)))
    place(top + left, dx: x(minimo), dy: 16pt, box(
      width: x(fine - minimo),
      height: 10pt,
      fill: verde.lighten(80%),
      stroke: (left: 1.5pt + verde, right: if massimo == none { none } else { 1.5pt + verde }),
    ))
    place(top + left, dy: 19.5pt, box(width: x(valore), height: 3pt, radius: 1.5pt, fill: verde))
    place(top + left, dx: x(valore) - 1.5pt, dy: 11pt, box(width: 3pt, height: 20pt, radius: 1.5pt, fill: verde))
    place(top + left, dx: x(valore) - 50pt, dy: 0pt, box(width: 100pt, align(center, text(size: 8pt, weight: "bold", fill: verde, etichetta))))
    for (v, testo) in tacche {
      place(top + left, dx: x(v) - 40pt, dy: 33pt, box(width: 80pt, align(center, text(size: 7pt, fill: grigio, testo))))
    }
  })
}

// Riquadro con tre valori sintetici
#let valori(..coppie) = grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 6pt,
  ..coppie.pos().map(((etichetta, valore)) => [
    #text(size: 8pt, fill: grigio, etichetta) \
    #box(text(size: 11pt, weight: "bold", valore))
  ])
)

#let stato(testo) = block(
  width: 100%,
  inset: (x: 8pt, y: 6pt),
  radius: 4pt,
  fill: verde.lighten(85%),
  text(size: 9pt, weight: "bold", fill: verde, testo),
)

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

= Scopo del documento

Il presente documento riporta la stima delle ore e dei costi del progetto prodotta dal gruppo *DeadlockGuild* per il capitolato *C5 -- RareCare*. La stima è stata calcolata con lo strumento interno di valutazione, consultabile all'indirizzo:

#align(center, link(linkTool)[Strumento di stima ore e costi])

I valori riportati di seguito sono fissi e corrispondono alla configurazione adottata per la candidatura.

= Vincoli di partenza

- *Componenti del gruppo*: #componenti.
- *Ore per componente*: da #oreMinPersona a #oreMaxPersona, per un range complessivo di *#oreMin–#oreMax ore*.
- *Costo minimo del progetto*: *#euro(costoMinimo)*, pari a 6/7 di 12.000 €.
- *Costo orario per ruolo*: fissato dal regolamento del progetto didattico, come riportato nella tabella seguente.

= Ore e costi per ruolo

#figure(
  table(
    columns: (1fr, auto, auto, auto),
    align: (left + horizon, right + horizon, right + horizon, right + horizon),
    inset: 6pt,
    stroke: 0.5pt + luma(200),
    fill: (col, row) => if row == 0 { arancione } else if calc.rem(row, 2) == 0 { luma(245) } else { white },
    table.header(..intestazioneTabella[Ruolo][€/h][Ore][Totale]),
    ..ruoli.map(r => (
      [*#r.nome* \ #text(size: 8pt, fill: grigio, r.descrizione)],
      str(r.costo),
      str(r.ore),
      euro(r.ore * r.costo),
    )).flatten(),
    table.cell(fill: white)[*Totale*],
    table.cell(fill: white)[],
    table.cell(fill: white)[*#oreTotali h*],
    table.cell(fill: white, text(weight: "bold", fill: arancione, euro(costoTotale))),
  ),
  caption: [Ore e costi pianificati per ruolo],
)

= Verifica dei vincoli

#block(breakable: false, grid(
  columns: (1fr, 1fr),
  gutter: 14pt,
  block(width: 100%, inset: 10pt, radius: 6pt, stroke: 0.5pt + luma(200))[
    *Ore*
    #v(2pt)
    #valori(
      ("Pianificate", [#oreTotali h]),
      ("Media a persona", [#calc.round(oreTotali / componenti) h]),
      ("Range", [#oreMin–#oreMax h]),
    )
    #indicatore(
      oreTotali, oreMin, oreMax, oreMax * 1.25, [#oreTotali h],
      ((oreMin, str(oreMin)), (oreMax, str(oreMax))),
    )
    #stato[Dentro il range: margine di #(oreMax - oreTotali) h]
  ],
  block(width: 100%, inset: 10pt, radius: 6pt, stroke: 0.5pt + luma(200))[
    *Costo*
    #v(2pt)
    #valori(
      ("Pianificato", euro(costoTotale)),
      ("Medio orario", euro(costoTotale / oreTotali)),
      ("Differenza", "+" + euro(costoTotale - costoMinimo)),
    )
    #indicatore(
      costoTotale, costoMinimo, none, costoMinimo * 1.3, euro(costoTotale),
      ((costoMinimo, euro(costoMinimo)),),
    )
    #stato[Minimo raggiunto: #euro(costoTotale - costoMinimo) sopra]
  ],
))

Le ore pianificate rientrano nel range consentito e il costo complessivo supera il costo minimo previsto.

= Ripartizione delle ore per ruolo

#figure(
  kind: image,
  grid(
    columns: (150pt, 1fr),
    gutter: 24pt,
    align: horizon,
    ciambella(ruoli.map(r => (valore: r.ore, colore: r.colore))),
    table(
      columns: (auto, 1fr, auto, auto),
      align: (center + horizon, left + horizon, right + horizon, right + horizon),
      inset: 5pt,
      stroke: (x, y) => (bottom: 0.5pt + luma(220)),
      ..ruoli.map(r => (
        box(width: 8pt, height: 8pt, radius: 2pt, fill: r.colore),
        r.nome,
        [#r.ore h],
        text(weight: "bold", percento(r.ore / oreTotali)),
      )).flatten(),
    ),
  ),
  caption: [Percentuale di ore per ruolo sul totale di #oreTotali ore],
)
