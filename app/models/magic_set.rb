class MagicSet < ApplicationRecord
  searchkick match: :word_start, searchable: [:name]

  def serialized_booster
    JSON.parse(booster)
  end
end
