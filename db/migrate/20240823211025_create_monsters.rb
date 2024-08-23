class CreateMonsters < ActiveRecord::Migration[7.2]
  def change
    create_table :monsters do |t|
      t.string :name
      t.integer :size
      t.integer :alignmanet
      t.integer :armor_class
      t.integer :hit_points
      t.integer :speed
      t.string :resistances
      t.integer :p_bonus
      t.string :attacks
      t.boolean :displayed
      t.integer :game_id

      t.timestamps
    end
  end
end
