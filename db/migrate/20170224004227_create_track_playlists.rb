class CreateTrackPlaylists < ActiveRecord::Migration[5.0]
  def change
    create_table :track_playlists do |t|

      t.timestamps
    end
  end
end
