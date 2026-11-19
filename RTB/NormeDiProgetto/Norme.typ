#set text(lang: "it", font: ("Atkinson Hyperlegible Next", "Liberation Sans"), weight: 400)
#show strong: set text(font: "Atkinson Hyperlegible Next", weight: 700)
#set page(margin: (x: 2.5cm, y: 2.5cm))
#set heading(numbering: "1.")
#set par(justify: true)
#set list(marker: [•])
#show link: it => text(fill: rgb("#c85815"), weight: "bold")[#it]

// Funzione di utilità per indicare i termini presenti nel Glossario
#let g(term) = [#emph(term)#sub[G]]

#align(center)[
  #v(1cm)
  // Assicurati che il percorso del logo sia corretto
  #figure(image("assets/logo_nobg.png", width: 35%), outlined: false, numbering: none)
  #v(0.5cm)
  #text(size: 14pt, weight: "bold")[UNIVERSITÀ DEGLI STUDI DI PADOVA] \
  #text(size: 12pt)[Corso di Laurea in Informatica] \
  #text(size: 12pt)[Ingegneria del Software -- A.A. 2026/2027]
  
  #v(1.2cm)
  #line(length: 100%, stroke: 1.5pt + rgb("#c85815"))
  #v(1.2cm)
  
  #text(size: 28pt, font: "Montserrat", weight: 800, fill: rgb("#c85815"))[Norme di Progetto] \
  #v(0.5cm)
  #text(size: 14pt)[Data: 2026-11-18] \
  #text(size: 14pt)[Versione: 0.1.0]
  
  #v(1.5cm)
  #grid(
    columns: (1fr, 1fr),
    align: (right, left),
    inset: (x: 10pt, y: 5pt),
    row-gutter: 0.7em,
    text(weight: "bold")[Uso:], [Interno],
    text(weight: "bold")[Redattore:], [Mattia Pasquato],
    text(weight: "bold")[Verificatore:], [Mattia Scoparin],
    text(weight: "bold")[Destinatari:], [Gruppo DeadlockGuild \ Prof. Tullio Vardanega \ Prof. Riccardo Cardin],
  )
  
  #v(1.0cm)
  #line(length: 100%, stroke: 1.5pt + rgb("#c85815"))
  #v(1.0cm)
]

#pagebreak(weak: true)

#set page(
  numbering: "1",
  header: [
    #grid(
      columns: (1fr, auto, 1fr),
      align: horizon,
      line(length: 100%, stroke: 1.5pt + rgb("#c85815")),
      box(inset: (x: 10pt))[#image("assets/logo_text_nobg.png", width: 85pt)],
      line(length: 100%, stroke: 1.5pt + rgb("#c85815"))
    )
  ],
)


#heading([Registro delle modifiche], numbering: none, outlined: false)
#text(
  size: 10pt,
  table(
    columns: (0.7fr, 1.5fr, 2fr, 2fr, 4fr),
    align: horizon + left,
    table.header([*Ver.*], [*Data*], [*Redattore*], [*Verificatore*], [*Descrizione*]),
    [0.2.0], [2026-11-19], [Mattia Pasquato], [Mattia Scomparin], [• Prima stesura sezioni 1 e 2],
    [0.1.0], [2026-11-16], [Mattia Pasquato], [Mattia Scomparin], [• Struttura generale del documento e introduzione]
  )
)

#pagebreak(weak: true)


#show outline.entry.where(level: 1): it => {
  v(12pt, weak: true)
  strong(it)
}
#outline(title: [Indice], indent: auto)
#pagebreak()


= Introduzione

== Scopo del documento
Il documento di _Norme di Progetto_ definisce e raccoglie le regole, le convenzioni, le procedure e gli strumenti che costituiscono il #g[WoW] (Way of Working) adottato dal gruppo *DeadlockGuild* durante lo svolgimento del progetto didattico.

Disporre di un insieme di norme condiviso e documentato offre al gruppo un riferimento comune da rispettare, permettendo a tutti i componenti di operare con uniformità e di portare a termine il progetto secondo criteri di #g[efficacia] ed #g[efficienza]. Il modo di lavorare del gruppo, tuttavia, si affina con l’esperienza maturata sul campo e con l’avvio di nuove attività lungo il ciclo di vita del software. Per questo il documento adotta un approccio di redazione incrementale, ovvero viene esteso e aggiornato progressivamente sulla base delle decisioni prese nelle riunioni interne, fino al consolidamento delle #g[Baseline] di progetto.

