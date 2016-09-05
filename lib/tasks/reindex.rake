namespace :reindex do
  desc "Redindex all records for elasticsearch"
  task all: :environment do
  	MagicSet.reindex
  	MagicCard.reindex
  end

end
