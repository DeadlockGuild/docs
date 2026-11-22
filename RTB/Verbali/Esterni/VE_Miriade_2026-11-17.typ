#import "template/template.typ": *

#show: verbale.with(
  titolo: "Verbale - Miriade Srl (C5)",
  data: "2026-11-17",
  versione: "0.1.0",
  uso: "Esterno",
  redattore: "Carlo Nardin",
  verificatore: "Nikola Miljanovic",
  destinatari: ("Prof. Tullio Vardanega", "Prof. Riccardo Cardin", "Miriade Srl"),
  riassunto: "Allineamento post-aggiudicazione: referenti aziendali, proposta di incontro con Sanfilippo Fighters e workshop di Design Sprint, modalità di comunicazione, orientamento tecnologico e pianificazione.",
  registro_modifiche: (
    ("0.1.0", "2026-11-22", "Carlo Nardin", "Nikola Miljanovic", "Prima stesura del verbale"),
  ),
)

= Informazioni generali

== Luogo e data della riunione

- *Luogo*: Google Meet
- *Data*: 2026-11-17
- *Ora*: 17:00
- *Durata*: 1 ora

== Partecipanti

*Team*
- Godwin Agbleze
- Carlo Nardin
- Mattia Pasquato
- Giacomo Ravazzolo
- Mattia Scomparin

*Miriade Srl*
- Riferimento: Emanuele Righetto

= Ordine del giorno

+ Definizione dei referenti aziendali e del percorso operativo post-aggiudicazione.
+ Incontro di approfondimento sul dominio con l'associazione Sanfilippo Fighters e proposta di workshop di Design Sprint.
+ Modalità di comunicazione, frequenza degli incontri e supporto alla progettazione.
+ Chiarimenti su architettura, tecnologie suggerite, account AWS e gestione delle tempistiche.

= Discussione

== Referenti aziendali e percorso post-aggiudicazione

A seguito dell'aggiudicazione del capitolato C5, Emanuele Righetto ha illustrato l'organizzazione dei referenti lato Miriade Srl e le prime attività previste per avviare il progetto:
- *Emanuele Righetto* è il referente principale del progetto e fornirà il supporto tecnico e architetturale;
- *Jessica Dalla Fontana* fungerà da punto di collegamento tra il gruppo e l'associazione *Sanfilippo Fighters*;
- *Anna Baldo* seguirà gli aspetti legati al design e all'eventuale conduzione del workshop di *Design Sprint*.

Come primo passo operativo, la proponente si è offerta di organizzare una *call online con l'associazione Sanfilippo Fighters*, affinché i referenti dell'associazione possano esporre direttamente il dominio del progetto dal punto di vista dei futuri utilizzatori, chiarendo in modo più preciso le aspettative e alcuni requisiti fondamentali.

== Workshop di Design Sprint e analisi dei requisiti

In aggiunta alla call di dominio, Miriade Srl ha proposto di organizzare un *workshop di Design Sprint in presenza*, della durata di *4 ore*, coordinato da Anna Baldo.

Il workshop è finalizzato a:
- individuare in modo chiaro gli attori del sistema (_user personas_) e il relativo percorso operativo all'interno dell'applicazione;
- definire con maggiore precisione le funzionalità attese e classificare i requisiti in obbligatori, desiderabili e opzionali;
- realizzare una prima bozza strutturale delle interfacce (_mockup_ di alto livello), incentrata sulla disposizione degli elementi nelle schermate e sui flussi di interazione piuttosto che sui dettagli grafici fini.

Miriade Srl si occuperà di organizzare gli incontri una volta ricevuta dal gruppo una email di conferma sulle attività di proprio interesse. A valle delle sessioni svolte, il team procederà con l'approfondimento del documento di *Analisi dei Requisiti*.

#fonte_decisione([D7], [Valutare internamente le proposte ricevute e comunicare via email a Miriade Srl a quali attività il gruppo intende aderire.])

