const recordAudio = () => {
    let i = 0;
    const record = document.querySelector('.record');
    const stop = document.querySelector('.stopRecording');
    const soundClips = document.querySelector('.sound-clips');
    //change this
    const currentAgendas = document.querySelectorAll('.postit');

    const blobToFile = (theBlob, fileName) => {
        theBlob.lastModifiedDate = new Date();
        theBlob.name = fileName;
        return theBlob;
    }

    if (navigator.mediaDevices.getUserMedia) {

        const constraints = { audio: true };
        let chunks = [];

        let onSuccess = function(stream) {
            //start new stream
            const mediaRecorder = new MediaRecorder(stream);

            if (record) {
                //when clicked on record
                record.onclick = function() {
                    mediaRecorder.start();
                    console.log("voice recording started");
                    stop.disabled = false;
                    record.disabled = true;
                }
                //when clicked on stop
                stop.onclick = function() {
                    mediaRecorder.stop();
                    console.log(mediaRecorder.state);
                    console.log("voice recorder stopped");
                    stop.disabled = true;
                    record.disabled = false;
                }
                //when rocording stops
                mediaRecorder.onstop = function(e) {

                    const blob = new Blob(chunks, { 'type': 'audio/ogg; codecs=opus' });
                    //turn blob into file
                    const result = blobToFile(blob, 'audio.mp4');
                    // console.log(result);
                    //gets current agenda with i
                    let agenda = currentAgendas[i]
                    if (agenda) {
                        let agendaId = agenda.dataset.agenda
                        let route = `/agendas/${agendaId}`;
                        //creates new form to send
                        let formHTML =
                            `
                      <form action='${route}' method="patch" class="audio-form">
                        <input type="file" name="audio">
                      </form>
                        `;
                        soundClips.insertAdjacentHTML('beforeend',
                            `
                      <form action='${route}' method="patch" class="audio-form" style="display: none">
                        <input type="file" name="audio">
                        <input type="submit">
                      </form>
                      `);

                        const audioForm = soundClips.querySelector('.audio-form');
                        console.log(audioForm);

                        var fd = new FormData(audioForm);
                        fd.append('audio', result);

                        var request = new XMLHttpRequest();
                        request.open("PATCH", audioForm.action);
                        request.send(fd);

                        request.onload = (res) => {
                            console.log(res);
                            soundClips.innerHTML = '';
                            audioForm.innerHTML = '';
                        };

                        i += 1;

                        chunks = [];
                    }
                }
            }
            mediaRecorder.ondataavailable = function(e) {
                chunks.push(e.data);
            }
        }
        let onError = function(err) {
            console.log('The following error occured: ' + err);
        }
        navigator.mediaDevices.getUserMedia(constraints).then(onSuccess, onError);
    } else {
        console.log('getUserMedia not supported on your browser!');
    }
}



export { recordAudio }
