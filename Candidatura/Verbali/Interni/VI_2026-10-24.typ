#import "../template.typ": *

#show: verbale.with(
  titolo: "Verbale Incontro #3",
  data: "2026-10-24",
  versione: "1.0.0",
  uso: "Interno",
  redattore: "Carlo Nardin",
  verificatore: "Mattia Scomparin",
  riassunto: "Condivisione esiti incontri aziendali, consolidamento del Way of Working (Board, Repo, Typst Actions), stato di avanzamento e pianificazione del Preventivo Costi e Ore.",
  registro_modifiche: (
    ([1.0.0], [2026-10-25], [Carlo Nardin], [Mattia Scomparin], [- Prima stesura del verbale]),
  )
)

= Informazioni generali
== Luogo e data della riunione
- *Luogo*: Google Meet
- *Data*: 2026-10-24
- *Ora*: 16:00
- *Durata*: 1 ora e 30 minuti

== Partecipanti
- Godwin Agbleze
- Nikola Miljanovic
- Carlo Nardin
- Mattia Pasquato
- Giacomo Ravazzolo
- Mattia Scomparin

= Ordine del giorno
+ Condivisione esiti dei primi due incontri con le aziende proponenti.
+ Valutazione Capitolato C0 e richieste di chiarimento.
+ Approvazione struttura cruscotto GitHub (Board e Issue).
+ Approvazione infrastruttura documentale (GitHub Pages e Actions Typst).
+ Definizione regole operative della repository.
+ Stato di avanzamento documentazione (Verbali esterni, Valutazione capitolati).
+ Pianificazione preventivo costi e ore.
+ Revisione presentazione per il Diario di Bordo.

= Discussione
== Incontri aziendali e Capitolato C0
Il gruppo ha condiviso gli esiti dei due incontri con le aziende proponenti, Miriade (C5) ed Ergon (C7), aggiornando i membri che non vi avevano partecipato per motivi lavorativi. Il dettaglio è riportato nei rispettivi verbali esterni, consultabili qui: #underline[#link("https://deadlockguild.github.io/docs/")].

Il gruppo ha poi valutato il Capitolato C0, terza preferenza dopo C5 e C7. Sono emersi dubbi interpretativi sul testo del capitolato, per cui si è deciso di chiedere chiarimenti tecnici all'azienda proponente tramite email.

== Way of Working e Infrastruttura
Il gruppo ha esaminato e approvato all'unanimità l'organizzazione del cruscotto GitHub proposta da Mattia Pasquato. Le Board sono configurate in tre viste: tutte le issue, issue assegnate al singolo utente e Roadmap di progetto.

Il gruppo ha inoltre approvato l'infrastruttura documentale proposta da Carlo Nardin: i PDF sono generati automaticamente dai file `.typ` tramite GitHub Actions e pubblicati su GitHub Pages per la consultazione esterna. È stato fissato anche un template Typst di base unificato, adattabile a tutti i documenti di progetto.

Sono state definite le seguenti regole operative per la repository:
- Il branch `main` contiene esclusivamente documentazione di progetto verificata.
- Sviluppo e stesura avvengono su branch secondari, nominati secondo lo standard automatico suggerito da GitHub, per evitare discrepanze.
- L'integrazione in `main` avviene solo tramite Pull Request, con revisione obbligatoria da parte del verificatore designato.

== Avanzamento documentazione e Preventivo
Il gruppo ha fatto il punto sui documenti in corso. I tre redattori incaricati stanno redigendo il documento di Valutazione dei Capitolati, mentre i verbali esterni degli incontri aziendali sono in fase di stesura.

Per la candidatura è stata definita la strategia per il Preventivo Costi e Ore: ogni componente produce autonomamente una stima individuale, basata sul Regolamento del Progetto Didattico. Le bozze devono essere pronte entro il 2026-10-26 e saranno analizzate per definire il preventivo unificato.

Infine Giacomo Ravazzolo ha presentato lo stato di avanzamento della presentazione per il Diario di Bordo del 2026-10-26, raccogliendo i feedback del team sui contenuti da integrare.

= Tracciamento Azioni

#tabella_azioni(
  issue(1), [Email chiarimenti per C0], [Mattia Scomparin], [Carlo Nardin],
  issue(5), [Migrazione nella repo di Pages e Actions], [Carlo Nardin], [Mattia Pasquato],
  issue(8), [Concludere Presentazione Diario di Bordo], [Giacomo Ravazzolo], [Nikola Miljanovic],
  issue(12), [Stesura bozze per Preventivo Costi e Ore (entro 2026-10-26)], [Team], [-],
  issue(20), [Redazione Verbale Interno], [Carlo Nardin], [Mattia Scomparin],
  issue(21), [Redazione Verbale Esterno - Miriade], [Carlo Nardin], [Giacomo Ravazzolo],
  issue(22), [Redazione Verbale Esterno - Ergon], [Carlo Nardin], [Mattia Pasquato]
)

#v(1cm)
*Prossimi incontri:* 2026-10-26 mattina in aula (Diario di Bordo) e pomeriggio su Google Meet.
