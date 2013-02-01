# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery(document).ready ($) ->
  $('div#activar-modificar-password a').click ->
    $("div#modificar-password").show()
    $('div#activar-modificar-password').hide()
    return false