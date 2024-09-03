class CreatePlayerConditions < ActiveRecord::Migration[7.2]
  def change
    create_table :player_conditions do |t|
      t.integer :condition_length
      t.references :condition
      t.references :player

      t.timestamps
    end
  end
end
