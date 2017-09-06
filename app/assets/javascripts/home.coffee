# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on('turbolinks:load',
	() ->
		$(".item").first().addClass("active")

		$("button.buy").on("click",
      ()->
        $.ajax({
          type: "POST",
          url: "/positions",
          data: {position: {quantity: 1, book_id: this.id.split("_")[1]}}
        });
    )
)