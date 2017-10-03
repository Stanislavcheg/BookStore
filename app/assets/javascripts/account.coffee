$(document).on('turbolinks:load',
  () ->

    enable_button = (button_selector) ->
      $(button_selector).removeClass("disabled")
      $(button_selector).addClass("btn-default")

    disable_button = (button_selector) ->
      $(button_selector).addClass("disabled")
      $(button_selector).removeClass("btn-default")


    $('#remove-acc-checkbox').on('change',
      ()->
        if this.checked
          enable_button '#remove-acc-button'
        else
          disable_button '#remove-acc-button'
    )

    $('.pass-form-cont').on('change'
      ()->
        if $('#confirmPassword').val() and $('#password').val() and $('#oldPassword').val()
          enable_button '#save-pass-btn'
        else
          disable_button '#save-pass-btn'
    )
)
