$(document).on('turbolinks:load',
  () ->
    if $('#step_name').val()
      current_step = $('#step_name').val()
      li_step_elem = $("span:contains('#{current_step}')").parent()
      li_step_elem.addClass('active')
      li_step_elem.prevAll().addClass('done')

    copy_billing_address = () ->
      $('#addresses_shipping_address_first_name').val($('#addresses_billing_address_first_name').val())
      $('#addresses_shipping_address_last_name').val($('#addresses_billing_address_last_name').val())
      $('#addresses_shipping_address_address').val($('#addresses_billing_address_address').val())
      $('#addresses_shipping_address_city').val($('#addresses_billing_address_city').val())
      $('#addresses_shipping_address_zip').val($('#addresses_billing_address_zip').val())
      $('#addresses_shipping_address_country').val($('#addresses_billing_address_country').val())
      $('#addresses_shipping_address_phone').val($('#addresses_billing_address_phone').val())

    erase_shipping_address = () ->
      $('#addresses_shipping_address_first_name').val("")
      $('#addresses_shipping_address_last_name').val("")
      $('#addresses_shipping_address_address').val("")
      $('#addresses_shipping_address_city').val("")
      $('#addresses_shipping_address_zip').val("")
      $('#addresses_shipping_address_country').val("")
      $('#addresses_shipping_address_phone').val("")

    $('#copy_billing').on('change',
      ()->
        if $(this).prop('checked')
          copy_billing_address()
        else
          erase_shipping_address()
    )
)
