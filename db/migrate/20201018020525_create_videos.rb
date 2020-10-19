class CreateVideos < ActiveRecord::Migration[6.0]
  def change
    create_table :videos do |t|
      t.string :external_reference
      t.string :title
      t.boolean :subscription
      t.string :image
      t.string :embed_player

      t.timestamps
    end
  end
end
