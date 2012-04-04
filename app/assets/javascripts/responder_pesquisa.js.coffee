# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
  $("form").validationEngine()
  if $(".alert")
    $(".alert").slideDown('fast')
    callback = -> $(".alert").slideUp()
    setTimeout callback, 5000
  $("#matricula").mask("999999")
  $("#matricula").focus()