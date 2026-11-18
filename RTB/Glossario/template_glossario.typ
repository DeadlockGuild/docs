#let glossario(
  titolo: "",
  data: "",
  versione: "",
  destinatari: ("Prof. Tullio Vardanega", "Prof. Riccardo Cardin"),
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
    
    #v(1.0cm)
    #line(length: 100%, stroke: 1.5pt + rgb("#c85815"))
    #v(1.0cm)
    
    #par(justify: false, text(size: 28pt, font: "Montserrat", weight: 800, fill: rgb("#c85815"), hyphenate: false)[#titolo])
    #v(0.5cm)
    #text(size: 14pt)[Data: #data] \
    #text(size: 14pt)[Versione: #versione]
    
    #v(1.2cm)
    #grid(
      columns: (1fr, 1fr),
      align: (right, left),
      inset: (x: 10pt, y: 5pt),
      text(weight: "bold")[Destinatari:], destinatari.join([\ ]),
    )
    
    #v(0.7cm)
    #line(length: 100%, stroke: 1.5pt + rgb("#c85815"))
    #v(0.7cm)
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

// Voce del glossario: box con nome (intestazione arancione) e significato (sfondo arancione tenue)
#let colore-glossario = rgb("#c85815")

#let voce(termine, descrizione) = block(
  width: 100%,
  breakable: false,
  above: 1em,
  below: 1em,
  stroke: 1.2pt + colore-glossario,
  radius: 4pt,
  clip: true,
  stack(
    block(
      width: 100%,
      above: 0pt,
      below: 0pt,
      fill: colore-glossario,
      inset: (x: 10pt, y: 6pt),
      text(fill: white, weight: "bold", font: "Montserrat")[#termine],
    ),
    block(
      width: 100%,
      above: 0pt,
      below: 0pt,
      fill: colore-glossario.lighten(88%),
      inset: 10pt,
      par(justify: true)[#descrizione],
    ),
  ),
)