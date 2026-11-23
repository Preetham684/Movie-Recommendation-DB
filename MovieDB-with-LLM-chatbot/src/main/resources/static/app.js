const chat = document.getElementById('chat');
const form = document.getElementById('form');
const input = document.getElementById('input');
const send = document.getElementById('send');
const showSteps = document.getElementById('showSteps');

function esc(s) {
  return String(s).replace(/[&<>"']/g, c => ({'&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;'}[c]));
}

// Very small markdown: **bold**, bullet lists, line breaks
function md(text) {
  const lines = esc(text).split('\n');
  let html = '', inList = false;
  for (const raw of lines) {
    const line = raw.replace(/\*\*(.+?)\*\*/g, '<b>$1</b>');
    const m = line.match(/^\s*(?:[-*•]|\d+\.)\s+(.*)$/);
    if (m) { if (!inList) { html += '<ul>'; inList = true; } html += '<li>' + m[1] + '</li>'; continue; }
    if (inList) { html += '</ul>'; inList = false; }
    html += line + '\n';
  }
  if (inList) html += '</ul>';
  return html.trim();
}

function pretty(jsonText) {
  try { return JSON.stringify(JSON.parse(jsonText), null, 2); } catch { return jsonText; }
}

function addMessage(role, html, extraClass = '') {
  const div = document.createElement('div');
  div.className = `msg ${role} ${extraClass}`;
  div.innerHTML = html;
  chat.appendChild(div);
  chat.scrollTop = chat.scrollHeight;
  return div;
}

function renderSteps(steps) {
  if (!steps || !steps.length) return '';
  return '<div class="steps">' + steps.map((s, i) => {
    let rows = '';
    try { const r = JSON.parse(s.result); rows = Array.isArray(r) ? ` → ${r.length} row(s)` : (r.error ? ' → no match' : ' → 1 result'); } catch {}
    return `<details class="step">
      <summary>Step ${i + 1}: ${esc(s.tool)}(${esc(JSON.stringify(s.args))})${rows} · ${s.millis} ms</summary>
      <div class="body">
        <div class="label">SQL executed</div><pre>${esc(s.sql.join('\n\n'))}</pre>
        <div class="label">Result returned to the LLM</div><pre>${esc(pretty(s.result))}</pre>
      </div></details>`;
  }).join('') + '</div>';
}

async function ask(text) {
  if (!text.trim()) return;
  document.querySelector('.examples')?.remove();
  addMessage('user', `<div class="bubble">${esc(text)}</div>`);
  input.value = '';
  send.disabled = true;
  const typing = addMessage('bot', '<div class="bubble">Thinking… (the LLM is choosing a tool)</div>', 'typing');
  try {
    const res = await fetch('/api/chat', {
      method: 'POST', headers: {'Content-Type': 'application/json'}, body: JSON.stringify({message: text})
    });
    const data = await res.json();
    typing.remove();
    if (!res.ok) {
      addMessage('bot', `<div class="bubble">⚠️ ${esc(data.error || res.statusText)}</div>`, 'error');
    } else {
      addMessage('bot', renderSteps(data.steps) + `<div class="bubble">${md(data.answer || '(no answer)')}</div>`
        + `<div class="time">${(data.millis / 1000).toFixed(1)}s · ${data.steps.length} tool call(s)</div>`);
    }
  } catch (e) {
    typing.remove();
    addMessage('bot', `<div class="bubble">⚠️ Could not reach the server: ${esc(e.message)}</div>`, 'error');
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
