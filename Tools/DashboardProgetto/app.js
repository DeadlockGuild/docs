"use strict";

// ---------------------------------------------------------------------------
// Utilità
// ---------------------------------------------------------------------------
const $ = (id) => document.getElementById(id);
const GIORNO = 86400000;
const SVG_NS = "http://www.w3.org/2000/svg";

const euro = new Intl.NumberFormat("it-IT", { style: "currency", currency: "EUR", minimumFractionDigits: 2, useGrouping: "always" });
const euroTondo = new Intl.NumberFormat("it-IT", { style: "currency", currency: "EUR", maximumFractionDigits: 0, useGrouping: "always" });
const numero = new Intl.NumberFormat("it-IT", { maximumFractionDigits: 1, useGrouping: "always" });
const percento = new Intl.NumberFormat("it-IT", { style: "percent", maximumFractionDigits: 0 });
const mese = new Intl.DateTimeFormat("it-IT", { month: "short" });

// Le date sono stringhe "AAAA-MM-GG" interpretate come giorni locali
function data(s) {
  if (!s) return null;
  const [a, m, g] = s.split("-").map(Number);
  return new Date(a, m - 1, g);
}
function iso(d) {
  return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, "0")}-${String(d.getDate()).padStart(2, "0")}`;
}
function dataIt(s) {
  const d = data(s);
  return d ? `${String(d.getDate()).padStart(2, "0")}/${String(d.getMonth() + 1).padStart(2, "0")}/${d.getFullYear()}` : "–";
}
function giorni(da, a) { return Math.round((a - da) / GIORNO); }
function nGiorni(n) { return `${n} ${n === 1 ? "giorno" : "giorni"}`; }
function aggiungiGiorni(d, n) { return new Date(d.getFullYear(), d.getMonth(), d.getDate() + n); }
function esc(s) {
  return String(s ?? "").replace(/[&<>"']/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;" }[c]));
}
function stato(classe, testo) { return `<span class="stato ${classe}">${esc(testo)}</span>`; }

// "Oggi" può essere forzato con ?oggi=AAAA-MM-GG per provare la dashboard in date diverse
const OGGI = (() => {
  const p = new URLSearchParams(location.search).get("oggi");
  if (p && /^\d{4}-\d{2}-\d{2}$/.test(p)) return data(p);
  const n = new Date();
  return new Date(n.getFullYear(), n.getMonth(), n.getDate());
})();

// ---------------------------------------------------------------------------
// Stato
// ---------------------------------------------------------------------------
let dati = null;
let modificato = false;
let sprintSelezionato = null;
let sprintInModifica = null;

function normalizza(d) {
  d.ruoli ??= [];
  d.membri ??= [];
  d.milestone ??= [];
  d.sprint ??= [];
  d.sprint.forEach((s, i) => {
    s.id ??= i + 1;
    s.assegnazioni ??= [];
    s.registro ??= [];
  });
  ordina(d);
  return d;
}
function ordina(d) {
  d.sprint.sort((a, b) => a.inizio.localeCompare(b.inizio));
  d.milestone.sort((a, b) => a.data.localeCompare(b.data));
}

function imposta(d, fonte) {
  dati = normalizza(d);
  $("fonte").textContent = `Dati: ${fonte}`;
  $("nomeProgetto").textContent = dati.progetto.nome;
  $("orePerMembro").textContent = dati.progetto.orePerMembro;
  sprintSelezionato = sprintCorrente()?.id ?? dati.sprint.at(-1)?.id ?? null;
  segnaModificato(false);
  disegna();
}

function segnaModificato(v) {
  modificato = v;
  $("avviso").hidden = !v;
}

async function caricaDati() {
  try {
    const r = await fetch("dati.json", { cache: "no-store" });
    if (!r.ok) throw new Error(r.status);
    imposta(await r.json(), "dati.json");
  } catch (e) {
    $("fonte").textContent = "Impossibile leggere dati.json: apri la pagina da un server o usa «Apri file JSON».";
    $("kpi").innerHTML = `<div class="vuoto" style="grid-column: 1 / -1">Nessun dato caricato.</div>`;
  }
}

// ---------------------------------------------------------------------------
// Calcoli
// ---------------------------------------------------------------------------
function ruolo(id) { return dati.ruoli.find((r) => r.id === id); }
function indiceRuolo(id) { return dati.ruoli.findIndex((r) => r.id === id); }
function coloreRuolo(id) { return `var(--serie-${(indiceRuolo(id) % 6) + 1})`; }

function costoSprint(s) {
  return s.assegnazioni.reduce((t, a) => t + (Number(a.ore) || 0) * (ruolo(a.ruolo)?.costoOrario ?? 0), 0);
}
function oreSprint(s) {
  return s.assegnazioni.reduce((t, a) => t + (a.ruolo ? Number(a.ore) || 0 : 0), 0);
}

// Sprint corrente: il primo non chiuso che contiene oggi, altrimenti il prossimo non chiuso
function sprintCorrente() {
  return dati.sprint.find((s) => !s.chiuso && data(s.inizio) <= OGGI && OGGI <= data(s.fine))
    ?? dati.sprint.find((s) => !s.chiuso && data(s.inizio) > OGGI);
}
function sprintAperti() { return dati.sprint.filter((s) => !s.chiuso); }
function statoSprint(s) {
  if (s.chiuso) return "chiuso";
  if (OGGI > data(s.fine)) return "concluso";
  if (OGGI < data(s.inizio)) return "futuro";
  return "in corso";
}

function calcola(sprint = dati.sprint) {
  const oreRuolo = Object.fromEntries(dati.ruoli.map((r) => [r.id, 0]));
  const matrice = Object.fromEntries(dati.membri.map((m) => [m, { ...oreRuolo }]));
  let oreTotali = 0;
  let costoTotale = 0;
  const cumulato = [];
  for (const s of sprint) {
    for (const a of s.assegnazioni) {
      const ore = Number(a.ore) || 0;
      if (!a.ruolo || !(a.ruolo in oreRuolo)) continue;
      oreRuolo[a.ruolo] += ore;
      if (matrice[a.membro]) matrice[a.membro][a.ruolo] += ore;
      oreTotali += ore;
    }
    const c = costoSprint(s);
    costoTotale += c;
    cumulato.push({ sprint: s, costo: c, totale: costoTotale });
  }
  const oreMembro = Object.fromEntries(dati.membri.map((m) => [m, Object.values(matrice[m]).reduce((a, b) => a + b, 0)]));
  return { oreRuolo, matrice, oreMembro, oreTotali, costoTotale, cumulato };
}

function orePreviste() { return dati.ruoli.reduce((t, r) => t + r.orePreviste, 0); }
function inizioProgetto() {
  const primo = dati.sprint[0] ? data(dati.sprint[0].inizio) : OGGI;
  return primo < OGGI ? primo : OGGI;
}

// Confronta il costo speso con il tempo trascorso e proietta il costo alla consegna
function andamento(c) {
  const max = dati.progetto.costoMassimo;
  if (c.costoTotale > max) return { classe: "ko", testo: `Costo massimo superato di ${euro.format(c.costoTotale - max)}` };
  const registrati = dati.sprint.filter((s) => oreSprint(s) > 0);
  if (!registrati.length) return { classe: "info", testo: "Nessuna ora registrata" };
  const inizio = data(registrati[0].inizio);
  const fine = data(registrati.at(-1).fine);
  const durata = giorni(inizio, aggiungiGiorni(fine, 1));
  const totale = giorni(inizio, aggiungiGiorni(data(dati.progetto.scadenza), 1));
  if (durata <= 0 || totale <= 0) return { classe: "info", testo: "Dati insufficienti" };
  const proiezione = (c.costoTotale / durata) * totale;
  if (proiezione > max) return { classe: "warn", testo: `Proiezione alla consegna ${euroTondo.format(proiezione)}` };
  return { classe: "ok", testo: `In linea: proiezione ${euroTondo.format(proiezione)}` };
}

function statoMilestone(m) {
  const g = giorni(OGGI, data(m.data));
  if (m.raggiunta) return { classe: "ok", testo: "Raggiunta", g };
  if (g < 0) return { classe: "ko", testo: "Scaduta", g };
  if (g <= 14) return { classe: "warn", testo: "Imminente", g };
  return { classe: "info", testo: "In programma", g };
}

// ---------------------------------------------------------------------------
// Tooltip condiviso
// ---------------------------------------------------------------------------
const tooltip = $("tooltip");
function mostraTip(html, e) {
  tooltip.innerHTML = html;
  tooltip.hidden = false;
  const w = tooltip.offsetWidth;
  const h = tooltip.offsetHeight;
  const x = Math.min(Math.max(e.clientX - w / 2, 8), window.innerWidth - w - 8);
  const y = e.clientY - h - 14 < 8 ? e.clientY + 18 : e.clientY - h - 14;
  tooltip.style.left = x + "px";
  tooltip.style.top = y + "px";
}
function nascondiTip() { tooltip.hidden = true; }
function collegaTip(el, html) {
  el.addEventListener("mousemove", (e) => mostraTip(typeof html === "function" ? html() : html, e));
  el.addEventListener("mouseleave", nascondiTip);
}

function svg(tag, attr = {}, testo) {
  const el = document.createElementNS(SVG_NS, tag);
  for (const [k, v] of Object.entries(attr)) el.setAttribute(k, v);
  if (testo !== undefined) el.textContent = testo;
  return el;
}

// ---------------------------------------------------------------------------
// Disegno
// ---------------------------------------------------------------------------
function disegna() {
  const c = calcola();
  disegnaKpi(c);
  disegnaOreRuolo(c);
  disegnaCosto(c);
  disegnaTimeline();
  disegnaMatrice(c);
  disegnaControlli(c);
  disegnaSprint();
}

function disegnaKpi(c) {
  const p = dati.progetto;
  const previste = orePreviste();
  const scad = data(p.scadenza);
  const gConsegna = giorni(OGGI, scad);
  const prossima = dati.milestone.find((m) => !m.raggiunta && data(m.data) >= OGGI);
  const corrente = sprintCorrente();
  const and = andamento(c);
  const barra = (v, max, colore = "var(--accent)") =>
    `<div class="progresso"><span style="width:${Math.min(100, (v / max) * 100)}%; background:${colore}"></span></div>`;

  let sprintHtml = `<div class="valore">–</div><div class="dettaglio">Nessuno sprint in corso</div>`;
  if (corrente) {
    const inCorso = statoSprint(corrente) === "in corso";
    const g = inCorso ? giorni(OGGI, data(corrente.fine)) : giorni(OGGI, data(corrente.inizio));
    sprintHtml = `<div class="valore">${esc(corrente.nome)}</div>
      <div class="dettaglio">${inCorso ? `Termina tra ${nGiorni(g)} (${dataIt(corrente.fine)})` : `Inizia tra ${nGiorni(g)} (${dataIt(corrente.inizio)})`}</div>`;
  }

  $("kpi").innerHTML = `
    <section>
      <span class="etichetta">Ore utilizzate</span>
      <div class="valore">${numero.format(c.oreTotali)} <small>/ ${previste} h</small></div>
      ${barra(c.oreTotali, previste, c.oreTotali > previste ? "var(--ko)" : "var(--accent)")}
      <div class="dettaglio">${numero.format(Math.max(0, previste - c.oreTotali))} h rimanenti</div>
    </section>
    <section>
      <span class="etichetta">Costo effettivo</span>
      <div class="valore">${euro.format(c.costoTotale)}</div>
      ${barra(c.costoTotale, p.costoMassimo, c.costoTotale > p.costoMassimo ? "var(--ko)" : "var(--accent)")}
      <div class="dettaglio">Massimo ${euro.format(p.costoMassimo)} · ${euro.format(Math.max(0, p.costoMassimo - c.costoTotale))} rimanenti</div>
    </section>
    <section>
      <span class="etichetta">Consegna del progetto</span>
      <div class="valore">${gConsegna >= 0 ? `${gConsegna} <small>giorni</small>` : "Scaduta"}</div>
      <div class="dettaglio">${dataIt(p.scadenza)} · circa ${numero.format(Math.max(0, gConsegna) / 7)} settimane</div>
    </section>
    <section>
      <span class="etichetta">Prossima milestone</span>
      ${prossima
        ? `<div class="valore" style="font-size:1.05rem">${esc(prossima.nome)}</div>
           <div class="dettaglio">${dataIt(prossima.data)} · tra ${nGiorni(giorni(OGGI, data(prossima.data)))}</div>`
        : `<div class="valore">–</div><div class="dettaglio">Nessuna milestone futura</div>`}
    </section>
    <section>
      <span class="etichetta">Sprint corrente</span>
      ${sprintHtml}
    </section>`;

  $("andamentoCosto").innerHTML = stato(and.classe, and.testo);
  $("giorniConsegna").textContent = `Oggi ${dataIt(iso(OGGI))} · consegna tra ${nGiorni(gConsegna)}`;
}

function disegnaOreRuolo(c) {
  const contenitore = $("oreRuolo");
  contenitore.innerHTML = "";
  for (const r of dati.ruoli) {
    const usate = c.oreRuolo[r.id];
    const quota = r.orePreviste ? usate / r.orePreviste : 0;
    const oltre = usate > r.orePreviste;
    const riga = document.createElement("div");
    riga.className = "riga-ruolo";
    riga.innerHTML = `
      <span class="nome"><span class="colore" style="background:${coloreRuolo(r.id)}"></span>${esc(r.nome)}</span>
      <div class="pista">
        <div class="riempimento" style="width:${Math.min(100, quota * 100)}%; background:${coloreRuolo(r.id)}"></div>
        ${oltre ? `<div class="eccesso"></div>` : ""}
      </div>
      <span class="valori">${numero.format(usate)} / ${r.orePreviste} h
        <small>${oltre ? stato("ko", `+${numero.format(usate - r.orePreviste)} h`) : `${percento.format(quota)} · ${numero.format(r.orePreviste - usate)} h libere`}</small>
      </span>`;
    collegaTip(riga, `<strong>${esc(r.nome)}</strong>
      ${numero.format(usate)} h su ${r.orePreviste} h previste<br>
      Costo: ${euro.format(usate * r.costoOrario)} su ${euro.format(r.orePreviste * r.costoOrario)}<br>
      ${r.costoOrario} €/h`);
    contenitore.appendChild(riga);
  }
  $("oreRuoloTotale").textContent = `${numero.format(c.oreTotali)} / ${orePreviste()} h`;
}

// Arrotonda il massimo dell'asse a un valore "comodo"
function massimoComodo(v) {
  const passo = Math.pow(10, Math.floor(Math.log10(v))) / 4;
  return Math.ceil(v / passo) * passo;
}

function disegnaCosto(c) {
  const box = $("graficoCosto");
  box.innerHTML = "";
  const W = 640, H = 260, m = { s: 62, d: 14, a: 14, b: 26 };
  const inizio = inizioProgetto();
  let fine = data(dati.progetto.scadenza);
  const ultimo = dati.sprint.at(-1);
  if (ultimo && data(ultimo.fine) > fine) fine = data(ultimo.fine);
  const max = dati.progetto.costoMassimo;
  const yMax = massimoComodo(Math.max(max, c.costoTotale) * 1.08);
  const x = (d) => m.s + ((d - inizio) / Math.max(1, fine - inizio)) * (W - m.s - m.d);
  const y = (v) => H - m.b - (v / yMax) * (H - m.a - m.b);

  const s = svg("svg", { viewBox: `0 0 ${W} ${H}`, role: "img", "aria-label": "Costo cumulativo per sprint rispetto al costo massimo" });

  // Griglia e assi
  const griglia = svg("g", { class: "griglia" });
  for (let i = 0; i <= 4; i++) {
    const v = (yMax / 4) * i;
    griglia.appendChild(svg("line", { x1: m.s, x2: W - m.d, y1: y(v), y2: y(v) }));
    s.appendChild(svg("text", { x: m.s - 6, y: y(v) + 4, "text-anchor": "end" }, euroTondo.format(v)));
  }
  s.insertBefore(griglia, s.firstChild);
  s.appendChild(svg("line", { class: "asse", x1: m.s, x2: W - m.d, y1: y(0), y2: y(0) }));
  for (let d = new Date(inizio.getFullYear(), inizio.getMonth() + 1, 1); d <= fine; d = new Date(d.getFullYear(), d.getMonth() + 1, 1)) {
    s.appendChild(svg("line", { class: "asse", x1: x(d), x2: x(d), y1: y(0), y2: y(0) + 4 }));
    s.appendChild(svg("text", { x: x(d), y: H - 8, "text-anchor": "middle" }, mese.format(d)));
  }

  // Costo massimo e andamento ideale (lineare fino alla consegna)
  s.appendChild(svg("line", { x1: m.s, x2: W - m.d, y1: y(max), y2: y(max), stroke: "var(--ko)", "stroke-width": 1.5 }));
  s.appendChild(svg("text", { x: W - m.d, y: y(max) - 6, "text-anchor": "end" }, `Massimo ${euro.format(max)}`));
  const scad = data(dati.progetto.scadenza);
  s.appendChild(svg("line", {
    x1: x(inizio), y1: y(0), x2: x(scad), y2: y(max),
    stroke: "var(--text-muted)", "stroke-width": 1.5, "stroke-dasharray": "5 4",
  }));

  // Oggi
  if (OGGI >= inizio && OGGI <= fine) {
    s.appendChild(svg("line", { x1: x(OGGI), x2: x(OGGI), y1: m.a, y2: y(0), stroke: "var(--accent)", "stroke-width": 1, "stroke-dasharray": "2 3" }));
    s.appendChild(svg("text", { x: x(OGGI) + 4, y: m.a + 8 }, "oggi"));
  }

  // Costo effettivo: un punto alla fine di ogni sprint
  const punti = [{ x: x(inizio), y: y(0) }, ...c.cumulato.map((p) => ({ x: x(data(p.sprint.fine)), y: y(p.totale), p }))];
  if (c.cumulato.length) {
    s.appendChild(svg("path", {
      d: punti.map((p, i) => `${i ? "L" : "M"}${p.x},${p.y}`).join(" "),
      fill: "none", stroke: "var(--serie-1)", "stroke-width": 2, "stroke-linejoin": "round",
    }));
    for (const p of punti.slice(1)) {
      s.appendChild(svg("circle", { cx: p.x, cy: p.y, r: 4.5, fill: "var(--serie-1)", stroke: "var(--bg-section)", "stroke-width": 2 }));
    }
    const ultimoPunto = punti.at(-1);
    s.appendChild(svg("text", { x: ultimoPunto.x + 8, y: ultimoPunto.y - 8, style: "fill: var(--text-main); font-weight: 700" }, euroTondo.format(c.costoTotale)));
  } else {
    s.appendChild(svg("text", { x: W / 2, y: H / 2, "text-anchor": "middle" }, "Nessuno sprint registrato"));
  }

  // Interazione: mirino sul punto più vicino
  const mirino = svg("line", { y1: m.a, y2: y(0), stroke: "var(--axis)", "stroke-width": 1, visibility: "hidden" });
  s.appendChild(mirino);
  const area = svg("rect", { x: m.s, y: m.a, width: W - m.s - m.d, height: H - m.a - m.b, fill: "transparent" });
  s.appendChild(area);
  area.addEventListener("mousemove", (e) => {
    if (!c.cumulato.length) return;
    const r = s.getBoundingClientRect();
    const px = ((e.clientX - r.left) / r.width) * W;
    const vicino = punti.slice(1).reduce((a, b) => (Math.abs(b.x - px) < Math.abs(a.x - px) ? b : a));
    mirino.setAttribute("x1", vicino.x);
    mirino.setAttribute("x2", vicino.x);
    mirino.setAttribute("visibility", "visible");
    const sp = vicino.p.sprint;
    mostraTip(`<strong>${esc(sp.nome)}</strong>${dataIt(sp.inizio)} – ${dataIt(sp.fine)}<br>
      Costo sprint: ${euro.format(vicino.p.costo)}<br>
      Cumulato: ${euro.format(vicino.p.totale)} (${percento.format(vicino.p.totale / max)} del massimo)`, e);
  });
  area.addEventListener("mouseleave", () => { mirino.setAttribute("visibility", "hidden"); nascondiTip(); });

  box.appendChild(s);
}

function disegnaTimeline() {
  const box = $("timeline");
  box.innerHTML = "";
  const W = 1000, H = 150;
  const m = { s: 10, d: 10 };
  const inizio = inizioProgetto();
  let fine = aggiungiGiorni(data(dati.progetto.scadenza), 7);
  for (const s of dati.sprint) if (data(s.fine) > fine) fine = aggiungiGiorni(data(s.fine), 7);
  for (const ms of dati.milestone) if (data(ms.data) > fine) fine = aggiungiGiorni(data(ms.data), 7);
  const x = (d) => m.s + ((d - inizio) / Math.max(1, fine - inizio)) * (W - m.s - m.d);
  const yMilestone = 62, ySprint = 88, hSprint = 26, yAsse = 126;

  const s = svg("svg", { viewBox: `0 0 ${W} ${H}`, role: "img", "aria-label": "Linea del tempo di sprint e milestone" });
  s.appendChild(svg("line", { class: "asse", x1: m.s, x2: W - m.d, y1: yAsse, y2: yAsse }));
  for (let d = new Date(inizio.getFullYear(), inizio.getMonth() + 1, 1); d <= fine; d = new Date(d.getFullYear(), d.getMonth() + 1, 1)) {
    s.appendChild(svg("line", { class: "asse", x1: x(d), x2: x(d), y1: yAsse, y2: yAsse + 5 }));
    s.appendChild(svg("text", { x: x(d), y: yAsse + 18, "text-anchor": "middle" }, `${mese.format(d)} ${String(d.getFullYear()).slice(2)}`));
  }

  // Sprint: grigio se conclusi, arancione se in corso, contorno se futuri
  for (const sp of dati.sprint) {
    const st = statoSprint(sp);
    const x1 = x(data(sp.inizio));
    const larghezza = Math.max(3, x(aggiungiGiorni(data(sp.fine), 1)) - x1 - 2);
    const g = svg("g", { style: "cursor: pointer" });
    g.appendChild(svg("rect", {
      x: x1, y: ySprint, width: larghezza, height: hSprint, rx: 4,
      fill: st === "concluso" || st === "chiuso" ? "var(--axis)" : st === "in corso" ? "var(--accent)" : "var(--bg-section)",
      stroke: st === "futuro" ? "var(--axis)" : "none", "stroke-width": 1.5,
    }));
    if (larghezza > 34) {
      g.appendChild(svg("text", {
        x: x1 + larghezza / 2, y: ySprint + 17, "text-anchor": "middle",
        style: `fill: ${st === "in corso" ? "#fff" : "var(--text-main)"}; font-weight: 700`,
      }, sp.nome.replace(/^Sprint\s*/i, "S")));
    }
    collegaTip(g, `<strong>${esc(sp.nome)}</strong>${dataIt(sp.inizio)} – ${dataIt(sp.fine)} (${st})<br>
      ${numero.format(oreSprint(sp))} h · ${euro.format(costoSprint(sp))}`);
    g.addEventListener("click", () => { sprintSelezionato = sp.id; disegnaSprint(); $("pillole").scrollIntoView({ behavior: "smooth", block: "center" }); });
    s.appendChild(g);
  }

  // Milestone: rombo con etichetta su due livelli alternati per evitare sovrapposizioni
  dati.milestone.forEach((ms, i) => {
    const st = statoMilestone(ms);
    const cx = x(data(ms.data));
    const g = svg("g");
    g.appendChild(svg("line", { x1: cx, x2: cx, y1: yMilestone, y2: yAsse, stroke: "var(--text-muted)", "stroke-width": 1, "stroke-dasharray": "3 3" }));
    g.appendChild(svg("rect", {
      x: cx - 6, y: yMilestone - 6, width: 12, height: 12, transform: `rotate(45 ${cx} ${yMilestone})`,
      fill: st.classe === "ok" ? "var(--ok)" : st.classe === "ko" ? "var(--ko)" : "var(--text-main)",
      stroke: "var(--bg-section)", "stroke-width": 2,
    }));
    const yTesto = i % 2 ? 14 : 34;
    const ancora = cx > W - 150 ? "end" : cx < 150 ? "start" : "middle";
    g.appendChild(svg("text", { x: cx, y: yTesto, "text-anchor": ancora, style: "fill: var(--text-main); font-weight: 700" }, ms.nome));
    g.appendChild(svg("text", { x: cx, y: yTesto + 13, "text-anchor": ancora }, dataIt(ms.data)));
    collegaTip(g, `<strong>${esc(ms.nome)}</strong>${dataIt(ms.data)} · ${st.testo}${ms.descrizione ? `<br>${esc(ms.descrizione)}` : ""}`);
    s.appendChild(g);
  });

  // Oggi
  if (OGGI >= inizio && OGGI <= fine) {
    s.appendChild(svg("line", { x1: x(OGGI), x2: x(OGGI), y1: yMilestone - 4, y2: yAsse, stroke: "var(--accent)", "stroke-width": 2 }));
    s.appendChild(svg("text", { x: x(OGGI) + 4, y: yAsse - 4, style: "fill: var(--accent); font-weight: 700" }, "oggi"));
  }
  box.appendChild(s);

  $("tabellaMilestone").innerHTML = dati.milestone.length
    ? dati.milestone.map((ms) => {
      const st = statoMilestone(ms);
      return `<tr><td><b>${esc(ms.nome)}</b></td><td>${dataIt(ms.data)}</td>
        <td class="num">${st.g >= 0 ? st.g : `${-st.g} fa`}</td><td>${stato(st.classe, st.testo)}</td>
        <td style="white-space: normal">${esc(ms.descrizione)}</td></tr>`;
    }).join("")
    : `<tr><td colspan="5" class="zero">Nessuna milestone definita</td></tr>`;
}

function disegnaMatrice(c) {
  const ore = dati.progetto.orePerMembro;
  const intestazione = dati.ruoli.map((r) =>
    `<th class="num"><span class="colore" style="background:${coloreRuolo(r.id)}; margin-right:4px"></span>${esc(r.nome)}</th>`).join("");
  const righe = dati.membri.map((mb) => {
    const tot = c.oreMembro[mb];
    const celle = dati.ruoli.map((r) => {
      const v = c.matrice[mb][r.id];
      return `<td class="num ${v ? "" : "zero"}">${v ? numero.format(v) : "–"}</td>`;
    }).join("");
    const colore = tot > ore ? "var(--ko)" : "var(--accent)";
    return `<tr><td><b>${esc(mb)}</b></td>${celle}
      <td class="num"><b>${numero.format(tot)}</b> / ${ore} h
        <span class="progresso mini"><span style="width:${Math.min(100, (tot / ore) * 100)}%; background:${colore}"></span></span></td></tr>`;
  }).join("");
  const piede = dati.ruoli.map((r) => {
    const v = c.oreRuolo[r.id];
    return `<td class="num" style="${v > r.orePreviste ? "color: var(--ko-testo)" : ""}">${numero.format(v)} / ${r.orePreviste}</td>`;
  }).join("");
  $("matrice").innerHTML = `<table>
    <thead><tr><th>Membro</th>${intestazione}<th class="num">Totale</th></tr></thead>
    <tbody>${righe}</tbody>
    <tfoot><tr><td>Totale</td>${piede}<td class="num">${numero.format(c.oreTotali)} / ${orePreviste()} h</td></tr></tfoot>
  </table>`;
}

// Verifica le regole di rotazione descritte nel preventivo
function controlliRegole(c) {
  const p = dati.progetto;
  const out = [];
  const elenco = (v) => v.slice(0, 4).join("; ") + (v.length > 4 ? ` e altri ${v.length - 4}` : "");

  out.push(c.costoTotale <= p.costoMassimo
    ? { classe: "ok", testo: "Costo entro il massimo", dettaglio: `${euro.format(c.costoTotale)} su ${euro.format(p.costoMassimo)}` }
    : { classe: "ko", testo: "Costo massimo superato", dettaglio: `${euro.format(c.costoTotale - p.costoMassimo)} oltre il preventivo` });

  const ruoliOltre = dati.ruoli.filter((r) => c.oreRuolo[r.id] > r.orePreviste)
    .map((r) => `${r.nome} +${numero.format(c.oreRuolo[r.id] - r.orePreviste)} h`);
  out.push(ruoliOltre.length
    ? { classe: "ko", testo: "Ore oltre il preventivo per ruolo", dettaglio: elenco(ruoliOltre) }
    : { classe: "ok", testo: "Ore per ruolo entro il preventivo" });

  const membriOltre = dati.membri.filter((m) => c.oreMembro[m] > p.orePerMembro)
    .map((m) => `${m} +${numero.format(c.oreMembro[m] - p.orePerMembro)} h`);
  out.push(membriOltre.length
    ? { classe: "ko", testo: `Membri oltre le ${p.orePerMembro} ore`, dettaglio: elenco(membriOltre) }
    : { classe: "ok", testo: `Ogni membro entro le ${p.orePerMembro} ore` });

  if (!dati.sprint.length) {
    out.push({ classe: "info", testo: "Regole degli sprint", dettaglio: "Verranno controllate dopo il primo sprint." });
    return out;
  }

  const responsabili = dati.sprint.filter((s) => s.assegnazioni.filter((a) => a.ruolo === "responsabile").length !== 1).map((s) => s.nome);
  out.push(responsabili.length
    ? { classe: "ko", testo: "Sprint senza un unico responsabile", dettaglio: elenco(responsabili) }
    : { classe: "ok", testo: "Un solo responsabile per sprint" });

  const senzaRuolo = [];
  for (const s of dati.sprint) {
    const assegnati = new Set(s.assegnazioni.filter((a) => a.ruolo).map((a) => a.membro));
    const mancanti = dati.membri.filter((m) => !assegnati.has(m));
    if (mancanti.length) senzaRuolo.push(`${s.nome}: ${mancanti.join(", ")}`);
  }
  out.push(senzaRuolo.length
    ? { classe: "ko", testo: "Membri senza ruolo", dettaglio: elenco(senzaRuolo) }
    : { classe: "ok", testo: "Ogni membro ha un ruolo in ogni sprint" });

  const ripetuti = [];
  for (let i = 1; i < dati.sprint.length; i++) {
    const prima = Object.fromEntries(dati.sprint[i - 1].assegnazioni.map((a) => [a.membro, a.ruolo]));
    for (const a of dati.sprint[i].assegnazioni) {
      if (a.ruolo && prima[a.membro] === a.ruolo) ripetuti.push(`${a.membro} (${ruolo(a.ruolo).nome}, ${dati.sprint[i].nome})`);
    }
  }
  out.push(ripetuti.length
    ? { classe: "warn", testo: "Stesso ruolo in sprint consecutivi", dettaglio: elenco(ripetuti) }
    : { classe: "ok", testo: "Nessun ruolo ripetuto in sprint consecutivi" });

  const sovrapposti = [];
  for (let i = 1; i < dati.sprint.length; i++) {
    if (dati.sprint[i].inizio <= dati.sprint[i - 1].fine) sovrapposti.push(`${dati.sprint[i - 1].nome} / ${dati.sprint[i].nome}`);
  }
  const oltreScadenza = dati.sprint.filter((s) => s.fine > p.scadenza).map((s) => s.nome);
  if (sovrapposti.length) out.push({ classe: "ko", testo: "Sprint sovrapposti", dettaglio: elenco(sovrapposti) });
  out.push(oltreScadenza.length
    ? { classe: "ko", testo: "Sprint oltre la consegna", dettaglio: elenco(oltreScadenza) }
    : { classe: "ok", testo: "Sprint entro la data di consegna" });

  const copertura = dati.membri.map((m) => dati.ruoli.filter((r) => c.matrice[m][r.id] > 0).length);
  const completi = copertura.filter((n) => n === dati.ruoli.length).length;
  out.push({
    classe: completi === dati.membri.length ? "ok" : "info",
    testo: "Ogni membro ricopre tutti i ruoli",
    dettaglio: `${completi} membri su ${dati.membri.length} hanno già ricoperto tutti i ruoli`,
  });
  return out;
}

function disegnaControlli(c) {
  $("controlli").innerHTML = controlliRegole(c).map((r) =>
    `<li>${stato(r.classe, r.testo)}${r.dettaglio ? `<span class="dettaglio">${esc(r.dettaglio)}</span>` : ""}</li>`).join("");
}

function disegnaSprint() {
  const pillole = $("pillole");
  const dettaglio = $("dettaglioSprint");
  pillole.innerHTML = "";
  $("modificaSprint").hidden = true;
  $("chiudiSprint").hidden = true;
  if (!dati.sprint.length) {
    dettaglio.innerHTML = `<div class="vuoto">Nessuno sprint registrato. Usa «+ Nuovo sprint» per aggiungere il primo.</div>`;
    return;
  }
  for (const sp of dati.sprint) {
    const b = document.createElement("button");
    b.type = "button";
    b.className = "pillola" + (sp.id === sprintSelezionato ? " attiva" : "");
    const st = statoSprint(sp);
    b.textContent = sp.nome + (st === "in corso" || st === "chiuso" ? ` · ${st}` : "");
    b.addEventListener("click", () => { sprintSelezionato = sp.id; disegnaSprint(); });
    pillole.appendChild(b);
  }
  const sp = dati.sprint.find((s) => s.id === sprintSelezionato) ?? dati.sprint.at(-1);
  sprintSelezionato = sp.id;
  $("modificaSprint").hidden = Boolean(sp.chiuso);
  $("chiudiSprint").hidden = Boolean(sp.chiuso);

  const st = statoSprint(sp);
  const durata = giorni(data(sp.inizio), data(sp.fine)) + 1;
  const rimanenti = st === "chiuso" ? `chiuso il ${dataIt(sp.dataChiusura)}` : st === "in corso" ? nGiorni(giorni(OGGI, data(sp.fine))) : st === "futuro" ? `inizia tra ${nGiorni(giorni(OGGI, data(sp.inizio)))}` : "concluso";
  const righe = dati.membri.map((mb) => {
    const a = sp.assegnazioni.find((x) => x.membro === mb);
    const r = a && ruolo(a.ruolo);
    return `<tr><td>${esc(mb)}</td>
      <td>${r ? `<span class="colore" style="background:${coloreRuolo(r.id)}; margin-right:6px"></span>${esc(r.nome)}` : stato("ko", "Nessun ruolo")}</td>
      <td class="num">${numero.format(Number(a?.ore) || 0)} h</td>
      <td class="num">${euro.format((Number(a?.ore) || 0) * (r?.costoOrario ?? 0))}</td></tr>`;
  }).join("");

  dettaglio.innerHTML = `
    <div class="fatti">
      <span><b>Periodo</b>${dataIt(sp.inizio)} – ${dataIt(sp.fine)}</span>
      <span><b>Durata</b>${durata} giorni (${numero.format(durata / 7)} settimane)</span>
      <span><b>Stato</b>${st === "chiuso" ? stato("ok", "Chiuso, non modificabile") : st}</span>
      <span><b>Tempo rimanente</b>${rimanenti}</span>
      <span><b>Ore</b>${numero.format(oreSprint(sp))} h</span>
      <span><b>Costo</b>${euro.format(costoSprint(sp))}</span>
    </div>
    <div class="collegamenti" style="margin: 0 0 12px">
      <a class="bottone" href="${esc(sp.link || dati.progetto.linkGithubProject)}" target="_blank" rel="noopener">Task dello sprint su GitHub</a>
    </div>
    <div class="dettaglio-sprint">
      <div class="tabella-wrap">
        <table>
          <thead><tr><th>Membro</th><th>Ruolo</th><th class="num">Ore</th><th class="num">Costo</th></tr></thead>
          <tbody>${righe}</tbody>
        </table>
        ${sp.note ? `<p class="nota"><b>Note:</b> ${esc(sp.note)}</p>` : ""}
      </div>
      <div>
        <div class="titolo-blocco" style="margin-top:0">Registro ore (${sp.registro.length})</div>
        ${registroHtml(sp)}
      </div>
    </div>`;
  for (const b of dettaglio.querySelectorAll("[data-rimuovi]")) {
    b.addEventListener("click", () => rimuoviLog(sp, Number(b.dataset.rimuovi)));
  }
}

function registroHtml(sp) {
  if (!sp.registro.length) return `<div class="vuoto">Nessuna registrazione${sp.chiuso ? "" : ". Usa «+ Registra ore»"}.</div>`;
  const voci = sp.registro.map((v, i) => ({ ...v, i })).sort((a, b) => b.data.localeCompare(a.data) || b.i - a.i);
  return `<div class="tabella-wrap registro-ore"><table>
    <thead><tr><th>Data</th><th>Membro</th><th>Ruolo</th><th class="num">Ore</th><th>Attività</th>${sp.chiuso ? "" : "<th></th>"}</tr></thead>
    <tbody>${voci.map((v) => `<tr>
      <td>${dataIt(v.data)}</td><td>${esc(v.membro)}</td><td>${esc(ruolo(v.ruolo)?.nome ?? v.ruolo)}</td>
      <td class="num">${numero.format(v.ore)} h</td><td class="attivita">${esc(v.nota)}</td>
      ${sp.chiuso ? "" : `<td><button type="button" class="pericolo piccolo" data-rimuovi="${v.i}" aria-label="Annulla registrazione">✕</button></td>`}
    </tr>`).join("")}</tbody>
  </table></div>`;
}

// Annulla una registrazione: toglie le ore dal totale del membro nello sprint
function rimuoviLog(sp, i) {
  const v = sp.registro[i];
  if (!v || sp.chiuso || !confirm(`Annullare ${numero.format(v.ore)} h di ${v.membro} del ${dataIt(v.data)}?`)) return;
  const a = sp.assegnazioni.find((x) => x.membro === v.membro);
  if (a) a.ore = Math.max(0, Math.round(((Number(a.ore) || 0) - v.ore) * 10) / 10);
  sp.registro.splice(i, 1);
  segnaModificato(true);
  disegna();
}

// ---------------------------------------------------------------------------
// Modifica sprint
// ---------------------------------------------------------------------------
const dialogSprint = $("dialogSprint");

function opzioniRuolo(selezionato) {
  return `<option value="">— nessuno —</option>` + dati.ruoli.map((r) =>
    `<option value="${r.id}" ${r.id === selezionato ? "selected" : ""}>${esc(r.nome)}</option>`).join("");
}

function apriSprint(sp) {
  if (sp?.chiuso) return;
  sprintInModifica = sp;
  const ultimo = dati.sprint.at(-1);
  const settimane = dati.progetto.durataSprintPredefinita || 2;
  let inizio, fine, assegnazioni;
  if (sp) {
    inizio = sp.inizio;
    fine = sp.fine;
    assegnazioni = sp.assegnazioni;
  } else {
    const d = ultimo ? aggiungiGiorni(data(ultimo.fine), 1) : OGGI;
    inizio = iso(d);
    fine = iso(aggiungiGiorni(d, settimane * 7 - 1));
    // Proposta di rotazione: ognuno passa al ruolo successivo rispetto allo sprint precedente
    assegnazioni = dati.membri.map((mb) => {
      const prec = ultimo?.assegnazioni.find((a) => a.membro === mb);
      const i = prec ? indiceRuolo(prec.ruolo) : -1;
      return { membro: mb, ruolo: i >= 0 ? dati.ruoli[(i + 1) % dati.ruoli.length].id : "", ore: 0 };
    });
  }
  $("titoloDialogSprint").textContent = sp ? `Modifica ${sp.nome}` : "Nuovo sprint";
  $("sNome").value = sp ? sp.nome : `Sprint ${dati.sprint.length + 1}`;
  $("sInizio").value = inizio;
  $("sFine").value = fine;
  aggiornaDurata();
  $("sAssegnazioni").innerHTML = dati.membri.map((mb, i) => {
    const a = assegnazioni.find((x) => x.membro === mb) || {};
    return `<tr><td>${esc(mb)}</td>
      <td><select data-ruolo="${i}">${opzioniRuolo(a.ruolo)}</select></td></tr>`;
  }).join("");
  $("sLink").value = sp?.link ?? "";
  $("sNote").value = sp?.note ?? "";
  $("sElimina").hidden = !sp;
  aggiornaBozza();
  dialogSprint.showModal();
}

function aggiornaDurata() {
  const i = data($("sInizio").value), f = data($("sFine").value);
  if (i && f && f >= i) $("sDurata").value = Math.round(((giorni(i, f) + 1) / 7) * 10) / 10;
}
function aggiornaFine() {
  const i = data($("sInizio").value), s = Number($("sDurata").value);
  if (i && s > 0) $("sFine").value = iso(aggiungiGiorni(i, Math.round(s * 7) - 1));
}

function leggiBozza() {
  return {
    id: sprintInModifica?.id ?? Math.max(0, ...dati.sprint.map((s) => s.id)) + 1,
    nome: $("sNome").value.trim(),
    inizio: $("sInizio").value,
    fine: $("sFine").value,
    // Le ore non si modificano qui: restano quelle accumulate con il registro ore
    assegnazioni: dati.membri.map((mb, i) => ({
      membro: mb,
      ruolo: document.querySelector(`[data-ruolo="${i}"]`).value,
      ore: Number(sprintInModifica?.assegnazioni.find((a) => a.membro === mb)?.ore) || 0,
    })),
    link: $("sLink").value.trim(),
    note: $("sNote").value.trim(),
  };
}

function validaSprint(b) {
  const errori = [];
  const avvisi = [];
  const altri = dati.sprint.filter((s) => s.id !== b.id);
  if (!b.nome) errori.push("Inserisci il nome dello sprint.");
  if (!b.inizio || !b.fine) errori.push("Inserisci le date di inizio e di fine.");
  else if (b.fine < b.inizio) errori.push("La data di fine è precedente a quella di inizio.");
  else {
    const sovr = altri.find((s) => b.inizio <= s.fine && s.inizio <= b.fine);
    if (sovr) errori.push(`Le date si sovrappongono a ${sovr.nome} (${dataIt(sovr.inizio)} – ${dataIt(sovr.fine)}).`);
    if (b.fine > dati.progetto.scadenza) avvisi.push(`Lo sprint termina dopo la consegna del ${dataIt(dati.progetto.scadenza)}.`);
  }
  const senza = b.assegnazioni.filter((a) => !a.ruolo).map((a) => a.membro);
  if (senza.length) errori.push(`Ogni membro deve avere un ruolo: manca per ${senza.join(", ")}.`);
  const resp = b.assegnazioni.filter((a) => a.ruolo === "responsabile").length;
  if (resp !== 1) errori.push(`Serve esattamente un responsabile (ora ${resp}).`);
  if (b.assegnazioni.some((a) => a.ore < 0)) errori.push("Le ore non possono essere negative.");

  // Effetto dello sprint sui totali del progetto
  const tutti = [...altri, b].sort((x, y) => x.inizio.localeCompare(y.inizio));
  const c = calcola(tutti);
  for (const r of dati.ruoli) {
    if (c.oreRuolo[r.id] > r.orePreviste) avvisi.push(`${r.nome}: ${numero.format(c.oreRuolo[r.id])} h su ${r.orePreviste} h previste.`);
  }
  for (const m of dati.membri) {
    if (c.oreMembro[m] > dati.progetto.orePerMembro) avvisi.push(`${m}: ${numero.format(c.oreMembro[m])} h su ${dati.progetto.orePerMembro} h.`);
  }
  if (c.costoTotale > dati.progetto.costoMassimo) avvisi.push(`Costo totale ${euro.format(c.costoTotale)} oltre il massimo di ${euro.format(dati.progetto.costoMassimo)}.`);
  const i = tutti.indexOf(b);
  if (i > 0) {
    const prec = tutti[i - 1];
    for (const a of b.assegnazioni) {
      const p = prec.assegnazioni.find((x) => x.membro === a.membro);
      if (a.ruolo && p?.ruolo === a.ruolo) avvisi.push(`${a.membro} ripete il ruolo di ${ruolo(a.ruolo).nome} di ${prec.nome}.`);
    }
  }
  return { errori, avvisi };
}

function aggiornaBozza() {
  const b = leggiBozza();
  const v = validaSprint(b);
  // Cambiare ruolo a chi ha già registrato ore sposta quelle ore sul nuovo ruolo
  for (const a of b.assegnazioni) {
    const prima = sprintInModifica?.assegnazioni.find((x) => x.membro === a.membro);
    if (prima && prima.ore > 0 && prima.ruolo !== a.ruolo && a.ruolo) {
      v.avvisi.push(`${a.membro} ha già ${numero.format(prima.ore)} h come ${ruolo(prima.ruolo)?.nome}: verranno conteggiate come ${ruolo(a.ruolo).nome}.`);
    }
  }
  $("sMessaggi").innerHTML = [...v.errori.map((t) => stato("ko", t)), ...v.avvisi.map((t) => stato("warn", t))].join("");
  return v;
}

$("formSprint").addEventListener("input", (e) => {
  if (e.target.id === "sInizio" || e.target.id === "sDurata") aggiornaFine();
  if (e.target.id === "sFine") aggiornaDurata();
  aggiornaBozza();
});
$("formSprint").addEventListener("submit", (e) => {
  e.preventDefault();
  if (aggiornaBozza().errori.length) return;
  const b = leggiBozza();
  b.registro = sprintInModifica?.registro ?? [];
  if (!b.link) delete b.link;
  if (!b.note) delete b.note;
  const i = dati.sprint.findIndex((s) => s.id === b.id);
  if (i >= 0) dati.sprint[i] = b; else dati.sprint.push(b);
  ordina(dati);
  sprintSelezionato = b.id;
  segnaModificato(true);
  dialogSprint.close();
  disegna();
});
$("sAnnulla").addEventListener("click", () => dialogSprint.close());
$("sElimina").addEventListener("click", () => {
  if (!sprintInModifica || sprintInModifica.chiuso || !confirm(`Eliminare ${sprintInModifica.nome}?`)) return;
  dati.sprint = dati.sprint.filter((s) => s.id !== sprintInModifica.id);
  sprintSelezionato = dati.sprint.at(-1)?.id ?? null;
  segnaModificato(true);
  dialogSprint.close();
  disegna();
});
$("nuovoSprint").addEventListener("click", () => dati && apriSprint(null));
$("modificaSprint").addEventListener("click", () => apriSprint(dati.sprint.find((s) => s.id === sprintSelezionato)));

// ---------------------------------------------------------------------------
// Registrazione ore
// ---------------------------------------------------------------------------
const dialogLog = $("dialogLog");

function leggiLog() {
  return {
    sp: dati.sprint.find((s) => String(s.id) === $("lSprint").value),
    membro: $("lMembro").value,
    data: $("lData").value,
    ore: Number($("lOre").value) || 0,
    nota: $("lNota").value.trim(),
  };
}

function aggiornaLog() {
  const l = leggiLog();
  const errori = [];
  const avvisi = [];
  let riepilogo = "";
  if (!l.sp) errori.push("Nessuno sprint aperto: crea uno sprint prima di registrare ore.");
  else {
    const a = l.sp.assegnazioni.find((x) => x.membro === l.membro);
    const r = a && ruolo(a.ruolo);
    if (!r) errori.push(`${l.membro} non ha un ruolo in ${l.sp.nome}: assegnalo con «Modifica sprint».`);
    else {
      const prima = Number(a.ore) || 0;
      riepilogo = `${r.nome} in ${l.sp.nome} · ${numero.format(prima)} → ${numero.format(prima + l.ore)} h · ${euro.format(l.ore * r.costoOrario)}`;
      const c = calcola();
      if (c.oreRuolo[r.id] + l.ore > r.orePreviste) avvisi.push(`${r.nome}: si arriva a ${numero.format(c.oreRuolo[r.id] + l.ore)} h su ${r.orePreviste} h previste.`);
      if (c.oreMembro[l.membro] + l.ore > dati.progetto.orePerMembro) avvisi.push(`${l.membro}: si arriva a ${numero.format(c.oreMembro[l.membro] + l.ore)} h su ${dati.progetto.orePerMembro} h.`);
    }
    if (l.data && (l.data < l.sp.inizio || l.data > l.sp.fine)) avvisi.push(`La data è fuori dal periodo di ${l.sp.nome} (${dataIt(l.sp.inizio)} – ${dataIt(l.sp.fine)}).`);
  }
  if (!l.data) errori.push("Inserisci la data.");
  if (l.ore <= 0) errori.push("Le ore devono essere maggiori di zero.");
  $("lRiepilogo").textContent = riepilogo;
  $("lMessaggi").innerHTML = [...errori.map((t) => stato("ko", t)), ...avvisi.map((t) => stato("warn", t))].join("");
  return errori;
}

$("registraOre").addEventListener("click", () => {
  if (!dati) return;
  const aperti = sprintAperti();
  const predefinito = sprintCorrente() ?? aperti.at(-1);
  $("lMembro").innerHTML = dati.membri.map((m) => `<option>${esc(m)}</option>`).join("");
  $("lSprint").innerHTML = aperti.map((s) =>
    `<option value="${s.id}" ${s === predefinito ? "selected" : ""}>${esc(s.nome)} (${dataIt(s.inizio)} – ${dataIt(s.fine)})</option>`).join("");
  $("lData").value = iso(OGGI);
  $("lOre").value = 1;
  $("lNota").value = "";
  aggiornaLog();
  dialogLog.showModal();
});
$("formLog").addEventListener("input", aggiornaLog);
$("lAnnulla").addEventListener("click", () => dialogLog.close());
$("formLog").addEventListener("submit", (e) => {
  e.preventDefault();
  if (aggiornaLog().length) return;
  const l = leggiLog();
  const a = l.sp.assegnazioni.find((x) => x.membro === l.membro);
  a.ore = Math.round(((Number(a.ore) || 0) + l.ore) * 10) / 10;
  const voce = { data: l.data, membro: l.membro, ruolo: a.ruolo, ore: l.ore };
  if (l.nota) voce.nota = l.nota;
  l.sp.registro.push(voce);
  sprintSelezionato = l.sp.id;
  segnaModificato(true);
  dialogLog.close();
  disegna();
});

// ---------------------------------------------------------------------------
// Chiusura sprint: dopo la chiusura lo sprint non è più modificabile
// ---------------------------------------------------------------------------
$("chiudiSprint").addEventListener("click", () => {
  const sp = dati.sprint.find((s) => s.id === sprintSelezionato);
  if (!sp || sp.chiuso) return;
  const { errori } = validaSprint(sp);
  if (errori.length) {
    alert(`${sp.nome} non può essere chiuso finché non sono corretti questi problemi:\n\n- ${errori.join("\n- ")}`);
    return;
  }
  const anticipo = OGGI < data(sp.fine) ? `\nAttenzione: lo sprint termina il ${dataIt(sp.fine)}, lo stai chiudendo in anticipo.` : "";
  if (!confirm(`Chiudere ${sp.nome}?${anticipo}\n\nDopo la chiusura non sarà più possibile modificarlo né registrare ore.`)) return;
  sp.chiuso = true;
  sp.dataChiusura = iso(OGGI);
  segnaModificato(true);
  disegna();
});

// ---------------------------------------------------------------------------
// Modifica milestone
// ---------------------------------------------------------------------------
const dialogMilestone = $("dialogMilestone");

function rigaMilestone(ms = {}) {
  const tr = document.createElement("tr");
  tr.innerHTML = `
    <td><input type="text" data-campo="nome" value="${esc(ms.nome)}"></td>
    <td><input type="date" data-campo="data" value="${esc(ms.data)}"></td>
    <td><input type="text" data-campo="descrizione" value="${esc(ms.descrizione)}"></td>
    <td style="text-align:center"><input type="checkbox" data-campo="raggiunta" ${ms.raggiunta ? "checked" : ""} style="width:auto"></td>
    <td><button type="button" class="pericolo" aria-label="Rimuovi milestone">✕</button></td>`;
  tr.querySelector("button").addEventListener("click", () => tr.remove());
  return tr;
}
$("gestisciMilestone").addEventListener("click", () => {
  if (!dati) return;
  const corpo = $("mRighe");
  corpo.innerHTML = "";
  dati.milestone.forEach((ms) => corpo.appendChild(rigaMilestone(ms)));
  $("mMessaggi").innerHTML = "";
  dialogMilestone.showModal();
});
$("mAggiungi").addEventListener("click", () => $("mRighe").appendChild(rigaMilestone()));
$("mAnnulla").addEventListener("click", () => dialogMilestone.close());
$("formMilestone").addEventListener("submit", (e) => {
  e.preventDefault();
  const nuove = [...$("mRighe").rows].map((tr) => {
    const v = (c) => tr.querySelector(`[data-campo="${c}"]`);
    const ms = { nome: v("nome").value.trim(), data: v("data").value, descrizione: v("descrizione").value.trim() };
    if (v("raggiunta").checked) ms.raggiunta = true;
    return ms;
  });
  if (nuove.some((m) => !m.nome || !m.data)) {
    $("mMessaggi").innerHTML = stato("ko", "Ogni milestone deve avere nome e data.");
    return;
  }
  dati.milestone = nuove;
  ordina(dati);
  segnaModificato(true);
  dialogMilestone.close();
  disegna();
});

// ---------------------------------------------------------------------------
// Esportazione e apertura file
// ---------------------------------------------------------------------------
const dialogEsporta = $("dialogEsporta");
function esporta() {
  if (!dati) return;
  $("jsonEsportato").value = JSON.stringify(dati, null, 2) + "\n";
  $("copiato").textContent = "";
  dialogEsporta.showModal();
}
$("esporta").addEventListener("click", esporta);
$("esportaAvviso").addEventListener("click", esporta);
$("chiudiEsporta").addEventListener("click", () => dialogEsporta.close());
$("copiaJson").addEventListener("click", async () => {
  const area = $("jsonEsportato");
  try {
    await navigator.clipboard.writeText(area.value);
  } catch (e) {
    area.select();
    document.execCommand("copy");
  }
  $("copiato").textContent = "Copiato negli appunti";
});

$("apriFile").addEventListener("change", (e) => {
  const file = e.target.files[0];
  if (!file) return;
  if (modificato && !confirm("Le modifiche non esportate andranno perse. Continuare?")) return;
  const lettore = new FileReader();
  lettore.onload = () => {
    try {
      imposta(JSON.parse(lettore.result), `file locale ${file.name}`);
    } catch (err) {
      alert("Il file selezionato non è un JSON valido.");
    }
  };
  lettore.readAsText(file);
  e.target.value = "";
});

window.addEventListener("beforeunload", (e) => {
  if (modificato) e.preventDefault();
});

caricaDati();
