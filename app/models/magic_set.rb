class MagicSet < ApplicationRecord
  searchkick
  extend FriendlyId
  friendly_id :slug_candidates, use: :slugged

  has_many :magic_cards

  # Try building a slug based on the following fields in
  # increasing order of specificity.
  def slug_candidates
    [
      :name,
      [:name, :id]
    ]
  end

  private

  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end
end
