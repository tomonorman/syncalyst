const transcription = (index) => {
  const transcriptionItems = document.querySelectorAll(".transcription");
  transcriptionItems.forEach((transcription) => {
    transcription.classList.add("transcription-display");
    transcription.innerHTML = "";
  });
  transcriptionItems[index].classList.remove("transcription-display");
  transcriptionItems[index].insertAdjacentHTML("beforeend", "<div class='form-group' id='content-form'><textarea class='form-control' id='textbox' rows='10'></textarea></div><div class='form-group'><button type='button' id='stop-btn' class='btn btn-primary btn-block'>stop</button><p id='instructions'>Press start to record</p></div>")
};

const initSpeech = () => {
  var speechRecognition = window.webkitSpeechRecognition;
  let recognition = new speechRecognition();
  var textbox = $("#textbox");
  let instructions = $("#instructions");
  let content = '';

  recognition.continuous = true;

  recognition.onstart = function() {
    instructions.text("Voice Recognition is on");
  }

  recognition.onspeechend = function() {
    instructions.text("No Activity");
    console.log("finished")
  }

  recognition.onerror = function() {
    instructions.text("Try again");
  }

  recognition.onresult = function (event) {
    var  current = event.resultIndex;
    var transcript = event.results[current][0].transcript;
    content += transcript;
    textbox.val(content);
  }

   if(content.length) {
      content += '';
  }
  recognition.start();

  $("#stop-btn").click(function (event) {
    event.preventDefault();
    recognition.stop();
    console.log(content);
    // send content to rails:
    const contentForm = document.querySelector("#content-form")
    const agendaId = contentForm.parentElement.dataset.agenda
    $.ajax({
      url: `/agendas/${agendaId}`,
      data: {"transcription": content},
      type: "PATCH",
      success: function (data) {
        console.log(data);
      }
    });
    // reset content
    content = '';
  })

  textbox.on('input', function () {
    content = $(this).val();
  })
}


const initAgenda = () => {
  const agendaItems = document.querySelectorAll(".agenda-cards-inprogress");

  if (agendaItems) {
    agendaItems.forEach((item) => {
      item.addEventListener('click', (event) => {
        event.preventDefault();
        agendaItems.forEach((card) => {
          if (card.classList.contains("active")) {
            card.classList.remove("active");
          }
        });
        event.currentTarget.classList.add("active");
        const array = Array.from(agendaItems);
        const index = array.indexOf(event.currentTarget);
        transcription(index);
        initSpeech();
      });
    });
  }
}


export { initAgenda }
