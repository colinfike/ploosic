# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# This module pattern is some pretty clean stuff
$ ->

  # YouTube API Loading
  tag = document.createElement('script')
  tag.src = 'https://www.youtube.com/iframe_api'
  firstScriptTag = document.getElementsByTagName('script')[0]
  firstScriptTag.parentNode.insertBefore tag, firstScriptTag

  player = undefined

  window.onYouTubeIframeAPIReady = ->
    PlayerController.mainPlayer.initYoutube()
    console.log 'onYouTubeIframeAPIReady'

  window.onPlayerReady = (event) ->
    event.target.playVideo
    console.log 'onPlayerReady'

  window.onPlayerStateChange = (event) ->
    console.log 'onPlayerStateChange'


  window.PlayerController = {}

  (->
    playlist = $('#playlist-data').data 'playlist'
    currentTrack = 0
    currentPlayer = ''

    # Soundcloud Player
    soundcloudPlayer = (->
      # Init soundcloud widget.
      # TODO: In future load playlist of songs at initialization if possible
      soundcloudWidget = SC.Widget('soundcloud-player')

      playSong: (track) ->
        soundcloudWidget.load track.url, auto_play: true

      stop: ->
        soundcloudWidget.pause()

      testInit: ->
        console.log soundcloudWidget
    )()

    # YouTube Player
    youtubePlayer = (->
      youtubeWidget = undefined

      setWidget: ->
        youtubeWidget = new (YT.Player)('youtube-player',
          height: '200'
          width: '200'
          videoId: ''
          events:
            'onReady': onPlayerReady
            'onStateChange': onPlayerStateChange
        )
        return

      playSong: (track) ->
        youtubeWidget.loadVideoById track.url.substr(track.url.lastIndexOf('/') + 1)

      testInit: ->
        console.log youtubeWidget
    )()

    # Main public player
    PlayerController.mainPlayer = (->
      currentPlayer: ->
        currentPlayer

      play: ->
        track = playlist[currentTrack]
        currentPlayer = if track.site_id == 1 then soundcloudPlayer else youtubePlayer
        currentPlayer.playSong track

      stop: ->
        currentPlayer.stop()

      # More for testing purposes
      printPlaylist: ->
        console.log playlist
        console.log currentPlayer

      printPlayers: ->
        console.log youtubePlayer
        console.log youtubePlayer.testInit()
        console.log soundcloudPlayer
        console.log soundcloudPlayer.testInit()

      initYoutube: ->
        youtubePlayer.setWidget()
    )()
  )()
