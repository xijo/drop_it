$(document).ready ->

  jQuery.event.props.push("dataTransfer")

  forms = $('[data-fileupload]')

  dragenter = (event) ->
    event.stopPropagation()
    event.preventDefault()
    $(event.currentTarget).addClass('dragenter')

  dragover = (event) ->
    event.stopPropagation()
    event.preventDefault()

  drop = (event) ->
    form = $(event.currentTarget)
    upload(file, form) for file in event.dataTransfer.files
    form.removeClass('dragenter')
    event.stopPropagation()
    event.preventDefault()

  upload = (file, form) ->
    li = log.default("upload photo #{file.fileName}")

    data = new FormData()
    data.append('photo[data]', file)

    $.ajax({
      type: 'POST',
      url: form.attr('action'),
      data: data,
      cache: false,
      contentType: false,
      processData: false,
      success: (data, textStatus, jqXHR)->
        $('span', li).attr('class', 'label label-success').html('succ')
        $('ul', form).append(data)
      error: ->
        $('span', li).attr('class', 'label label-important').html('err')
    })

  forms.bind 'dragenter', dragenter
  forms.bind 'dragover', dragover
  forms.bind 'drop', drop


