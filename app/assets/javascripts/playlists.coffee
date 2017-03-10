# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# This module pattern is some pretty clean stuff
$ ->

  window.PlayerController = {}

  (->
    playlist = $('#playlist-data').data 'playlist'
    currentTrack = 0
    currentPlayer = ''

    # Soundcloud Player
    soundcloudPlayer = (->
      # Init soundcloud widget
      soundcloudWidget = SC.Widget('soundcloud-player')

      playSong: (track) ->
        soundcloudWidget.load track.url, auto_play: true

      testInit: ->
        console.log soundcloudWidget
    )()

    # Main public player
    PlayerController.mainPlayer = (->
      currentPlayer: ->
        currentPlayer

      play: ->
        track = playlist[currentTrack]
        currentPlayer = if track.site_id == 1 then soundcloudPlayer else youtubePlayer
        currentPlayer.playSong track

      # More for testing purposes
      printPlaylist: ->
        console.log playlist
        console.log currentPlayer
    )()


  )()
