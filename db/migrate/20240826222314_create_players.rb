class CreatePlayers < ActiveRecord::Migration[7.2]
  def change
    create_table :players do |t|
      t.string :name
      t.string :character
      t.string :image
      t.integer :level
      t.integer :current_hp
      t.integer :total_hp
      t.integer :armor_class
      t.integer :speed
      t.integer :initiative_bonus
      t.integer :strenght
      t.integer :str_bonus
      t.integer :str_save
      t.integer :dexterity
      t.integer :dex_bonus
      t.integer :dex_save
      t.integer :constitution
      t.integer :con_bonus
      t.integer :con_save
      t.integer :intelligence
      t.integer :int_bonus
      t.integer :int_save
      t.integer :wisdom
      t.integer :wis_bonus
      t.integer :wis_save
      t.integer :charisma
      t.integer :cha_bonus
      t.integer :cha_save
      t.boolean :displayed
      t.integer :game_id

      t.timestamps
    end
  end
end
