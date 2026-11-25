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