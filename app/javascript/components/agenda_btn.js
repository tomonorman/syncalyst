const initAgendaBtn = () => {
const agendaForm = document.querySelector(".agenda-form");
const addAgendaBtn = document.querySelector(".add-agenda-btn");
const agendaInput = document.querySelector(".agenda-input");

addAgendaBtn.addEventListener("click", event => {
    event.preventDefault();
    agendaInput.classList.add('active');
    console.log('hello');
  });

};

export { initAgendaBtn };
