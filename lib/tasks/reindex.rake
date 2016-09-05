namespace :reindex do
  desc "Redindex all records for elasticsearch"
  task all: :environment do
  	MagicCard.reindex
  end
end
