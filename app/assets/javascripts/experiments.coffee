# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).on "ready page:change", ->
    $('.board-space').click ->
        $('.player-piece').remove()
        $(this).append('<div class="player-piece"> </div>')
        #$(this).toggleClass('select-space')
        #$(this).addClass('default-space').addClass('select-space')
        #$(this).addClass('select-space')