var recordButton, stopButton, recorder;

const blobToFile = (theBlob, fileName) => {
      //A Blob() is almost a File() - it's just missing the two properties below which we will add
      theBlob.lastModifiedDate = new Date();
      theBlob.name = fileName;
      return theBlob;
}

const onRecordingReady = (item, e) => {
  // let audio = document.getElementById('audio');
  // audio.src = URL.createObjectURL(e.data);
  // console.log('data is ready!');
  // console.log(item);
  // console.log(e.data);
  const result = blobToFile(e.data,'audio.mp4');
  const form = item.querySelector('.edit_agenda');
  // console.log(form);
  const formData = new FormData(form);
    // console.log(formData);
    formData.set('agenda[audio]', result, 'helloworld.wav');

    var request = new XMLHttpRequest();
    request.open("PATCH", form.action);
    request.send(formData);

    request.onload = (res) => {
      console.log(res);
    };
}

const startRecording = (event) => {
  console.log(event.currentTarget)
  console.log('clicked start!');
  recordButton.disabled = true;
  stopButton.disabled = false;

  recorder.start();
}

const stopRecording = () => {
  console.log('clicked stop');
  recordButton.disabled = false;
  stopButton.disabled = true;
  // Stopping the recorder will eventually trigger the `dataavailable` event and we can complete the recording process
  recorder.stop();
}


const recordAudio = () => {
  navigator.mediaDevices.getUserMedia({
            audio: true
    })
      .then(function (stream) {
        const li = document.querySelectorAll('.agenda-cards-inprogress');
        li.forEach((item) => {
          // console.log(item);

          recordButton = item.querySelector('.record');
            stopButton = item.querySelector('.stop');

      // get audio stream from user's mic
        recordButton.disabled = false;
        recordButton.addEventListener('click', startRecording);
        stopButton.addEventListener('click', stopRecording);
        recorder = new MediaRecorder(stream);

        // listen to dataavailable, which gets triggered whenever we have
        // an audio blob available
        recorder.addEventListener('dataavailable', (event) => {
          console.log(item);
          onRecordingReady(item, event);
        });
      });



      })



  };



export { recordAudio }
