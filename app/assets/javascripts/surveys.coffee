# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  newheight = $('.title-block').height() + $('.content-block').height() + 16
  currentheight = parseInt($('.dash-container').css('min-height'))
  console.log(newheight + " " + currentheight)
  if newheight > currentheight
    $('.dash-container').css("min-height", newheight)


$(document).ready(ready)
$(document).on('page:load', ready)
$('a[data-toggle="tab"]').on('shown.bs.tab', ready)