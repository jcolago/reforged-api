class CreateGames < ActiveRecord::Migration[7.2]
  def change
    create_table :games do |t|
      t.string :name
      t.references :dm, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
