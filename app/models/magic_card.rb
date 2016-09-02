class MagicCard < ApplicationRecord
	searchkick match: :word_start, searchable: [:name]
end
