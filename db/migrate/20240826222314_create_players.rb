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
      t.integer :strength
      t.integer :strength_bonus
      t.integer :strength_save
      t.integer :dexterity
      t.integer :dexterity_bonus
      t.integer :dexterity_save
      t.integer :constitution
      t.integer :constitution_bonus
      t.integer :constitution_save
      t.integer :intelligence
      t.integer :intelligence_bonus
      t.integer :intelligence_save
      t.integer :wisdom
      t.integer :wisdom_bonus
      t.integer :wisdom_save
      t.integer :charisma
      t.integer :charisma_bonus
      t.integer :charisma_save
      t.boolean :displayed
      t.references :game

      t.timestamps
    end
  end
end
