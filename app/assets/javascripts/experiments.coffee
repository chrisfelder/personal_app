# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on "ready page:change", ->
    $('.valid-space').click ->
        $('.current-piece').remove()
        currentId = $(this).attr("id")
        $(this).append('<div class="current-piece"> </div>')
        $('#hidden').val(currentId)
        
$(document).on "ready page:change", ->        
    $(".valid-space").on "mouseenter", ->
        $(this).addClass("highlight-space")
    $(".valid-space").on "mouseleave", ->
        $(this).removeClass("highlight-space")
        

        

        
