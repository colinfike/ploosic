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
      console.log("update Site ID: " + playlist[trackIndex].site_id)
      currentPlayer = if playlist[trackIndex].site_id == 1 then soundcloudPlayer else youtubePlayer




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

      getYoutubeId = (url) ->
        if url.includes('youtu.be')
          url.substr(url.lastIndexOf('/') + 1)
        else
          url.substr(url.lastIndexOf('=') + 1)

      setWidget: ->
        youtubeWidget = new (YT.Player)('youtube-player',
          height: '0'
          width: '0'
          videoId: ''
          events:
            'onReady': onPlayerReady
            'onStateChange': onPlayerStateChange
        )
        return

      # Change to use URL
      start: ->
        youtubeWidget.loadVideoById getYoutubeId(playlist[trackIndex].url)
        # youtubeWidget.loadVideoById playlist[trackIndex].url.substr(playlist[trackIndex].url.lastIndexOf('/') + 1)

      resume: ->
        youtubeWidget.playVideo()

      pause: ->
        youtubeWidget.pauseVideo()
    )()

    # Main public player
    PlayerController.mainPlayer = (->

      updatePlayer()

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
        index = 0 if (index < 0 || index > 0)
        trackUpdated = true
        trackIndex = index
        currentPlayer.pause()
        PlayerController.mainPlayer.play()

      initYoutube: ->
        youtubePlayer.setWidget()

    )()
  )()

  # File is getting a bit large, probably should split it up a bit
  $('.player__play').click ->
    PlayerController.mainPlayer.play()
    togglePlayButton()
    return

  $('.player__pause').click ->
    PlayerController.mainPlayer.pause()
    togglePlayButton()
    return

  $('.player__next').click ->
    PlayerController.mainPlayer.next()
    return

  $('.player__previous').click ->
    PlayerController.mainPlayer.previous()
    return

  togglePlayButton = ->
    if $('.player__play').css('display') != 'none'
      $('.player__play').css('display', 'none');
      $('.player__pause').css('display', 'inline-block');
    else
      $('.player__play').css('display', 'inline-block');
      $('.player__pause').css('display', 'none');
