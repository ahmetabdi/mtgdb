class MagicSet < ApplicationRecord
  searchkick match: :word_start, searchable: [:name]
  extend FriendlyId
  friendly_id :name, use: :slugged

  def serialized_booster
    JSON.parse(booster)
  end

  private

  def should_generate_new_friendly_id?
    slug.blank? || name_changed?
  end
end
