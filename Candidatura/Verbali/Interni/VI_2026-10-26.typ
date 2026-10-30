#import "../template.typ": *

#show: verbale.with(
  titolo: "Verbale Incontro #4",
  data: "2026-10-26",
  versione: "1.0.0",
  uso: "Interno",
  redattore: "Carlo Nardin",
  verificatore: "Godwin Agbleze",
  riassunto: "Riflessione sul Diario di Bordo, stato della candidatura, discussione Preventivo Costi e Dichiarazione Impegni, selezione delle domande per C0 e aggiornamento del Way of Working.",
  registro_modifiche: (
    ([1.0.0], [2026-10-29], [Carlo Nardin], [Godwin Agbleze], [- Prima stesura del verbale]),
  )
)

= Informazioni generali
== Luogo e data della riunione
- *Luogo*: Google Meet
- *Data*: 2026-10-26
- *Ora*: 18:30
- *Durata*: 1 ora e 30 minuti

== Partecipanti
- Godwin Agbleze
- Nikola Miljanovic
- Carlo Nardin
- Mattia Pasquato
- Giacomo Ravazzolo
- Mattia Scomparin

= Ordine del giorno
+ Riflessione sull'esito del Diario di Bordo.
+ Verifica dello stato delle attività sulla Board.
+ Confronto delle stime individuali e definizione del Preventivo Costi e Dichiarazione Impegni.
+ Individuazione dei rischi e ipotesi di rotazione dei ruoli.
+ Selezione delle domande per il proponente del capitolato C0.
+ Principi di Way of Working.

= Discussione
== Diario di Bordo
Il gruppo ha riflettuto sull'esito del Diario di Bordo presentato in mattinata in aula. L'esito è stato positivo: il gruppo ha riscontrato un buon livello di avanzamento, in linea o leggermente avanti rispetto agli altri gruppi, e ha trovato costruttivo l'ascolto delle presentazioni altrui. Sono state condivise le opinioni di ciascuno, individuando cosa e dove migliorare in vista dei prossimi Diari di Bordo. Il gruppo ha deciso che, dopo ogni Diario di Bordo, ci si riunirà per aggiornare gli eventuali componenti non partecipanti e per discutere quanto emerso dagli interventi del professore e degli altri gruppi.


== Stato della candidatura
Il gruppo ha fatto il punto sulla candidatura, verificando sulla Board le attività mappate ancora da concludere.

== Preventivo Costi e Dichiarazione Impegni
Ogni componente ha condiviso la propria versione dell'analisi di costi e ore, finalizzata alla redazione del Preventivo Costi e Dichiarazione Impegni. Il gruppo ha discusso le versioni proposte e ha definito una versione concordata, che sarà quella presentata in candidatura. Il gruppo è consapevole che la stima potrebbe essere migliorata quando si disporrà di basi più solide per una valutazione puntuale.

Mattia Pasquato ha presentato uno strumento web da lui realizzato, "Stima ore e costi", che offre una panoramica rapida al variare delle ore assegnate a ciascun ruolo. Inserendo le ore per i sei ruoli, lo strumento mostra:
- ore e costo totali, per ruolo e complessivi;
- il confronto con l'intervallo di ore previsto a persona;
- il confronto con il costo minimo ammesso in candidatura;
- il costo medio orario e la differenza rispetto al costo minimo;
- un grafico della ripartizione delle ore per ruolo.

== Rischi e rotazione dei ruoli
La discussione non si è limitata alla ripartizione delle ore per ruolo e al conseguente calcolo di spesa e scadenza. A partire dal capitolato, dal contesto generale e dalla situazione individuale, il gruppo ha individuato possibili rischi e un'ipotesi di rotazione dei ruoli adatta. Entrambi saranno definiti nel dettaglio e documentati.

== Domande per il proponente di C0
Il gruppo aveva già preparato alcune domande sul capitolato C0 da inviare a Sanmarco Informatica. Ha selezionato quelle da porre e ha incaricato Mattia Scomparin dell'invio.

== Way of Working
Il gruppo ha ripreso le regole sulla gestione della repository fissate nel terzo incontro interno e ne ha definite di nuove, come segue.

*Gestione delle issue*
- Ogni issue presente nella repository deve essere presente anche nella Board, che al momento costituisce il nostro _cruscotto_ di riferimento per le attività.

*Nomenclatura dei documenti*
- Verbali interni: `VI_AAAA-MM-GG`.
- Verbali esterni: `VE_proponente_AAAA-MM-GG`.
- Altri documenti, come quelli presentati per la candidatura: nomi in minuscolo, con `_` al posto degli spazi.

*Strumenti di supporto*
- Nikola Miljanovic ha comunicato al gruppo che inizierà a lavorare a uno strumento che consenta di redigere i verbali interni direttamente da un'interfaccia a modulo (form), per aumentarne la velocità di stesura, in vista delle prossime fasi del progetto in cui sarà necessario ottimizzare al meglio il tempo a disposizione.

#pagebreak()

= Tracciamento Azioni

#tabella_azioni(
  issue(1), [Invio domande a Sanmarco (C0)], [Mattia Scomparin], [Carlo Nardin],
  issue(12), [Consolidamento del Preventivo Costi e Dichiarazione Impegni], [Giacomo Ravazzolo, \  Mattia Pasquato], [Carlo Nardin],
  issue(54), [Strumento per la Redazione dei Verbali Interni], [Nikola Miljanovic], [Mattia Pasquato]
)

#v(1cm)
*Prossimo incontro:* da fissare

