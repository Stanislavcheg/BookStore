$(document).on('turbolinks:load',
  () ->

    $("button.close").on("click",
      ()->
        id = $(this).data("position")
        $.ajax({
          type: "DELETE",
          url: "/positions/#{id}"
        })
    )

    $(".pos-quantity").on("click",
      ()->
        quantity_input = $(this).parent().find(".quantity-input")
        id = quantity_input.data("position")
        $.ajax({
          type: "PATCH",
          url: "/positions/#{id}",
          data: {position: {quantity: (parseInt(quantity_input.val()) + 1)}}
        })
    )

    $(".quantity-input").on('change',
      ()->
        quantity = $(this).val()
        id = $(this).data("position")
        $.ajax({
          type: "PATCH",
          url: "/positions/#{id}",
          data: {position: {quantity: quantity}}
        })
    )

    $(".neg-quantity").on("click",
      ()->
        quantity_input = $(this).parent().find(".quantity-input")
        id = quantity_input.data("position")
        $.ajax({
          type: "PATCH",
          url: "/positions/#{id}",
          data: {position: {quantity: (parseInt(quantity_input.val()) - 1)}}
        })
    )

    $('#update_cart_text').on('change',
      ()->
        $('#update_cart_btn').toggleClass("disabled")
        $('#update_cart_btn').toggleClass("btn-primary")
    )
)
