class CreateTrackUserStats < ActiveRecord::Migration[5.0]
  def change
    create_table :track_user_stats do |t|

      t.timestamps
    end
  end
end
