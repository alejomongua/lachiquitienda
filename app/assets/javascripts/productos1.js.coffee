# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('.chzn-select').chosen({no_results_text: "No se encontraron resultados para"})

  $('#producto_categoria_id').change ->
    $('#campos-categoria').text('Cargando...')
    $.ajax({
      url: '/categorias/' + $('#producto_categoria_id').val() + '/campos.json',
      type: 'POST',
      success: (data) ->
        $('#campos-categoria').text('')
        for i in data
          $('#campos-categoria').append(Mustache.to_html($('#plantilla-' + i.tipo_campo).html(), i))
    })

  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()

  $('.eliminar-foto').bind "ajax:success", (evt, data, status, xhr) ->
    $('#foto-id-' + $(this).attr("data-id")).remove()
  $('.eliminar-foto').bind "ajax:error", (evt, data, status, xhr) ->
    console.log $(this).attr("data-id")
    console.log evt
    console.log "error"

  # colorbox
  $(".foto").colorbox({rel:'foto'});

  $('.add-to-cart').bind 'ajax:success', (event, data, status, xhr) ->
    $.colorbox({
      html: data
      onComplete: ->
        $('#new_item').bind 'ajax:success', (event, data, status, xhr) ->
          $.pnotify({
            text: "Item agregado al carrito",
            type: "success",
            delay: 3500
          })
        $('#new_item').bind 'ajax:before', ->
          $.fn.colorbox.close()
          $.pnotify({
            text: "Agregando al carrito...",
            delay: 1000
          })
        $('#new_item').bind 'ajax:failure', (event, data, status, xhr) ->
          $.pnotify({
            text: "Error agregado al carrito",
            type: "error",
            delay: 3500
          })
    })
    
  