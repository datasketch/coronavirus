window.addEventListener('DOMContentLoaded', init);

const createCard = () => {
  const card = document.createElement('div');
  const cardHeader = document.createElement('div');
  const cardMedia = document.createElement('div');
  const cardBody = document.createElement('div');
  const cardActions = document.createElement('div');

  card.classList.add('card');
  cardHeader.classList.add('card-header');
  cardMedia.classList.add('card-media');
  cardBody.classList.add('card-body');
  cardActions.classList.add('card-actions');

  return { card, cardHeader, cardMedia, cardBody, cardActions };
};

const handleResponse = response => {
  if (!response.ok) {
    throw new Error('Lo sentimos, no hemos podido cargar los datos');
  }
  return response.json();
};

const handleError = err => {
  const app = document.getElementById('app');
  app.innerHTML = `<p class="text-center">${err.message}</p>`;
};

const populateDOM = data => {
  const { charts, datasets } = data;
  // add charts
  const chartsContainer = document.querySelector('.charts');
  charts.forEach(chart => {
    const { card, cardMedia, cardActions } = createCard();
    const iframe = document.createElement('iframe');
    const shareButton = document.createElement('button');

    card.appendChild(cardMedia);
    card.appendChild(cardActions);
    cardMedia.appendChild(iframe);
    cardActions.appendChild(shareButton);

    iframe.src = `./${chart.path}`;
    shareButton.textContent = 'Compartir';
    shareButton.classList.add('btn');

    shareButton.addEventListener('click', () => {
      navigator.share(
        {
          title: 'Datasketch · Coronavirus',
          text: chart.title,
          url: `${location.href}${chart.path}`
        },
        {
          print: false,
          sms: false,
          skype: false,
          language: 'es'
        }
      );
    });

    chartsContainer.appendChild(card);
  });

  // add datasets
  const datasetsContainer = document.querySelector('.datasets');
  datasets.forEach(dataset => {
    const { card, cardBody, cardActions } = createCard();
    const title = document.createElement('p');
    const description = document.createElement('p');
    const download = document.createElement('a');

    card.appendChild(cardBody);
    card.appendChild(cardActions);
    cardBody.appendChild(title);
    cardBody.appendChild(description);
    cardActions.appendChild(download);

    card.classList.add('dataset');
    title.textContent = dataset.title;
    title.classList.add('dataset-title');
    description.textContent = dataset.description;
    description.classList.add('dataset-description');
    download.textContent = 'Descargar';
    download.href = `${location.href}${dataset.path}`;
    download.classList.add('btn');

    datasetsContainer.appendChild(card);
  });
};

function init() {
  fetch(`${location.href}data.json`)
    .then(handleResponse)
    .then(populateDOM)
    .catch(handleError);
}
