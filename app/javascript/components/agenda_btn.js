const initAgendaBtn = () => {
  const agendaForm = document.querySelector(".agenda-form");
  const addAgendaBtn = document.querySelector(".add-agenda-btn");
  const agendaInput = document.querySelector(".agenda-input");

  if (addAgendaBtn) {
    addAgendaBtn.addEventListener("click", event => {
        event.preventDefault();
        agendaInput.classList.toggle('active');
    });
  }
};


export { initAgendaBtn };
