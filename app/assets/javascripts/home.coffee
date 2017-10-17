$(document).on('turbolinks:load',
  () ->
    $(".item").first().addClass("active")
)
