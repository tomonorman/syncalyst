const initNav = () => {

  window.onload = (event) => {
    console.log("Hello From Speech Recognition")
    recognition.start();
  }

  var speechRecognition = window.webkitSpeechRecognition;
  let recognition = new speechRecognition();
  // var textbox = $("#textbox");
  // let instructions = $("#instructions");
  let content = '';

  recognition.continuous = true;

  recognition.onstart = function() {
    console.log("Voice Recognition is on");
  }

  recognition.onspeechend = function() {
    console.log("Voice Recognition is off");
  }

  recognition.onerror = function() {
    console.log("Try again");
  }

  recognition.onresult = function (event) {
    var  current = event.resultIndex;
    var transcript = event.results[current][0].transcript;
    console.log(transcript);
    if (transcript.includes("next meeting")) {
      const start = document.querySelector("#next");
      start.click();
    }
    else if (transcript.includes("start")) {
      const startAgenda = document.querySelector("#start-agenda");
      startAgenda.click();
    }
    else if (transcript.includes("first")) {
      const item = document.querySelector("#agenda0");
      item.click();
    }
  }
}

export { initNav }
