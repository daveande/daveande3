msgDiv = '.js-message#content-magnet-modal'

clearMsgDiv = () ->
  setTimeout (->
    $(msgDiv).removeClass('alert alert-success alert-danger').html ''
    return
  ), 3000
  return

contentMagShowError = (msg) ->
  $(msgDiv).addClass("alert alert-danger").html(msg)
  clearMsgDiv()
  return

$(document).on 'submit', '#js-contentMagSubscribeForm', (e) ->
  e.preventDefault()
  $('#js-contentMagSubmit').prop("disabled",true)
  $email = $('#js-contentMagEmail')
  $name = $('#js-contentMagName')
  
  if $email.val() == '' && $name.val() == ''
    $('#js-contentMagSubmit').prop("disabled",false)
    contentMagShowError("You must include your name and email.")
  else
    $.ajax
      method: "POST"
      url: $(e.target).attr('action')
      data: $(e.target).serialize()
      dataType: "script"
      complete: (data, textStatus, jqXHR) ->
        $('#js-contentMagSubmit').prop("disabled",false)
        rsp = JSON.parse(data.responseText)
        if data.status == 200
          $(msgDiv).addClass("alert alert-success").html("Thank you! The bonus content should be in your inbox shortly!")
          clearMsgDiv()
        else
          contentMagShowError(rsp.body.errors[0].message)


      
