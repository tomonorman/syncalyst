const transcription = (index) => {
  const transcriptionItems = document.querySelectorAll(".transcription");
  transcriptionItems.forEach((transcription) => {
    transcription.classList.add("transcription-display");
  });
  transcriptionItems[index].classList.remove("transcription-display");
};

const initAgenda = () => {
  const agendaItems = document.querySelectorAll(".agenda-cards-inprogress");

  if (agendaItems) {
    agendaItems.forEach((item) => {
      item.addEventListener('click', (event) => {
        agendaItems.forEach((card) => {
          if (card.classList.contains("active")) {
            card.classList.remove("active");
          }
        });
        event.currentTarget.classList.add("active");
        const array = Array.from(agendaItems);
        const index = array.indexOf(event.currentTarget);
        transcription(index);
      });
    });
  }
}

export { initAgenda }
