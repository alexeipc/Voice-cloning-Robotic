(async () => {
  const display_sentence = document.querySelector('#display-sentence')

  const sentences = document.querySelectorAll('.sentence')
  const buttons = document.querySelectorAll('.record-button')
  const results = document.querySelectorAll('.recorded-audio')
  const statuses = document.querySelectorAll('.status')
  const submit_button = document.querySelector('#submit')
  const submit_file = document.querySelector('#voice')

  const segments = new Array(sentences.length)

  const STATUS_TYPES = {
    NOT_RECORDED: 'not recorded',
    RECORDING: 'recording',
    RECORDED: 'recorded'
  }

  const not_record_message = display_sentence.textContent

  const media_stream = await navigator.mediaDevices.getUserMedia({ audio: true })

  const recorder = new MediaRecorder(media_stream)

  let data = []
  let recording_index

  function check_finish() {
    for (const s of statuses) {
      if (s.textContent != STATUS_TYPES.RECORDED) {
        return
      }
    }

    submit_button.disabled = false

    const final_data = []
    for (const i of segments) {
      for (const j of i) {
        final_data.push(j)
      }
    }

    const audio_blob = new Blob(final_data, { type: 'audio/wav' })

    const audio_file = new File([audio_blob], 'voice.wav', {
      type: 'audio/wav',
      lastModified: Date.now()
    })

    const transfer = new DataTransfer()
    transfer.items.add(audio_file)

    submit_file.files = transfer.files
  }

  recorder.addEventListener('dataavailable', e => data.push(e.data))
  recorder.addEventListener('stop', () => {
    const audio_data = new Blob(data, { type: 'audio/wav' })
    const audio_src = URL.createObjectURL(audio_data)
    const audio_elem = document.createElement('audio')
    audio_elem.src = audio_src
    audio_elem.controls = true
    results[recording_index].appendChild(audio_elem)
    segments[recording_index] = data

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
          recording_index = sentence.getAttribute('data-index')
          recorder.start()
          break
        }
        case STATUS_TYPES.RECORDING: {
          display_sentence.textContent = not_record_message
          for (const b of buttons) b.disabled = false
          status.textContent = STATUS_TYPES.RECORDED
          button.textContent = 'Discard'

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
