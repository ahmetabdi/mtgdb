class AddSlugToMagicSets < ActiveRecord::Migration[5.0]
  def change
    add_column :magic_sets, :slug, :string
    add_index :magic_sets, :slug, unique: true
  end
end
