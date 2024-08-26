class CreatePlayerConditions < ActiveRecord::Migration[7.2]
  def change
    create_table :player_conditions do |t|
      t.integer :condition_length
      t.integer :condition_id
      t.integer :player_id

      t.timestamps
    end
  end
end
