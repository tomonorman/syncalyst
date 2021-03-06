// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";
import { initNavbar } from '../components/navbar';
import { initAgendaForm } from '../components/init_agenda_form';
import { initAgenda } from '../components/agendacard';
import { authorizeTrello } from '../components/authorize_trello';
import { initTrelloCard } from '../components/init_trello_card';
import { initNav } from '../components/speech-navigation';
import { initCurrentAgenda } from '../components/currentagenda';

document.addEventListener('turbolinks:load', () => {
  initNav()
  initNavbar();
  initAgenda();
  initAgendaForm();
  authorizeTrello();
  initTrelloCard();
  initCurrentAgenda();
});

