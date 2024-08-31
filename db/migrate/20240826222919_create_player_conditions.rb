class CreatePlayerConditions < ActiveRecord::Migration[7.2]
  def change
    create_table :player_conditions do |t|
      t.integer :condition_length
      t.integer :condition_id
      t.integer :player_id

      t.timestamps
    end
      add_index :player_conditions, :player_id
      add_index :player_conditions, :condition_id
      add_index :player_conditions, [ :player_id, :condition_id ], unique: true
  end
end
