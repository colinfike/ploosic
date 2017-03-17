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

track = Track.create(site: soundcloud, name: "Blinded By Light", url: "https://soundcloud.com/scottishfoldlp/blinded-by-light-final-fantasy")
sample_playlist = Playlist.create(user: admin)
sample_playlist.tracks << track

track = Track.create(site: soundcloud, name: "Attack of Green Shirt Uncle", url: "https://youtu.be/44bigiDX6lI")
sample_playlist = Playlist.create(user: admin)
sample_playlist.tracks << track
