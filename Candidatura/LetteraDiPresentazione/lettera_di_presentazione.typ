#import "../Verbali/template.typ": *

#show: lettera.with(
  titolo: "Lettera di presentazione",
  data: "2026-10-30",
  versione: "1.0.2",
  registro_modifiche: (
    ([1.0.2], [2026-10-29], [Mattia Pasquato], [Carlo Nardin], [- Correzioni minori]),
    ([1.0.1], [2026-10-29], [Mattia Pasquato], [Carlo Nardin], [
      - Aggiunti costo stimato, ore totali e data di consegna
      - Aggiunto il registro delle modifiche
      - Aggiornato il link alla documentazione
    ]),
    ([1.0.0], [2026-10-25], [Mattia Pasquato], [Carlo Nardin], [- Prima stesura della lettera]),
  ),
)

Con la presente il gruppo *DeadlockGuild* si candida alla realizzazione del progetto descritto nel capitolato *C5* intitolato *_RareCare: Piattaforma AI per la raccolta dati e il supporto decisionale nelle malattie rare_*, proposto dall'azienda *MIRIADE srl*.

Tutta la documentazione viene resa disponibile pubblicamente all'indirizzo

#align(center, link("https://deadlockguild.github.io/docs/"))

dove nella sezione candidatura si possono consultare i seguenti documenti:

- Dichiarazione impegni e preventivo costi;
- Valutazione dei capitolati;
- Verbali interni ed esterni.

Come riportato nel documento _"Dichiarazione impegni e preventivo costi"_ il costo stimato del prodotto è di *11.220,00 €*, corrispondente a un impegno complessivo di *546 ore*, e la data prevista di consegna è il *09/04/2027*.

Si riporta di seguito l'elenco dei componenti del gruppo con il relativo numero di matricola:

#align(center, table(
  columns: (12em, 12em),
  align: center + horizon,
  inset: 8pt,
  stroke: 0.5pt + luma(200),
  fill: (col, row) => if row == 0 { rgb("#c85815") } else if calc.rem(row, 2) == 0 { luma(245) } else { white },
  table.header(
    text(fill: white, weight: "bold")[Nominativo],
    text(fill: white, weight: "bold")[Matricola],
  ),
  [Godwin Agbleze], [2145602],
  [Nikola Miljanovic], [2145601],
  [Carlo Nardin], [2148000],
  [Mattia Pasquato], [1170712],
  [Giacomo Ravazzolo], [2146767],
  [Mattia Scomparin], [2110992],
))

In attesa di un Vostro riscontro Vi porgiamo i nostri cordiali saluti.

_Gruppo DeadlockGuild._
