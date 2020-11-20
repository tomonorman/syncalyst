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
  }, 5000);
  n++;
};

let n = -1;
let i = 0;
const txt = ["Hi Jess. This will follow you while you are talking and this should be on the first agenda", "This will appear on the second agenda", "This will appear on the third agenda", "this will appear on the 4th agenda"];
const speed = 100;

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
