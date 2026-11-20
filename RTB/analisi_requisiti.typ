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

  #figure(image("../assets/logo_nobg.png", width: 35%), outlined: false, numbering: none)
  #v(0.5cm)
  #text(size: 14pt, weight: "bold")[UNIVERSITÀ DEGLI STUDI DI PADOVA] \
  #text(size: 12pt)[Corso di Laurea in Informatica] \
  #text(size: 12pt)[Ingegneria del Software -- A.A. 2026/2027]
  
  #v(1.2cm)
  #line(length: 100%, stroke: 1.5pt + rgb("#c85815"))
  #v(1.2cm)
  
  #text(size: 28pt, font: "Montserrat", weight: 800, fill: rgb("#c85815"))[Analisi dei Requisiti] \
  #v(0.5cm)
  #text(size: 14pt)[Data: 2026-11-18] \
  #text(size: 14pt)[Versione: 0.1.1]
  
  #v(1.5cm)
  #grid(
    columns: (1fr, 1fr),
    align: (right, left),
    inset: (x: 10pt, y: 5pt),
    row-gutter: 0.7em,
    text(weight: "bold")[Uso:], [Esterno],
    text(weight: "bold")[Redattori:], [Godwin Agbleze \ Carlo Nardin],
    text(weight: "bold")[Verificatori:], [Mattia Scomparin],
    text(weight: "bold")[Destinatari:], [Prof. Tullio Vardanega \ Prof. Riccardo Cardin \ Miriade Srl],
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
      box(inset: (x: 10pt))[#image("../assets/logo_text_nobg.png", width: 85pt)],
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
    [0.1.1], [2026-11-20], [Carlo Nardin], [Mattia Scomparin], [Correzioni varie: Termini glossario e formattazione testo],
    [0.1.0], [2026-11-18], [Carlo Nardin \ Godwin Agbleze], [Mattia Scomparin], [Introduzione, descrizione generale del prodotto e impostazione della struttura per i requisiti]
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
Il presente documento di _Analisi dei Requisiti_ ha lo scopo di definire e strutturare i bisogni espressi dalla proponente *Miriade Srl* per il progetto *RareCare Navigator* (#g[Capitolato] C5), traducendoli in requisiti software chiari, classificati e tracciabili.

L'obiettivo del documento è duplice:
- fornire un punto di riferimento condiviso tra il gruppo *DeadlockGuild*, l'azienda proponente e i committenti (*Prof. Tullio Vardanega* e *Prof. Riccardo Cardin*) in merito alle capacità attese dal sistema;
- costituire la base conoscitiva su cui fondare le successive attività di progettazione architetturale, sviluppo e validazione del prodotto fino alla revisione #g[RTB] (_Requirements and Technology Baseline_) e al collaudo finale.

== Scopo del prodotto
*RareCare Navigator* è una piattaforma digitale e multipiattaforma dotata di un assistente virtuale basato su #g[Intelligenza Artificiale], ideata per supportare la gestione quotidiana delle malattie rare e ad alta complessità assistenziale. In particolare, il progetto si concentra inizialmente sulla *#g[Sindrome di Sanfilippo]* (Mucopolisaccaridosi di tipo III), una patologia neurodegenerativa progressiva che comporta una perdita graduale delle capacità cognitive, motorie e relazionali.

Allo stato attuale (situazione _AS-IS_), le famiglie dei pazienti affrontano un forte isolamento e una marcata frammentazione dei servizi, trovandosi a dover coordinare autonomamente le comunicazioni e la documentazione tra centri clinici specialistici, pediatri, terapisti, istituti scolastici, servizi sociali ed enti amministrativi. Ciò genera un pesante carico organizzativo ed emotivo sui #g[Caregiver].

Il prodotto mira a trasformare questo scenario in un percorso assistenziale coordinato e accessibile (situazione _TO-BE_), affiancando e potenziando la figura umana del *#g[Care Navigator]* (con funzioni di _case manager_). La piattaforma agisce quindi come connettore tecnologico e punto di riferimento stabile, centralizzando in sicurezza documenti, scadenze, checklist operative e comunicazioni tra tutti gli attori della rete di cura.

== Glossario
Per evitare ambiguità interpretative dovute all'uso del linguaggio naturale e alla specificità dei termini clinici, normativi e tecnologici del dominio, il gruppo affianca al presente documento un _Glossario_ esterno. Tutti i vocaboli e gli acronimi definiti all'interno del _Glossario_ sono indicati nel testo, alla loro prima occorrenza significativa, in corsivo e contrassegnati dal pedice $G$ (ad esempio: #g[Disease Pack]).

== Maturità e miglioramenti del documento
Il presente documento è soggetto a un processo di redazione incrementale e a spirale: non va quindi considerato definitivo fino al consolidamento delle relative #g[Baseline], ma evolve progressivamente con l'approfondimento del dominio applicativo e con i confronti periodici tra il gruppo *DeadlockGuild* e la proponente *Miriade Srl*.

Ogni variazione, aggiunta o affinamento dei _Casi d'Uso_ e dei requisiti viene tracciato tramite il sistema di versionamento e riportato nel _Registro delle modifiche_, al fine di mantenere la coerenza e la tracciabilità del documento lungo tutto il ciclo di sviluppo fino alla revisione RTB e al collaudo finale.

== Riferimenti

=== Riferimenti normativi
- *Norme di Progetto* (v????) \
  
- *Regolamento del progetto didattico* (ultimo accesso: 2026-11-18) \
  #link("https://www.math.unipd.it/~tullio/IS-1/2026/Dispense/PD1.pdf")
- *Capitolato d'appalto C5 -- RareCare: Piattaforma AI per la raccolta dati e il supporto decisionale nelle malattie rare*, Miriade Srl (ultimo accesso: 2026-11-18) \
  #link("https://www.math.unipd.it/~tullio/IS-1/2026/Progetto/C5-RareCare.pdf")
- *Verbale esterno del 2026-10-23* (v1.0.4) \
  #link("https://deadlockguild.github.io/docs/pdf/Candidatura/Verbali/Esterni/VE_Miriade_2026-10-23.pdf")

- *Regolamento Generale sulla Protezione dei Dati -- #g[GDPR] (Regolamento UE 2016/679)* (ultimo accesso: 2026-11-18) \
  #link("https://eur-lex.europa.eu/eli/reg/2016/679/oj")

=== Riferimenti informativi
- *Glossario* (v????) \

- *T05 -- Analisi dei Requisiti* (ultimo accesso: 2026-11-18) \
  #link("https://www.math.unipd.it/~tullio/IS-1/2026/Dispense/T05.pdf")
- *P2 -- I Diagrammi dei Casi d'Uso* (ultimo accesso: 2026-11-18) \
  #link("https://www.math.unipd.it/~rcardin/swea/2022/Diagrammi%20Use%20Case.pdf")


#pagebreak()


= Descrizione del prodotto

== Obiettivi del prodotto
Il progetto *RareCare Navigator* si pone l'obiettivo di ridurre il divario informativo e organizzativo che grava sulle famiglie colpite da patologie rare, perseguendo cinque finalità principali:
1. *Orientamento continuo e affidabile*: guidare familiari e operatori nella comprensione dei protocolli sanitari, delle pratiche burocratiche e dei diritti/benefici di legge, rendendo accessibili informazioni complesse.
2. *Coordinamento sicuro della rete di cura*: mettere in comunicazione strutturata la famiglia, il Care Navigator, i professionisti sanitari e gli enti coinvolti, garantendo che ciascun soggetto acceda esclusivamente ai dati pertinenti al proprio ruolo e autorizzati per lo specifico paziente.
3. *Gestione proattiva di attività e scadenze*: accompagnare il percorso assistenziale attraverso una timeline clinica e checklist dinamiche adattate alla fase della patologia, prevenendo dimenticanze su visite, esami, terapie e rinnovi amministrativi o scolastici (#g[PAI], #g[PEI], invalidità).
4. *Supporto decisionale basato su fonti verificate*: impiegare modelli di #g[LLM] e architetture #g[RAG] per estrarre informazioni da documentazione clinica e normativa già validata, mantenendo sempre il controllo e la conferma finale in capo all'essere umano.
5. *Riusabilità ed estendibilità del sistema*: disaccoppiare il nucleo applicativo della piattaforma dalle specificità della singola malattia rara attraverso un modello a plugin (#g[Disease Pack]), così da permettere l'adozione futura della piattaforma per altre patologie senza intervenire sul codice del _core_.

== Funzionalità e vincoli del prodotto

=== Macro-funzionalità del prodotto
La piattaforma si articola nelle seguenti macro-aree funzionali:
- *Hub di Coordinamento e Rete Integrata di Comunicazione*: ambiente collaborativo con controllo granulare dei permessi (basato su ruolo, relazione con il paziente e visibilità del singolo documento) per connettere gli attori associati al paziente e consentire lo scambio diretto di messaggi e documentazione.
- *#g[Fascicolo Digitale] e #g[Document Repository]*: archivio cifrato per il caricamento, il versionamento, la conservazione e la condivisione controllata di referti medici, piani terapeutici (PAI), piani educativi (PEI) e certificazioni amministrative.
- *#g[Smart Checklist] e Timeline di Cura*: rappresentazione cronologica del percorso assistenziale e generazione di liste di attività (_to-do list_) legate alla fase clinica in cui si trova il paziente, basate sui template del Disease Pack e soggette a validazione umana.
- *Motore di Workflow, Scadenze e Notifiche*: registrazione delle scadenze cliniche e burocratiche con pianificazione automatica di promemoria inviati tramite notifiche push ed e-mail, ed eventuale segnalazione al Care Navigator in caso di mancato completamento.
- *Assistente Conversazionale RAG (_Care Navigator AI Assistant_)*: chat interattiva in linguaggio naturale che risponde a quesiti clinico-informativi e amministrativi attingendo esclusivamente alla base di conoscenza validata del Disease Pack, citando le fonti utilizzate, dichiarando i propri limiti quando l'informazione non è disponibile e astenendosi da qualsiasi decisione medica.
- *Architettura Modulare a Disease Pack*: gestione di pacchetti configurativi e documentali specifici per patologia (contenenti fasi della malattia, template di checklist e scadenze, documenti validati per il RAG, vocabolari clinici e istruzioni di contesto per l'assistente).
- *Funzionalità evolutive e opzionali*:
  - estrazione automatica di entità cliniche e scadenze da note testuali o vocali tramite tecniche #g[NLP] / #g[NER] e sintesi di checklist dai piani PAI/PEI, sempre subordinate a revisione e conferma umana;
  - modulo di *mappatura geospaziale* dei centri clinici e dei servizi territoriali (primo requisito opzionale per priorità);
  - *assistente vocale (_Voice Bot_)* per l'interazione a mani libere in mobilità o emergenza (secondo requisito opzionale per priorità);
  - *analisi predittiva dei bisogni* tramite modelli di #g[Machine Learning] (terzo requisito opzionale per priorità).

=== Vincoli generali del prodotto
Lo sviluppo e il funzionamento del sistema sono soggetti ai seguenti vincoli principali:
- *Protezione dei dati sanitari e conformità normativa*: il sistema tratta categorie particolari di dati personali (dati relativi alla salute, inclusi quelli di minori, art. 9 GDPR) e deve rispettare i principi di #g[Privacy by Design] e #g[Privacy by Default], la gestione esplicita e revocabile dei consensi, il tracciamento immutabile degli accessi (#g[Audit log]) e la residenza dei dati nell'Unione Europea.
- *Assenza di autonomia decisionale medica dell'IA*: per vincolo normativo e di sicurezza del paziente, l'intelligenza artificiale non può prendere decisioni cliniche autonome; ogni suggerimento, checklist o dato estratto dall'IA richiede un'esplicita approvazione umana prima di diventare effettivo.
- *Perimetro del dominio e validazione delle fonti*: per l'intero progetto viene realizzato esclusivamente il Disease Pack relativo alla Sindrome di Sanfilippo, i cui contenuti documentali sono forniti già validati dall'associazione *Sanfilippo Fighters*.
- *Assenza di dati reali in fase di sviluppo e test*: non è previsto l'utilizzo di dati appartenenti a pazienti reali; tutte le attività di sviluppo e verifica si basano su dati fittizi (#g[Mock data]).
- *Scelte tecnologiche e infrastrutturali*: le tecnologie indicate nel capitolato (stack cloud #g[AWS], #g[Flutter], #g[Amazon Bedrock], #g[AWS Cognito]) rappresentano raccomandazioni non vincolanti da cui il gruppo può discostarsi motivando le proprie scelte. La proponente mette a disposizione account AWS con permessi controllati e limiti settimanali sul consumo di token dei modelli linguistici.

== Utenti e loro caratteristiche
Il sistema si rivolge a una rete eterogenea di attori che ruotano attorno al paziente. La definizione puntuale dei profili e la scelta tra un account unico per nucleo familiare o profili separati verranno consolidate durante il *#g[Design Sprint]*; nella fase attuale si individuano le seguenti figure di riferimento:
- *Paziente / Famiglia (Caregiver)*: è l'utente primario della piattaforma. Spesso opera in condizioni di forte stress emotivo e carico organizzativo; necessita quindi di un'interfaccia empatica, accessibile e a basso sforzo cognitivo. Gestisce il fascicolo del paziente, consulta la timeline, le checklist e l'assistente virtuale, inserisce scadenze e controlla in modo granulare quali documenti condividere con gli altri attori.
- *Care Navigator*: figura di riferimento umano (#g[case manager]) che accompagna e coordina la famiglia lungo il percorso assistenziale. Utilizza la piattaforma per monitorare l'avanzamento delle attività, supportare l'aggiornamento delle fasi e ricevere segnalazioni sulle scadenze non portate a termine.
- *Professionista sanitario (es. medico, pediatra, terapista)*: consulta e carica la documentazione clinica di propria competenza relativa ai pazienti che ha in carico (quali gli esami richiesti e i referti esplicitamente condivisi dalla famiglia). Non ha facoltà di modificare il Disease Pack.
- *Struttura clinica / Centro specialistico*: ente sanitario coinvolto nella presa in carico del paziente, abilitato a validare e confermare le tappe e le checklist proposte dal sistema per le diverse fasi della patologia.
- *Ente pubblico o scolastico (es. scuola, servizi sociali)*: attore esterno della rete di cura (come un dirigente scolastico o docente referente per il PEI) che accede in sola consultazione ai soli documenti amministrativi o educativi che la famiglia ha scelto esplicitamente di condividere.


#pagebreak()


= Requisiti

In questa sezione vengono elencati i requisiti individuati durante l'attività di analisi a partire dal Capitolato d'appalto, dai casi d'uso e dai colloqui con l'azienda proponente.

Ogni requisito è identificato da un codice univoco secondo il formalismo:
#align(center)[
  *`R[Importanza][Tipo][Numero]`*
]
dove:
- *Importanza* assume uno dei seguenti valori:
  - *`O`* (*Obbligatorio*): requisito irrinunciabile per il soddisfacimento delle richieste del committente;
  - *`D`* (*Desiderabile*): requisito non strettamente necessario per l'#g[MVP], ma dal valore aggiunto riconosciuto e auspicato dalla proponente;
  - *`F`* (*Facoltativo* / *Opzionale*): requisito opzionale o evolutivo, la cui realizzazione è subordinata al completamento dei requisiti obbligatori e agli accordi con la proponente.
- *Tipo* assume uno dei seguenti valori:
  - *`F`* (*Funzionale*): descrive una funzionalità o un comportamento osservabile che il sistema deve mettere a disposizione;
  - *`Q`* (*Qualità*): specifica gli attributi qualitativi, prestazionali, architetturali, di sicurezza e di usabilità del prodotto e del processo;
  - *`V`* (*Vincolo*): definisce restrizioni normative, di dominio o tecnologiche a cui il sistema deve attenersi.
- *Numero*: identificativo intero progressivo all'interno di ciascuna combinazione di importanza e tipo.

== Requisiti funzionali

#text(
  size: 10pt,
  table(
    columns: (1fr, 4.5fr, 1.5fr),
    align: (center + horizon, left + horizon, center + horizon),
    table.header([*Codice*], [*Descrizione*], [*Fonti*]),
    // Esempio: [ROF1], [Descrizione del requisito...], [Capitolato],
  )
)

== Requisiti di qualità

#text(
  size: 10pt,
  table(
    columns: (1fr, 4.5fr, 1.5fr),
    align: (center + horizon, left + horizon, center + horizon),
    table.header([*Codice*], [*Descrizione*], [*Fonti*]),
    // Esempio: [ROQ1], [Descrizione del requisito...], [Capitolato],
  )
)

== Requisiti di vincolo

#text(
  size: 10pt,
  table(
    columns: (1fr, 4.5fr, 1.5fr),
    align: (center + horizon, left + horizon, center + horizon),
    table.header([*Codice*], [*Descrizione*], [*Fonti*]),
    // Esempio: [ROV1], [Descrizione del requisito...], [Capitolato],
  )
)

