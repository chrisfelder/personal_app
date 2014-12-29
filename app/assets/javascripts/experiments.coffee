# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on "ready page:change", ->
    $('.board-space').click ->
        $('.current-piece').remove()
        currentId = $(this).attr("id")
        $(this).append('<div class="current-piece"> </div>')
        $('#hidden').val(currentId)
        

        
