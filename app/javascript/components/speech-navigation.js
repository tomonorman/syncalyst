const initNav = () => {
  console.log("Hello From Speech Recognition")
  var speechRecognition = window.webkitSpeechRecognition;
  let recognition = new speechRecognition();
  let activity = $("#activity");
  let content = '';
  let recognizing = false;

  recognition.continuous = true;
  recognition.start();

  recognition.onstart = function() {
    activity.text("Voice Recognition on, click to turn off");
    recognizing = true;
  }

  recognition.onspeechend = function() {
    activity.text("Voice Recognition is off");
    recognizing = false;
  }

  recognition.onerror = function() {
    activity.text("Voice Recognition Off, click to turn on");
    recognizing = false;
  }
   const taskhidden = document.querySelector('#taskhidden');
   if (taskhidden) {
    recognition.stop();
    console.log("stopped");
    }

  const running = document.querySelector("#activity");
  running.addEventListener('click', (event) => {
    if (recognizing == true) {
      recognition.abort();
    } else if (recognizing == false) {
      recognition.start();
    }
  });

  recognition.onresult = function (event) {
    var  current = event.resultIndex;
    var transcript = event.results[current][0].transcript;
    console.log(transcript);
    if (transcript.includes("next meeting")) {
      const start = document.querySelector("#next");
      start.click();
    }
    else if (transcript.includes("start meeting")) {
      const startAgenda = document.querySelector("#start-agenda");
      startAgenda.click();
    }
    else if (transcript.includes("first on the agenda")) {
      const item = document.querySelector("#agenda0");
      item.click();
    }
    else if (transcript.includes("thank you everyone")) {
      const spin = document.querySelector("#spin");
      spin.classList.add("spin");
    }
    else if (transcript.includes("next on the agenda")){
      const active = document.querySelector(".active")
      active.nextElementSibling.click();
    }
  }
}

export { initNav }
