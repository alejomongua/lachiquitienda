# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('.chzn-select').chosen({no_results_text: "No se encontraron resultados para"})

  $('#producto_categoria_id').change ->
    $('#campos-categoria').text('Cargando...')
    $.ajax({
      url: '/campos_categoria/' + $('#producto_categoria_id').val() + '.json',
      type: 'POST',
      success: (data) ->
        $('#campos-categoria').text('')
        for i in data
          console.log i
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
