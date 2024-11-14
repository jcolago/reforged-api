class AddCharacterClassToPlayers < ActiveRecord::Migration[8.0]
  def change
    add_column :players, :character_class, :string
  end
end
