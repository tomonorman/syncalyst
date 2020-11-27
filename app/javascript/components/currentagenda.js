const initCurrentAgenda = () => {
  const agendaItems = document.querySelectorAll(".postit");
  agendaItems.forEach((agenda) => {
    agenda.addEventListener('click', (event) => {
      // agenda.classList.add("is-active");
      const agendaHTML = event.currentTarget.innerHTML;
      const currentAgenda = document.querySelector("#currentpostit");
      //currentAgenda.innerHTML = `<p>Currently Discussing:<p>${agendaHTML}`;
    });
  });
}

export { initCurrentAgenda }
