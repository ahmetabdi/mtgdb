class MagicCard < ApplicationRecord
  searchkick match: :word_start, searchable: [:name, :text]
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  belongs_to :magic_set

  def slug_candidates
    [
      :name,
      [:name, magic_set.name],
      [:name, :id]
    ]
  end

  def search_data
    {
      name: name,
      mana_cost: mana_cost,
      type_of_card: type_of_card,
      text: text,
      set_code: magic_set.code.downcase,
      rarity: rarity.downcase,
      multiverse_id: multiverse_id,
      slug: slug
    }
  end

  private

  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end
end
