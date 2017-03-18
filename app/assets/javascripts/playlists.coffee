# May have missed the mark a bit with the module pattern but
# this should be ok for now
$ ->

  ### BEGIN YOUTUBE API ###
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
  ### END YOUTUBE API ###



  window.PlayerController = {}
  (->
    # Player Vars
    playlist = $('#playlist-data').data 'playlist'
    trackIndex = 0
    trackUpdated = true
    songPlaying = false
    currentPlayer = null

    # Helper functions
    updatePlayer = ->
      return if playlist[trackIndex].site_id == 1 then soundcloudPlayer else youtubePlayer


    # Soundcloud Player
    soundcloudPlayer = (->
      # Init soundcloud widget.
      # TODO: In future load playlist of songs at initialization if possible
      soundcloudWidget = SC.Widget('soundcloud-player')

      start: ->
        soundcloudWidget.load playlist[trackIndex].url, auto_play: true

      resume: ->
        soundcloudWidget.play()

      pause: ->
        soundcloudWidget.pause()
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

      start: ->
        youtubeWidget.loadVideoById playlist[trackIndex].url.substr(track.url.lastIndexOf('/') + 1)

      resume: ->

      pause: ->

    )()

    # Main public player
    PlayerController.mainPlayer = (->

      currentPlayer = updatePlayer

      play: ->
        songPlaying = true
        updatePlayer()
        if trackUpdated
          currentPlayer.start()
          trackUpdated = false
        else
          currentPlayer.resume()

      pause: ->
        songPlaying = false
        currentPlayer.pause()

      next: ->
        trackUpdated = true
        trackIndex = if trackIndex == playlist.length - 1 then 0 else trackIndex + 1
        currentPlayer.pause()
        PlayerController.mainPlayer.play() if songPlaying

      previous: ->
        trackUpdated = true
        trackIndex = if trackIndex == 0 then playlist.length - 1 else trackIndex - 1
        currentPlayer.pause()
        PlayerController.mainPlayer.play() if songPlaying

      # If a user wants a certain track to be played
      playTrack: (index) ->
        trackUpdated = true
        trackIndex = index
        PlayerController.mainPlayer.play()


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


  # User presses play (Will 'start' or 'resume')
  #   - If there is a paused song in one of the players should play
  #   - If no song has been played yet, the proper player should be loaded
  #       and song played
  #   - If a player has been paused and the song has changed after being paused
  #       the new song should be loaded into the proper player and song played
  #
  # User presses next
  #   - If there is no song playing, load the next song into the player and await
  #       the user to press play
  #   - If there is a song playing, load the next song into the player and
  #       immediately begin playing said song
  #
  # User press previous
  #   - Same as next, essentially.
  #
  # User presses stop
  #   - If there is a song playing it should be paused
