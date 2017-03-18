# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


soundcloud = Site.create(name: 'SoundCloud')
youtube = Site.create(name: 'YouTube')

admin = User.create(username: 'SuperUser')

tracks = []
sample_playlist = Playlist.create(user: admin)
tracks << Track.create(site: soundcloud, name: "Blinded By Light", url: "https://soundcloud.com/scottishfoldlp/blinded-by-light-final-fantasy")
tracks << Track.create(site: soundcloud, name: "Love Taste", url: "https://soundcloud.com/moeshop/love-taste")
tracks << Track.create(site: soundcloud, name: "Police Brutality", url: "https://soundcloud.com/badministrator/come-get-it")
tracks.each{ |track| sample_playlist.tracks << track }

tracks = []
sample_playlist = Playlist.create(user: admin)
tracks << Track.create(site: youtube, name: "Attack of Green Shirt Uncle", url: "https://youtu.be/44bigiDX6lI")
tracks << Track.create(site: youtube, name: "Passionflower", url: "https://youtu.be/nY7GnAq6Znw")
tracks << Track.create(site: youtube, name: "Catgroove", url: "https://youtu.be/twqM56f_cVo")
tracks.each{ |track| sample_playlist.tracks << track }

tracks = []
sample_playlist = Playlist.create(user: admin)
tracks << Track.create(site: soundcloud, name: "Blinded By Light", url: "https://soundcloud.com/scottishfoldlp/blinded-by-light-final-fantasy")
tracks << Track.create(site: youtube, name: "Attack of Green Shirt Uncle", url: "https://youtu.be/44bigiDX6lI")
tracks << Track.create(site: soundcloud, name: "Police Brutality", url: "https://soundcloud.com/badministrator/come-get-it")
tracks << Track.create(site: youtube, name: "Catgroove", url: "https://youtu.be/twqM56f_cVo")
tracks.each{ |track| sample_playlist.tracks << track }