== Modalità di comunicazione, frequenza degli incontri e supporto

Per quanto riguarda il coordinamento periodico con l'azienda, la proponente ha lasciato al gruppo la scelta tra incontri a cadenza fissa (settimanali o bisettimanali) oppure incontri _on demand_ su richiesta del team. Emanuele Righetto ha confermato la propria disponibilità, consigliando di fissare gli incontri nella misura in cui risultino effettivamente utili all'avanzamento del gruppo.

Per quanto riguarda i canali di comunicazione, la proponente si è resa disponibile anche all'apertura di una chat dedicata, evidenziando tuttavia come la *posta elettronica* resti generalmente preferibile per le domande rilevanti, in quanto garantisce una risposta più sicura e tempestiva.

Durante la futura fase di progettazione, Miriade Srl potrà fornire supporto mirato (ad esempio su AWS o sulla componente frontend), sia tramite brevi sessioni di _overview_ sia aiutando nella risoluzione di criticità bloccanti; tale affiancamento presuppone tuttavia che il gruppo svolga preventivamente uno studio autonomo di base delle tecnologie adottate.

== Architettura, tecnologie, account AWS e gestione del tempo

In risposta ai dubbi del gruppo sull'aderenza all'architettura descritta nel capitolato, Emanuele Righetto ha confermato che:
- non ci si attende che l'associazione richieda modifiche all'architettura tecnica;
- le tecnologie e le soluzioni proposte nel capitolato *non sono obbligatorie*, ma rappresentano raccomandazioni motivate dal fatto che costituiscono una soluzione solida sulla quale Miriade Srl è in grado di offrire supporto diretto; eventuali proposte alternative possono comunque essere discusse con l'azienda.

Per quanto riguarda gli *account AWS*, la proponente ha segnalato che la richiesta dovrà essere comunicata con un preavviso di almeno *10--15 giorni*. È stato inoltre consigliato al gruppo di iniziare fin da subito a studiare i principali servizi AWS citati (in particolare *AWS Lambda* e *Amazon ECS*) per comprenderne il funzionamento.

#fonte_decisione([D8], [Avviare lo studio autonomo preliminare dei servizi AWS principali citati nel capitolato (es. Lambda, ECS) producendo un documento interno di base.])

#pagebreak()
Infine, sul piano organizzativo, Emanuele Righetto ha consigliato al team di mantenere un ritmo di lavoro costante — evitando picchi di recupero a ridosso delle scadenze — e di prevedere nella pianificazione un adeguato margine di sicurezza rispetto alla data di consegna prevista, così da poter gestire serenamente eventuali ritardi e imprevisti tecnici.




= Tracciamento Azioni

#tabella_decisioni(
  (azioni: (
      (azione: [Redazione verbale esterno 2026-11-17], issue: [#issue(83)], ass: [Carlo Nardin], ver: [Nikola Miljanovic], scad: [2026-11-25]),
  )),
  (id: [D7], azioni: (
      (azione: [Inviare email a Miriade Srl per comunicare l'adesione alle attività proposte ], issue: [#issue(86)], ass: [Godwin Agbleze], ver: [Nikola Miljanovic], scad: [2026-11-22]),
  )),
  (id: [D8], azioni: (
      (azione: [Creare documento di base interno per lo studio dei servizi AWS citati nel capitolato], issue: [#issue(87)], ass: [Mattia Pasquato], ver: [Nikola Miljanovic], scad: [2026-12-01]),
  )),

)

#v(1.5cm)

= Approvazione

Con la presente firma, la proponente conferma che il contenuto del presente verbale rispecchia fedelmente gli argomenti trattati.

#v(1cm)
#align(right)[
  *Per Miriade Srl* \
  Emanuele Righetto \
  // #image("../../../assets/approvazioni/Miriade_2026-11-17.png", width: 30%)
]
