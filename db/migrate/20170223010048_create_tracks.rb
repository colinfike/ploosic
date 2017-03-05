class CreateTracks < ActiveRecord::Migration[5.0]
  def change
    create_table :tracks do |t|
      t.string :name
      t.integer :site_id
      t.integer :user_id
      t.string :url

      t.timestamps
    end
  end
end
