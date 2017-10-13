$(document).on('turbolinks:load',
  () ->
    show_char = 150  # How many characters are shown by default in the book description
    ellipses_text = "..."
    more_text = I18n.t("book.description.read_more")
    less_text = I18n.t("book.description.hide")
    quantity = $("#position_quantity")

    $('.toggle-description').each(
      () ->
        content = $(this).find(".book-description").text()
        if content.length > show_char
          short_content = content.substr(0, show_char)
          remaining_content = content.substr(show_char, content.length - show_char)
          $(this).find('.book-description').text(short_content)
          $(this).find('.more-ellipses').text(ellipses_text)
          $(this).find('.more-content').text(remaining_content)
          $(this).find('.more-link').text(more_text)
    )

    $(".more-link").click(
      () ->
        if $(this).hasClass("less")
          $(this).html(more_text)
        else
          $(this).html(less_text)

        $(this).toggleClass("less")
        $(this).prev().toggle()
        $(this).prev().prev().toggle()
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
