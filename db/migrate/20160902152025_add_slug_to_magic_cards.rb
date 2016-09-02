class AddSlugToMagicCards < ActiveRecord::Migration[5.0]
  def change
    add_column :magic_cards, :slug, :string
    add_index :magic_cards, :slug, unique: true
  end
end
