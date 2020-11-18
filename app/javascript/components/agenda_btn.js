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

// const initAgendaColl = () => {
//   const coll = document.getElementsByClassName("collapsible");
//   const i;

//   coll.addEventListener("click", (event) {
//       this.classList.toggle("active");
//       const content = this.nextElementSibling;
//       if (content.style.display === "block") {
//         content.style.display = "none";
//       } else {
//         content.style.display = "block";
//       }
//     });
// };

export { initAgendaBtn };
// export { initAgendaColl };
