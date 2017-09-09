# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on('turbolinks:load',
  () ->
    showChar = 150  # How many characters are shown by default in the book description
    ellipsestext = "..."
    moretext = "Read more"
    lesstext = "Hide"
    quantity = $("#position_quantity")

    $('.more').each(
      () ->
        content = $(this).html()
        if content.length > showChar 
          c = content.substr(0, showChar)
          h = content.substr(showChar, content.length - showChar)
          html = c + '<span class="moreellipses">' + ellipsestext + '&nbsp;</span><span class="morecontent"><span>' + h + '</span>&nbsp;&nbsp;<a href="" class="morelink in-gold-500">' + moretext + '</a></span>'
          $(this).html(html)
    )

    $(".morelink").click(
      () ->
        if $(this).hasClass("less") 
          $(this).removeClass("less")
          $(this).html(moretext)
        else 
          $(this).addClass("less")
          $(this).html(lesstext)
          $(this).parent().prev().toggle()
          $(this).prev().toggle()
          return false
    )


    $("a.add_quantity").on("click", 
      ()->
        quantity.val(parseInt(quantity.val()) + 1)
    )

    $("a.reduce_quantity").on("click", 
      ()->
        if quantity.val() > 0
          quantity.val(parseInt(quantity.val()) - 1)
    )

)