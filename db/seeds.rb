# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


soundcloud = Site.create(name: 'SoundCloud')
youtube = Site.create(name: 'YouTube')

admin = User.create()
playlist = Playlist.first
tracks = []
tracks << Track.create(site: youtube, artist_name: "DisneyMusicVEVO", name: 'Beauty and the Beast (From "Beauty and the Beast"/Official Video)', url: "https://www.youtube.com/watch?v=axySrE0Kg6k")
tracks << Track.create(site: soundcloud, artist_name: "Moe Shop", name: "Love Taste (w/ Jamie Paige & Shiki)", url: "https://soundcloud.com/moeshop/love-taste")
tracks << Track.create(site: soundcloud, artist_name: "Shiki(TMNS) #TeamImouto", name: "Our World Is Worth Fighting For (Prod. meltycanon)", url: "https://soundcloud.com/thetmns/our-world-is-worth-fighting-for-prod-meltycanon")
tracks << Track.create(site: youtube, artist_name: "Greco-Roman", name: "Roosevelt - Montreal (Official Video)", url: "https://www.youtube.com/watch?v=UBS6MM05KdY")
tracks << Track.create(site: youtube, artist_name: "RecordMakers", name: "Kavinsky - Nightcall (Drive Original Movie Soundtrack)", url: "https://youtu.be/MV_3Dpw-BRY")
tracks << Track.create(site: youtube, artist_name: "Jon Gomm", name: "Jon Gomm - Passionflower", url: "https://youtu.be/nY7GnAq6Znw")
tracks << Track.create(site: soundcloud, artist_name: "@scottishfoldLP", name: "Blinded By Light / FINAL FANTASY XIII Cover", url: "https://soundcloud.com/scottishfoldlp/blinded-by-light-final-fantasy")
tracks << Track.create(site: soundcloud, artist_name: "Badministrator", name: "Police Brutality", url: "https://soundcloud.com/badministrator/come-get-it")
tracks << Track.create(site: youtube, artist_name: "LadyGagaVEVO", name: "Lady Gaga - Bad Romance", url: "https://www.youtube.com/watch?v=qrO4YZeyl0I")

tracks.each{ |track| playlist.tracks << track }

tracks = []
sample_playlist = Playlist.create(user: admin)
tracks << Track.create(site: soundcloud, artist_name: "Unknown", name: "Blinded By Light", url: "https://soundcloud.com/scottishfoldlp/blinded-by-light-final-fantasy")
tracks << Track.create(site: soundcloud, artist_name: "Unknown", name: "Love Taste", url: "https://soundcloud.com/moeshop/love-taste")
tracks << Track.create(site: soundcloud, artist_name: "Unknown", name: "Police Brutality", url: "https://soundcloud.com/badministrator/come-get-it")
tracks.each{ |track| sample_playlist.tracks << track }

tracks = []
sample_playlist = Playlist.create(user: admin)
tracks << Track.create(site: youtube, name: "Attack of Green Shirt Uncle", url: "https://youtu.be/44bigiDX6lI")
tracks << Track.create(site: youtube, name: "Passionflower", url: "https://youtu.be/nY7GnAq6Znw")
tracks << Track.create(site: youtube, name: "Catgroove", url: "https://youtu.be/twqM56f_cVo")
tracks.each{ |track| sample_playlist.tracks << track }

tracks = []
sample_playlist = Playlist.create(user: admin)
tracks << Track.create(site: soundcloud, artist_name: "Unknown", name: "Blinded By Light", url: "https://soundcloud.com/scottishfoldlp/blinded-by-light-final-fantasy")
tracks << Track.create(site: youtube, name: "Attack of Green Shirt Uncle", url: "https://youtu.be/44bigiDX6lI")
tracks << Track.create(site: soundcloud, artist_name: "Unknown", name: "Police Brutality", url: "https://soundcloud.com/badministrator/come-get-it")
tracks << Track.create(site: youtube, name: "Catgroove", url: "https://youtu.be/twqM56f_cVo")
tracks.each{ |track| sample_playlist.tracks << track }
