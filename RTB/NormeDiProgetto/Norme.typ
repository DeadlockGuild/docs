#import "../Verbali/template.typ": *

#show: verbale.with(
  titolo: "Norme di Progetto",
  data: "2026-11-22",
  versione: "0.2.2",
  redattore: ("Mattia Pasquato", "Mattia Scomparin"),
  verificatore: ("Mattia Scomparin", "Nikola Miljanovic"),
  destinatari: ("Gruppo DeadlockGuild", "Prof. Tullio Vardanega", "Prof. Riccardo Cardin"),
  registro_modifiche: (
    ([0.2.2], [2026-11-22], [Mattia Scomparin], [Nikola Miljanovic], [- Corretta formattazione del rimado al glossario]),
    ([0.2.1], [2026-11-21], [Mattia Pasquato], [Mattia Scomparin], [- Sistemazioni typesetting minori e rimozione sezione "Documentazione fornita" non ancora definita]),
    ([0.2.0], [2026-11-19], [Mattia Pasquato], [Mattia Scomparin], [- Prima stesura sezioni 1 e 2]),
    ([0.1.0], [2026-11-16], [Mattia Pasquato], [Mattia Scomparin], [- Struttura generale del documento e introduzione]),
  ),
)

// Funzione di utilità per indicare i termini presenti nel Glossario
#let g(term) = [term#sub[*G*]]


= Introduzione

== Scopo del documento
Il documento di _Norme di Progetto_ definisce e raccoglie le regole, le convenzioni, le procedure e gli strumenti che costituiscono il #g[WoW] (Way of Working) adottato dal gruppo *DeadlockGuild* durante lo svolgimento del progetto didattico.

Disporre di un insieme di norme condiviso e documentato offre al gruppo un riferimento comune da rispettare, permettendo a tutti i componenti di operare con uniformità e di portare a termine il progetto secondo criteri di #g[efficacia] ed #g[efficienza]. Il modo di lavorare del gruppo, tuttavia, si affina con l’esperienza maturata sul campo e con l’avvio di nuove attività lungo il ciclo di vita del software. Per questo il documento adotta un approccio di redazione incrementale, ovvero viene esteso e aggiornato progressivamente sulla base delle decisioni prese nelle riunioni interne, fino al consolidamento delle #g[Baseline] di progetto.

== Scopo del prodotto
Il progetto ha come obiettivo la realizzazione di *RareCare Navigator* (#g[Capitolato] C5), una piattaforma digitale multipiattaforma dotata di assistente virtuale basato su #g[Intelligenza Artificiale], proposta dall'azienda *Miriade Srl* per supportare la gestione delle malattie rare e complesse, a partire dalla *#g[Sindrome di Sanfilippo]* (Mucopolisaccaridosi di tipo III).

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
- *Glossario* (v0.2.0) \
  #link("https://deadlockguild.github.io/docs/pdf/RTB/Glossario/glossario.pdf")

- *Capitolato d'appalto C5 -- RareCare: Piattaforma AI per la raccolta dati e il supporto decisionale nelle malattie rare*, Miriade Srl (ultimo accesso: 2026-11-18) \
  #link("https://www.math.unipd.it/~tullio/IS-1/2026/Progetto/C5-RareCare.pdf")
  
#pagebreak()


= Processi primari
Lo standard internazionale *ISO/IEC 12207:1995* regola i processi del ciclo di vita del software e ne individua cinque come primari, ossia fondamentali per la realizzazione e la gestione di un prodotto software: Acquisizione, Fornitura, Sviluppo, Gestione operativa e Manutenzione. Data la natura didattica del progetto, il gruppo si occupa unicamente dei processi di *Fornitura* e di *Sviluppo*.

== Fornitura

=== Scopo e descrizione
Il processo di fornitura comprende le attività e i compiti con cui il gruppo fornitore (*DeadlockGuild*) instaura e mantiene un rapporto collaborativo con l’azienda proponente (*Miriade Srl*) e con i committenti (*Prof. Tullio Vardanega e Prof. Riccardo Cardin*). In particolare, il fornitore concorda con la proponente, tramite accordo formale, i vincoli e i requisiti del progetto, esaminando le richieste ricevute e valutandone la fattibilità. Sulla base di tale accordo, pianifica le attività: analizza e consolida i requisiti, stabilisce il modello di ciclo di vita e controlla i processi di sviluppo, garantendo la qualità in relazione allo stato di avanzamento del progetto. Il processo copre l’intero arco del progetto, dalla fase preliminare di valutazione dei capitolati e presentazione dell’offerta di candidatura fino alla verifica dei risultati nelle revisioni intermedie (#g[RTB]) e finali (#g[PB] e collaudo).

=== Comunicazioni con la proponente
Per garantire interazioni ordinate, tempestive e tracciabili con l'azienda proponente *Miriade Srl* e gli #g[stakeholders], il gruppo adotta le seguenti modalità di comunicazione:
- *Posta elettronica*: L’indirizzo ufficiale del gruppo è il canale per le comunicazioni formali, come la richiesta di incontri, l’invio di domande strutturate e la trasmissione dei verbali per l’approvazione;
- *#g[SAL]*: Incontri in videoconferenza su Google Meet, proposti dalla proponente, a cadenza settimanale o quindicinale a discrezione e su richiesta del gruppo. Servono a presentare i progressi, esporre i dubbi sulle scelte da compiere e mantenere l’allineamento con la proponente;
- *#g[Design Sprint]*: Workshop in presenza di circa quattro ore, messo a disposizione dalla proponente, dedicato a chiarire il flusso di lavoro, gli attori che utilizzeranno l’applicazione e il comportamento atteso del sistema. Fornisce la base per definire i requisiti e classificarli in fondamentali, desiderabili e opzionali;
- *Incontro con l’associazione*: Confronto di circa due ore con l’associazione Sanfilippo Fighters, in qualità di utilizzatrice del prodotto, per raccogliere le aspettative, le priorità e i chiarimenti sul dominio applicativo;
- *Verbali*: Ogni incontro con la proponente viene documentato in un verbale esterno, sottoposto al referente aziendale per la verifica e la firma di approvazione, e pubblicato sul sito documentale del gruppo una volta convalidato.

=== Strumenti
- *GitHub*
- *Google Meet*
- *Telegram*
- *Typst*
- *Gmail*
