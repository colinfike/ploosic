# First stab at the module pattern. Was pretty neat.
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
  ### END YOUTUBE API ###

  window.PlayerController = {}
  (->
    # Player Vars
    playlist = $('#playlist-data').data 'playlist'
    trackIndex = 0
    trackUpdated = true
    songPlaying = false
    currentPlayer = null
    shouldShuffle = false


    # Soundcloud Player
    soundcloudPlayer = (->
      soundcloudWidget = SC.Widget('soundcloud-player')

      # Handles edge cases where the player can start up after it's been paused
      soundcloudWidget.bind SC.Widget.Events.PLAY, ->
        if (playlist[trackIndex].site_id == 2) or !songPlaying
          soundcloudWidget.pause()

      # Handles going to the next song when it finishes
      soundcloudWidget.bind SC.Widget.Events.FINISH, ->
        PlayerController.mainPlayer.next()

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

      onPlayerReady = (event) ->
        console.log 'onPlayerReady'

      onPlayerStateChange = (event) ->
        console.log 'onPlayerStateChange'
        # If youtube widget changes to playling status and it's not the current
        # player then pause it. Also handles going to the next song.
        # TODO: Figure out operator binding precendence with coffeescript
        if (event.data == 1) and ((playlist[trackIndex].site_id == 1) or !songPlaying)
          youtubeWidget.pauseVideo()
        else if event.data == 0
          PlayerController.mainPlayer.next()

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

      start: ->
        youtubeWidget.loadVideoById getYoutubeId(playlist[trackIndex].url)

      resume: ->
        youtubeWidget.playVideo()

      pause: ->
        youtubeWidget.pauseVideo()
    )()

    # Main public player
    PlayerController.mainPlayer = (->

      $('.player__shuffle').click ->
        shouldShuffle = true

      # Helper functions
      updateTrackList = ->
        $('.track').removeClass('track--playing')
        $('#track-' + playlist[trackIndex].id).addClass('track--playing')

      updatePlayer = ->
        currentPlayer = if playlist[trackIndex].site_id == 1 then soundcloudPlayer else youtubePlayer

      updatePlayer()

      play: ->
        songPlaying = true
        updatePlayer()
        if trackUpdated
          updateTrackList()
          currentPlayer.start()
          trackUpdated = false
        else
          currentPlayer.resume()

      pause: ->
        songPlaying = false
        currentPlayer.pause()

      # Only shuffle when the next song plays if the shuffle button has been pressed.
      # Ignore previous for now.
      next: ->
        if shouldShuffle
          shouldShuffle = false
          shuffle(playlist)

        trackUpdated = true
        trackIndex = if trackIndex == playlist.length - 1 then 0 else trackIndex + 1
        currentPlayer.pause()
        updateTrackList()
        PlayerController.mainPlayer.play() if songPlaying

      previous: ->
        trackUpdated = true
        trackIndex = if trackIndex == 0 then playlist.length - 1 else trackIndex - 1
        currentPlayer.pause()
        updateTrackList()
        PlayerController.mainPlayer.play() if songPlaying

      # If a user wants a certain track to be played
      playTrack: (id) ->
        index = playlist.findIndex (element) ->
          return element.id == id
        index = 0 if (index < 0 || index > (playlist.length - 1))
        trackUpdated = true
        trackIndex = index
        currentPlayer.pause()
        updateTrackList()
        PlayerController.mainPlayer.play()

      initYoutube: ->
        youtubePlayer.setWidget()

    )()
  )()

  # File is getting a bit large, probably should split it up a bit
  $('.player__play').click ->
    PlayerController.mainPlayer.play()
    togglePlayButton()

  $('.player__pause').click ->
    PlayerController.mainPlayer.pause()
    togglePlayButton()

  $('.player__next').click ->
    PlayerController.mainPlayer.next()

  $('.player__previous').click ->
    PlayerController.mainPlayer.previous()


  $('.track__play').click ->
    index = $(this).parents('.track').data('index')
    $('.player__play').css('display', 'none');
    $('.player__pause').css('display', 'inline-block');
    PlayerController.mainPlayer.playTrack index

  togglePlayButton = ->
    if $('.player__play').css('display') != 'none'
      $('.player__play').css('display', 'none');
      $('.player__pause').css('display', 'inline-block');
    else
      $('.player__play').css('display', 'inline-block');
      $('.player__pause').css('display', 'none');


  # http://stackoverflow.com/questions/2450954/how-to-randomize-shuffle-a-javascript-array
  shuffle = (array) ->
    currentIndex = array.length
    temporaryValue = undefined
    randomIndex = undefined
    # While there remain elements to shuffle...
    while 0 != currentIndex
      # Pick a remaining element...
      randomIndex = Math.floor(Math.random() * currentIndex)
      currentIndex -= 1
      # And swap it with the current element.
      temporaryValue = array[currentIndex]
      array[currentIndex] = array[randomIndex]
      array[randomIndex] = temporaryValue
    array
