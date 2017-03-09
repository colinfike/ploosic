# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# This module pattern is some pretty clean stuff
$ ->
  window.PlayerController = {}

  PlayerController.playlist = (->
    # Read rails data to generate playlist
  )()
  
  PlayerController.soundcloudPlayer = (->
    # Init soundcloud widget
    soundcloudWidget = SC.Widget('soundcloud-player')

    test_init: ->
      console.log soundcloudWidget
  )()
