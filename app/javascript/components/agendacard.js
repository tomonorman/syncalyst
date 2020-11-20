const transcription = (index) => {
  const transcriptionItems = document.querySelectorAll(".transcription");
  transcriptionItems.forEach((transcription) => {
    transcription.classList.add("transcription-display");
    transcription.classList.remove("typewriter");
  });
  transcriptionItems[index].classList.remove("transcription-display");
  transcriptionItems[index].classList.add("typewriter");
  setTimeout(function(){
    typeWriter()
  }, 3000);
  n++;
};

let n = -1;
let i = 0;
const txt = ["Jess: it should start recording and transcribing automatically. Last week I have made a new button on the agenda page. Let's go to the next item on the agenda", "Jess: But we have one problem. That its loading the page very slowly so we need to fix it.", "Jess: Let's talk about other new ideas. How about adding a search function? How about you Tomo?", "Tomo: We need to add more animations."];
const speed = 80;

const typeWriter = () => {
  if (i < txt[n].length) {
    document.querySelector(".typewriter").innerHTML += txt[n].charAt(i);
    i++;
    setTimeout(typeWriter, speed);
  }
}

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
        i = 0;
        transcription(index);
      });
    });
  }
}

export { initAgenda }
