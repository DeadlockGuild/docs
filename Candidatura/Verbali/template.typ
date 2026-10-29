// template.typ

#let verbale(
  titolo: "",
  data: "",
  versione: "",
  uso: "Interno",
  redattore: "",
  verificatore: "",
  destinatari: ("Prof. Tullio Vardanega", "Prof. Riccardo Cardin"),
  riassunto: "",
  registro_modifiche: (),
  body
) = {
  set text(lang: "it", font: ("Atkinson Hyperlegible Next", "Liberation Sans"), weight: 400)
  show strong: set text(font: "Atkinson Hyperlegible Next", weight: 700)
  set page(margin: (x: 2.5cm, y: 2.5cm))
  set heading(numbering: "1.")
  set par(justify: true)
  set list(marker: [•])
  show link: it => text(fill: rgb("#c85815"), weight: "bold")[#it]

  // Copertina
  align(center)[
    #v(1cm)
    #figure(image("../../assets/logo_nobg.png", width: 35%), outlined: false, numbering: none)
    #v(0.5cm)
    #text(size: 14pt, weight: "bold")[UNIVERSITÀ DEGLI STUDI DI PADOVA] \
    #text(size: 12pt)[Corso di Laurea in Informatica] \
    #text(size: 12pt)[Ingegneria del Software -- A.A. 2026/2027]
    
    #v(1.2cm)
    #line(length: 100%, stroke: 1.5pt + rgb("#c85815"))
    #v(1.2cm)
    
    #par(justify: false, text(size: 28pt, font: "Montserrat", weight: 800, fill: rgb("#c85815"), hyphenate: false)[#titolo])
    #v(0.5cm)
    #text(size: 14pt)[Data: #data] \
    #text(size: 14pt)[Versione: #versione]
    
    #v(1.4cm)
    #grid(
      columns: (1fr, 1fr),
      align: (right, left),
      inset: (x: 10pt, y: 5pt),
      text(weight: "bold")[Uso:], uso,
      text(weight: "bold")[Redattore:], redattore,
      // Con più verificatori (array) l'etichetta passa al plurale
      ..if type(verificatore) == array {
        (text(weight: "bold")[Verificatori:], verificatore.join([\ ]))
      } else {
        (text(weight: "bold")[Verificatore:], verificatore)
      },
      text(weight: "bold")[Destinatari:], destinatari.join([\ ]),
    )
    
    #v(0.8cm)
    #line(length: 100%, stroke: 1.5pt + rgb("#c85815"))
    #v(0.8cm)
    
    #if riassunto != "" [
      #text(size: 14pt, weight: "bold")[Riassunto del verbale] \
      #v(0.1em)
      #text(size: 12pt)[#riassunto]
    ]
  ]

  pagebreak(weak: true)

  // Header Pagine
  set page(
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

  // Registro Modifiche
  if registro_modifiche.len() > 0 {
    heading([Registro delle modifiche], numbering: none, outlined: false)
    text(
      size: 10pt,
      table(
        columns: (0.7fr, 1.5fr, 2fr, 2fr, 4fr),
        align: horizon + left,
        table.header([*Ver.*], [*Data*], [*Redattore*], [*Verificatore*], [*Descrizione*]),
        ..registro_modifiche.flatten()
      )
    )
    pagebreak(weak: true)
  }

  // Indice
  show outline.entry.where(level: 1): it => {
    v(12pt, weak: true)
    strong(it)
  }
  outline(indent: auto)
  pagebreak()

  body
}

// Lettera (stessa grafica del verbale)
#let lettera(
  titolo: "",
  data: "",
  destinatari: ("Prof. Tullio Vardanega", "Prof. Riccardo Cardin"),
  mittenti: (
    "Godwin Agbleze",
    "Nikola Miljanovic",
    "Carlo Nardin",
    "Mattia Pasquato",
    "Giacomo Ravazzolo",
    "Mattia Scomparin",
  ),
  registro_modifiche: (),
  body
) = {
  set text(lang: "it", font: "Atkinson Hyperlegible Next", weight: 400)
  show strong: set text(font: "Atkinson Hyperlegible Next", weight: 700)
  set page(margin: (x: 2.5cm, y: 2.5cm))
  set par(justify: true)
  set list(marker: [•])
  show link: it => text(fill: rgb("#c85815"), weight: "bold")[#it]

  // Copertina
  align(center)[
    #v(1cm)
    #figure(image("../../assets/logo_nobg.png", width: 35%), outlined: false, numbering: none)
    #v(0.5cm)
    #text(size: 14pt, weight: "bold")[UNIVERSITÀ DEGLI STUDI DI PADOVA] \
    #text(size: 12pt)[Corso di Laurea in Informatica] \
    #text(size: 12pt)[Ingegneria del Software -- A.A. 2026/2027]

    #v(1.5cm)
    #line(length: 100%, stroke: 1.5pt + rgb("#c85815"))
    #v(1.5cm)

    #par(justify: false, text(size: 28pt, font: "Montserrat", weight: 800, fill: rgb("#c85815"), hyphenate: false)[#titolo])
    #v(0.5cm)
    #text(size: 14pt)[Data: #data]

    #v(1.5cm)
    #grid(
      columns: (1fr, 1fr),
      align: (right, left),
      inset: (x: 10pt, y: 5pt),
      text(weight: "bold")[Destinatari:], destinatari.join([\ ]),
      grid.cell(colspan: 2, []),
      text(weight: "bold")[Mittenti:], mittenti.join([\ ]),
    )
  ]

  pagebreak(weak: true)

  // Header Pagine
  set page(
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

  // Registro Modifiche
  if registro_modifiche.len() > 0 {
    heading([Registro delle modifiche], numbering: none, outlined: false)
    text(
      size: 10pt,
      table(
        columns: (0.7fr, 1.5fr, 2fr, 2fr, 4fr),
        align: horizon + left,
        table.header([*Ver.*], [*Data*], [*Redattore*], [*Verificatore*], [*Descrizione*]),
        ..registro_modifiche.flatten()
      )
    )
    pagebreak(weak: true)
  }

  set par(spacing: 1.4em)
  set list(spacing: 1.2em)
  set smartquote(enabled: false)

  body
}

// Tabella Azioni

#let issue(id) = link("https://github.com/DeadlockGuild/docs/issues/" + str(id))[#underline[#id]]

#let tabella_azioni(..righe) = {
  table(
    columns: (auto, 1fr, auto, auto),
    align: left,
    stroke: 0.5pt + luma(200),
    fill: (col, row) => if row == 0 { rgb("#c85815") } else if calc.rem(row, 2) == 0 { luma(245) } else { white },
    
    text(fill: white, weight: "bold")[ID Issue], 
    text(fill: white, weight: "bold")[Titolo], 
    text(fill: white, weight: "bold")[Assegnatario], 
    text(fill: white, weight: "bold")[Verificatore],
    
    ..righe.pos()
  )
}
