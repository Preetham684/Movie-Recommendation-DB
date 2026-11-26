const chat = document.getElementById('chat');
const form = document.getElementById('form');
const input = document.getElementById('input');
const send = document.getElementById('send');
const showSteps = document.getElementById('showSteps');

const esc = s => String(s).replace(/[&<>"']/g, c => ({'&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;'}[c]));

// Small markdown: **bold**, bullet / numbered lists, line breaks
function md(text) {
  let html = '', inList = false;
  for (const raw of esc(text).split('\n')) {
    const line = raw.replace(/\*\*(.+?)\*\*/g, '<b>$1</b>');
    const m = line.match(/^\s*(?:[-*•]|\d+\.)\s+(.*)$/);
    if (m) { if (!inList) { html += '<ul>'; inList = true; } html += `<li>${m[1]}</li>`; continue; }
    if (inList) { html += '</ul>'; inList = false; }
    html += line + '\n';
  }
  if (inList) html += '</ul>';
  return html.trim();
}

const pretty = t => { try { return JSON.stringify(JSON.parse(t), null, 2); } catch { return t; } };

function rowsInfo(result) {
  try {
    const r = JSON.parse(result);
    if (Array.isArray(r)) return `${r.length} row${r.length === 1 ? '' : 's'}`;
    return r.error ? 'no match' : '1 result';
  } catch { return ''; }
}

function addMessage(role, inner, extra = '') {
  document.getElementById('welcome')?.remove();
  const div = document.createElement('div');
  div.className = `msg ${role} ${extra}`;
  div.innerHTML = `<div class="avatar">${role === 'user' ? 'You' : 'MB'}</div><div class="body">${inner}</div>`;
  chat.appendChild(div);
  chat.scrollTop = chat.scrollHeight;
  return div;
}

function renderSteps(steps) {
  if (!steps?.length) return '';
  const items = steps.map(s => `
    <div class="step">
      <div class="step-head">
        <span class="tool">${esc(s.tool)}</span>
        <span class="args">${esc(JSON.stringify(s.args))}</span>
        <span class="args">· ${rowsInfo(s.result)} · ${s.millis} ms</span>
      </div>
      <div class="label">SQL executed</div><pre>${esc(s.sql.join('\n\n'))}</pre>
      <div class="label">Result sent to the LLM</div><pre>${esc(pretty(s.result))}</pre>
    </div>`).join('');
  return `<details class="steps"><summary>Agent steps · ${steps.length} database ${steps.length === 1 ? 'query' : 'queries'}</summary>${items}</details>`;
}


// ---------- result cards (built from the tool results the agent already fetched) ----------
const parse = t => { try { return JSON.parse(t); } catch { return null; } };

function ratingBadge(v, n) {
  const x = Number(v);
  if (v == null || Number.isNaN(x)) return '<span class="rate none">Not rated yet</span>';
  const tier = x >= 8 ? 'hi' : x >= 6.5 ? 'mid' : 'lo';
  return `<span class="rate ${tier}" title="Average user rating out of 10"><svg viewBox="0 0 24 24" aria-hidden="true"><path d="M12 3.5l2.6 5.4 5.9.8-4.3 4.1 1 5.9L12 17l-5.2 2.7 1-5.9L3.5 9.7l5.9-.8z"/></svg>`
    + `<b>${x.toFixed(1)}</b><small>/10${n != null ? ` · ${n} rating${Number(n) === 1 ? '' : 's'}` : ''}</small>`
    + `<span class="bar" role="img" aria-label="${x.toFixed(1)} out of 10"><i style="width:${Math.max(0, Math.min(100, x * 10))}%"></i></span></span>`;
}

function genreTags(g) {
  return g ? `<div class="tags">${String(g).split(',').map(x => `<span>${esc(x.trim())}</span>`).join('')}</div>` : '';
}

function movieCard(m) {
  const year = m.release_year ?? (m.release_date ? String(m.release_date).slice(0, 4) : '');
  const sub = [year, m.director].filter(Boolean).map(esc).join(' · ');
  return `<article class="mcard"><div class="mc-body">
    <h4>${esc(m.title)}</h4><div class="mc-sub">${sub}</div>${genreTags(m.genres)}
    <div class="mc-foot">${ratingBadge(m.avg_rating, m.num_ratings)}`
    + `</div></div></article>`;
}

function detailCard(m) {
  const year = m.release_date ? String(m.release_date).slice(0, 4) : '';
  const actors = m.actors ? String(m.actors).split(',').map(a => `<span>${esc(a.trim())}</span>`).join('') : '';
  return `<article class="dcard"><div class="dc-body">
    <h4>${esc(m.title)}${year ? ` <small>(${esc(year)})</small>` : ''}</h4>
    ${m.director ? `<div class="mc-sub">Directed by <b>${esc(m.director)}</b></div>` : ''}
    ${genreTags(m.genres)}
    <div class="mc-foot">${ratingBadge(m.avg_rating, m.num_ratings)}</div>
    ${actors ? `<div class="label">Cast</div><div class="tags cast">${actors}</div>` : ''}
  </div></article>`;
}

function renderCards(steps) {
  if (!steps?.length) return '';
  const list = [], seen = new Set(), details = [];
  for (const s of steps) {
    const r = parse(s.result);
    if (!r || r.error) continue;
    if (s.tool === 'get_movie_details' && !Array.isArray(r)) details.push(r);
    else if (Array.isArray(r)) for (const m of r) if (m.title && !seen.has(m.title)) { seen.add(m.title); list.push(m); }
  }
  let html = details.map(detailCard).join('');
  if (list.length) {
    const top = list.slice(0, 8);
    html += `<div class="mgrid">${top.map(movieCard).join('')}</div>`
      + (list.length > top.length ? `<div class="meta">Showing ${top.length} of ${list.length} matches</div>` : '');
  }
  return html ? `<div class="cards-out">${html}</div>` : '';
}

async function ask(text) {
  text = text.trim();
  if (!text) return;
  addMessage('user', `<div class="bubble">${esc(text)}</div>`);
  input.value = '';
  send.disabled = true;
  const typing = addMessage('bot', '<div class="bubble"><i></i><i></i><i></i></div>', 'typing');
  try {
    const res = await fetch('/api/chat', {
      method: 'POST', headers: {'Content-Type': 'application/json'}, body: JSON.stringify({message: text})
    });
    const data = await res.json();
    typing.remove();
    if (!res.ok) {
      addMessage('bot', `<div class="bubble">Something went wrong: ${esc(data.error || res.statusText)}</div>`, 'error');
    } else {
      addMessage('bot', renderSteps(data.steps)
        + `<div class="bubble">${md(data.answer || '(no answer)')}</div>`
        + renderCards(data.steps)
        + `<div class="meta">${(data.millis / 1000).toFixed(1)} s</div>`);
    }
  } catch (e) {
    typing.remove();
    addMessage('bot', `<div class="bubble">Could not reach the server: ${esc(e.message)}</div>`, 'error');
  } finally {
    send.disabled = false;
    input.focus();
  }
}

form.addEventListener('submit', e => { e.preventDefault(); ask(input.value); });
document.querySelectorAll('.ex').forEach(b => b.addEventListener('click', () => ask(b.textContent)));
showSteps.addEventListener('change', () => chat.classList.toggle('hide-steps', !showSteps.checked));
document.getElementById('reset').addEventListener('click', async () => {
  await fetch('/api/reset', {method: 'POST'});
  location.reload();
});

// Deep link from the homepage: /chat?q=Recommend a sci-fi movie
const initial = new URLSearchParams(location.search).get('q');
if (initial) { history.replaceState(null, '', '/chat'); ask(initial); }