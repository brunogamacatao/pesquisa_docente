#= require jquery.maskedinput-1.2.2.min
#= require jquery.ui.all
#= require jquery.validate
#= require jquery.wizard

$(document).ready ->
  if $(".alert")
    $(".alert").slideDown('fast')
    callback = -> $(".alert").slideUp()
    setTimeout callback, 5000

  $('.nao_conheco_btn').click (event)->
    event.preventDefault()
    $(this).parent().remove()
    return false
  
  $("#wizard").wizard(
    stepsWrapper: "#wrapped"
    submit: ".submit"
    beforeSelect: (event, state) ->
      inputs = $(this).wizard("state").step.find(":input")
      not inputs.length or !!inputs.valid()
  ).wizard("form").validate errorPlacement: (error, element) ->
    if element.is(":radio") or element.is(":checkbox")
      error.insertBefore element.parent()
    else
      error.insertAfter element