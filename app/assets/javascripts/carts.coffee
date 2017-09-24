# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on('turbolinks:load',
  () ->

    $("button.close").on("click", 
      ()->
        $.ajax({
          type: "DELETE",
          url: "/positions/#{this.id.split('_')[1]}"
        })
    )

    $(".pos-quantity").on("click",
      ()->
        quantity = $(this).parent().find(".quantity-input")[0]
        $.ajax({
          type: "PATCH",
          url: "/positions/#{quantity.id.split('_')[1]}",
          data: {position: {quantity: (parseInt($(quantity).val()) + 1)}}
        })
    )

    $(".quantity-input").on('change',
      ()->
        quantity = $(this)[0]
        $.ajax({
          type: "PATCH",
          url: "/positions/#{quantity.id.split('_')[1]}",
          data: {position: {quantity: $(quantity).val()}}
        })
    )

    $(".neg-quantity").on("click",
      ()->
        quantity = $(this).parent().find(".quantity-input")[0]
        $.ajax({
          type: "PATCH",
          url: "/positions/#{quantity.id.split('_')[1]}",
          data: {position: {quantity: (parseInt($(quantity).val()) - 1)}}
        })
    )

    $('#update_cart_text').on('change', 
      ()->
        if $(this).val()
          $('#update_cart_btn').removeClass("disabled")
          $('#update_cart_btn').addClass("btn-primary")
        else
          $('#update_cart_btn').addClass("disabled")
          $('#update_cart_btn').removeClass("btn-primary")
          
    )
)
