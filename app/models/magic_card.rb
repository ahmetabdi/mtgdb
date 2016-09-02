class MagicCard < ApplicationRecord
	searchkick match: :word_start, searchable: [:name]
  extend FriendlyId
  friendly_id :name, use: :slugged

  private

  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end
end
