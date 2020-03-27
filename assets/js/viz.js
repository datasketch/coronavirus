const eval = window.location.search.match(/scope=(\w+)\&?/);
const scope = eval && eval.length ? eval[1] : '';

if (scope) {
  const cards = Array.from(document.querySelectorAll('.card'));

  cards.forEach(function(card) {
    if (card.dataset.scope !== scope) {
      card.classList.add('hidden');
    }
  });
}
