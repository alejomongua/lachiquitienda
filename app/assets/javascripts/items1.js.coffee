# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('.edit_item').bind 'ajax:success', (event, data, status, xhr) ->
    $.pnotify({
      text: "Cantidad modificada",
      type: "success",
      delay: 3500
    })
    $('#precio-'+data.id).text (data.cantidad * data.precio).formatMoney(0,'.',',')
  .bind 'ajax:before', ->
    $.pnotify({
      text: "Modificando cantidad...",
      delay: 1000
    })
  .bind 'ajax:failure', (event, data, status, xhr) ->
    $.pnotify({
      text: "Error modificando cantidad",
      type: "error",
      delay: 3500
    })
  $('.eliminar-item').bind 'ajax:success', (event, data, status, xhr) ->
    $.pnotify({
      text: "Item eliminado del carrito",
      type: "success",
      delay: 3500
    })
    $(this).closest('tr').remove()
  .bind 'ajax:failure', (event, data, status, xhr) ->
    $.pnotify({
      text: "Error eliminando item del carrito",
      type: "error",
      delay: 3500
    })