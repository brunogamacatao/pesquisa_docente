#= require jquery_validation_engine
#= require jquery.maskedinput-1.2.2.min

$(document).ready ->
  $("form").validationEngine()
  if $(".alert")
    $(".alert").slideDown('fast')
    callback = -> $(".alert").slideUp()
    setTimeout callback, 5000