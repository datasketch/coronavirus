const collapsibles = Array.from(document.querySelectorAll('.collapsible'));

collapsibles.forEach(function(collapsible) {
  const trigger = collapsible.querySelector('.collapsible-trigger');
  trigger.addEventListener('click', function() {
    collapsible.classList.toggle('opened');
  });
});
