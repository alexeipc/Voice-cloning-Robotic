(async () => {
  const display_sentence = document.querySelector('#display-sentence')

  const sentences = document.querySelectorAll('.sentence')
  const buttons = document.querySelectorAll('.record-button')
  const statuses = document.querySelectorAll('.status')
  const submit_button = document.querySelector('#submit')

  const STATUS_TYPES = {
    NOT_RECORDED: 'not recorded',
    RECORDING: 'recording',
    RECORDED: 'recorded'
  }

  const not_record_message = display_sentence.textContent

  const media_stream = await navigator.mediaDevices.getUserMedia({ audio: true })

  const recorder = new MediaRecorder(media_stream)

  let data = []
  let result

  function check_finish() {
    for (const s of statuses) {
      if (s.textContent != STATUS_TYPES.RECORDED) {
        submit_button.disabled = true
        break
      }
    }
  }

  recorder.addEventListener('dataavailable', e => data.push(e.data))
  recorder.addEventListener('stop', () => {
    const audio_data = new Blob(data, { type: 'audio/wav' })
    const audio_src = URL.createObjectURL(audio_data)
    const audio_elem = document.createElement('audio')
    audio_elem.src = audio_src
    audio_elem.controls = true
    result.appendChild(audio_elem)


    check_finish();
  })

  for (const sentence of sentences) {
    const button = sentence.querySelector('.record-button')
    const status = sentence.querySelector('.status')
    const result_audio = sentence.querySelector('.recorded-audio')
    button.addEventListener('click', () => {
      switch (status.textContent) {
        case STATUS_TYPES.NOT_RECORDED: {
          display_sentence.textContent = sentence.getAttribute('data-content')
          for (const b of buttons) b.disabled = true
          status.textContent = STATUS_TYPES.RECORDING
          button.disabled = false
          button.textContent = 'Stop recording'
          submit_button.disabled = true

          data = []
          result = sentence.querySelector('.recorded-audio')
          recorder.start()
          break
        }
        case STATUS_TYPES.RECORDING: {
          display_sentence.textContent = not_record_message
          for (const b of buttons) b.disabled = false
          status.textContent = STATUS_TYPES.RECORDED
          button.textContent = 'Discard'
          submit_button.disabled = false

          recorder.stop()
          break
        }
        case STATUS_TYPES.RECORDED: {
          display_sentence.textContent = not_record_message
          status.textContent = STATUS_TYPES.NOT_RECORDED
          button.textContent = 'Record'
          submit_button.disabled = true
          let child
          while (child = result_audio.lastChild) {
            result_audio.removeChild(child)
          }
          break
        }
      }
    })
  }
})()
