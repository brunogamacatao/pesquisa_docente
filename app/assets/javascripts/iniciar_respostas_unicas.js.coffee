#= require forms

$(document).ready ->
  $('.nao_conheco_btn').click (event)->
    event.preventDefault()
    $(this).parent().remove()
    return false