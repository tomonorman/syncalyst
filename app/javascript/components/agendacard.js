import { recordAudio } from './record_audio.js';

const stop = document.querySelector('.stop');
const stopRecordingBtn = document.querySelector('.stopRecording');
const recordBtn = document.querySelector('.record');
const soundClips = document.querySelector('.sound-clips');
const agendaItems = document.querySelectorAll(".agenda-cards-inprogress");


const transcription = (index) => {
    const transcriptionItems = document.querySelectorAll(".transcription");
    transcriptionItems.forEach((transcription) => {
        transcription.classList.add("transcription-display");
        transcription.innerHTML = "";
    });
    const show = document.querySelector("#show-btn");
    show.addEventListener('click', (event) => {
        transcriptionItems[index].classList.toggle("transcription-display");
    });
    transcriptionItems[index].insertAdjacentHTML("beforeend", "<div class='form-group' id='content-form'><textarea class='form-control' id='textbox' rows='10'></textarea></div><div class='form-group'><button type='button' id='stop-btn' class='btn btn-primary btn-block'>Next Item</button><p id='instructions'>Press start to record</p></div>")
};

const initSpeech = (i) => {
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

    recognition.onresult = function(event) {
        var current = event.resultIndex;
        var transcript = event.results[current][0].transcript;
        content += transcript;
        textbox.val(content);
    }

    if (content.length) {
        content += '';
    }
    recognition.start();

    $("#stop-btn").click(function(event) {
        event.preventDefault();
        recognition.stop();
        console.log(content);
        // send content to rails:
        const contentForm = document.querySelector("#content-form")
        const agendaId = contentForm.parentElement.dataset.agenda
        $.ajax({
            url: `/agendas/${agendaId}`,
            data: { "transcription": content },
            type: "PATCH",
            success: function(data) {
                console.log(data);
            }
        });
        // reset content
        content = '';
        const item = document.querySelector(`#agenda${i}`);
        if (item === null) {
            const wrapUp = document.querySelector("#wrap-up");

        } else {
            item.click();
        }
    })

    textbox.on('input', function() {
        content = $(this).val();
    })
}

const initAgenda = () => {
    let i = 1;
    //calls audio recording function
    recordAudio();
    if (agendaItems) {
        agendaItems.forEach((item) => {

            item.addEventListener('click', (event) => {
                if (recordBtn.disabled === true) {
                    stopRecordingBtn.click();
                }
                recordBtn.click();

                event.preventDefault();
                const record = document.querySelector("#record");
                record.classList.remove("record-hidden");
                record.classList.add("blink");
                const activity = document.querySelector("#activity");
                activity.classList.add("record-hidden");
                agendaItems.forEach((card) => {
                    if (card.classList.contains("active")) {
                        card.classList.remove("active");
                    }
                });
                event.currentTarget.classList.add("active");
                const array = Array.from(agendaItems);
                const index = array.indexOf(event.currentTarget);
                transcription(index);
                initSpeech(i);
                const finish = document.querySelector(`#agenda${i}`)
                if (finish === null) {
                    const finishbtn = document.querySelector("#stop-btn");
                    finishbtn.innerText = "Move to Task Assignment";
                }
                i += 1;
            });
        });
    }
}

export { initAgenda }