== Scopo del prodotto
Il progetto ha come obiettivo la realizzazione di *RareCare Navigator* (#g[Capitolato] C5), una piattaforma digitale multipiattaforma dotata di assistente virtuale basato su #g[Intelligenza Artificiale], proposta dall'azienda *Miriade S.r.l.* per supportare la gestione delle malattie rare e complesse, a partire dalla *#g[Sindrome di Sanfilippo]* (Mucopolisaccaridosi di tipo III).

Il sistema mira a superare la frammentazione informativa e organizzativa che le famiglie dei pazienti si trovano ad affrontare, affiancando la figura del *#g[Care Navigator]* con un insieme di strumenti integrati: un hub collaborativo per la rete di cura, un #g[Fascicolo Digitale] cifrato, la gestione delle scadenze e delle #g[Smart Checklist] per fase clinica, e un assistente conversazionale basato su architettura #g[RAG] e su fonti documentali verificate.

== Glossario
Al fine di evitare ambiguità terminologiche e incomprensioni relative a vocaboli tecnici, acronimi e concetti di dominio, derivanti dall’uso del linguaggio naturale, il gruppo redige e mantiene un _Glossario_ esterno. I termini in esso definiti sono indicati nel testo, alla loro prima occorrenza, in corsivo e con la lettera $G$ a pedice (ad esempio: #g[Branch]).

== Riferimenti 

=== Riferimenti normativi
- *Regolamento del progetto didattico* (ultimo accesso: 2026-11-18) \
  #link("https://www.math.unipd.it/~tullio/IS-1/2026/Dispense/PD1.pdf")

- *Standard ISO/IEC 12207:1995* (ultimo accesso: 2026-11-18) \
  #link("https://www.math.unipd.it/~tullio/IS-1/2009/Approfondimenti/ISO_12207-1995.pdf")


=== Riferimenti informativi
- *Glossario* (ultimo accesso: 2026-11-18) \
  #link("link da mettere")

- *Capitolato C5 - RareCare* (ultimo accesso:2026-11-18) \
  #link("https://www.math.unipd.it/~tullio/IS-1/2026/Progetto/C5-RareCare.pdf")
  
#pagebreak()


= Processi primari
Lo standard internazionale *ISO/IEC 12207:1995* regola i processi del ciclo di vita del software e ne individua cinque come primari, ossia fondamentali per la realizzazione e la gestione di un prodotto software: Acquisizione, Fornitura, Sviluppo, Gestione operativa e Manutenzione. Data la natura didattica del progetto, il gruppo si occupa unicamente dei processi di *Fornitura* e di *Sviluppo*.

== Fornitura

=== Scopo e descrizione
Il processo di fornitura comprende le attività e i compiti con cui il gruppo fornitore (*DeadlockGuild*) instaura e mantiene un rapporto collaborativo con l’azienda proponente (*Miriade S.r.l.*) e con i committenti (*Prof. Tullio Vardanega e Prof. Riccardo Cardin*). In particolare, il fornitore concorda con la proponente, tramite accordo formale, i vincoli e i requisiti del progetto, esaminando le richieste ricevute e valutandone la fattibilità. Sulla base di tale accordo, pianifica le attività: analizza e consolida i requisiti, stabilisce il modello di ciclo di vita e controlla i processi di sviluppo, garantendo la qualità in relazione allo stato di avanzamento del progetto. Il processo copre l’intero arco del progetto, dalla fase preliminare di valutazione dei capitolati e presentazione dell’offerta di candidatura fino alla verifica dei risultati nelle revisioni intermedie (#g[RTB]) e finali (#g[PB] e collaudo).

=== Comunicazioni con la proponente
Per garantire interazioni ordinate, tempestive e tracciabili con l'azienda proponente *Miriade S.r.l.* e gli #g[stakeholders], il gruppo adotta le seguenti modalità di comunicazione:
- *Posta elettronica*: L’indirizzo ufficiale del gruppo è il canale per le comunicazioni formali, come la richiesta di incontri, l’invio di domande strutturate e la trasmissione dei verbali per l’approvazione;
- *#g[SAL]*: Incontri in videoconferenza su Google Meet, proposti dalla proponente, a cadenza settimanale o quindicinale a discrezione e su richiesta del gruppo. Servono a presentare i progressi, esporre i dubbi sulle scelte da compiere e mantenere l’allineamento con la proponente;
- *#g[Design Sprint]*: Workshop in presenza di circa quattro ore, messo a disposizione dalla proponente, dedicato a chiarire il flusso di lavoro, gli attori che utilizzeranno l’applicazione e il comportamento atteso del sistema. Fornisce la base per definire i requisiti e classificarli in fondamentali, desiderabili e opzionali;
- *Incontro con l’associazione*: Confronto di circa due ore con l’associazione Sanfilippo Fighters, in qualità di utilizzatrice del prodotto, per raccogliere le aspettative, le priorità e i chiarimenti sul dominio applicativo;
- *Verbali*: Ogni incontro con la proponente viene documentato in un verbale esterno, sottoposto al referente aziendale per la verifica e la firma di approvazione, e pubblicato sul sito documentale del gruppo una volta convalidato.

=== Documentazione fornita
=== Strumenti
- *Github*
- *Google Meet*
- *telegram*
- *Typst*
- *Gmail*
