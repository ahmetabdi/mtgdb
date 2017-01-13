require 'net/http'
require 'zip'
require 'data_importer'

namespace :import do
  desc "Downloads and imports all sets and cards from mtgjson.com"
  task run: :environment do
    # Delete existing files before we start
    Dir.glob('public/importer/*.json').each do |fname|
      File.delete fname
    end

    Dir.glob('public/importer/*.zip').each do |fname|
      File.delete fname
    end

    # Fetch ZIP
    uri = URI("https://mtgjson.com/json/AllSets-x.json.zip")
    zipped_folder = Net::HTTP.get(uri)

    File.open("public/importer/AllSets-x.json.zip", 'wb') do |file|
      file.write(zipped_folder)
    end

    # Extra fetched ZIP to a JSON file
    zip_file = Zip::File.open("public/importer/AllSets-x.json.zip")
    zip_file.each do |file|
      file.extract("public/importer/AllSets-x.json")
    end

    # Remove UNZIPPED ZIP as it's no longer needed
    if File.exists? "public/importer/AllSets-x.json.zip"
      File.delete "public/importer/AllSets-x.json.zip"
    end

    # Parse the JSON file and start importing the data
    file = File.read("public/importer/AllSets-x.json")
    data = JSON.parse(file)

    data.each do |set_name, values|
      DataImporter.run(values)
    end

    if File.exists? "public/importer/AllSets-x.json"
      File.delete "public/importer/AllSets-x.json"
    end
  end

  desc "Downloads and imports all sets and cards from mtgjson.com for standard"
  task standard: :environment do
    # Sets to download - Currently everything in standard
    sets_to_download = ['BFZ', 'OGW', 'W16', 'SOI', 'EMN', 'KLD', 'AER']

    sets_to_download.each do |set_name|
      # Delete existing files before we start
      Dir.glob('public/importer/*.json').each do |fname|
        File.delete fname
      end

      Dir.glob('public/importer/*.zip').each do |fname|
        File.delete fname
      end

      # Fetch ZIP for the current SET to be downloaded
      uri = URI("https://mtgjson.com/json/#{set_name}-x.json.zip")
      zipped_folder = Net::HTTP.get(uri)

      File.open("public/importer/#{set_name}.zip", 'wb') do |file|
        file.write(zipped_folder)
      end

      # Extra fetched ZIP to a JSON file
      zip_file = Zip::File.open("public/importer/#{set_name}.zip")
      zip_file.each do |file|
        file.extract("public/importer/#{set_name}.json")
      end

      # Remove UNZIPPED ZIP as it's no longer needed
      if File.exists? "public/importer/#{set_name}.zip"
        File.delete "public/importer/#{set_name}.zip"
      end

      # Parse the JSON file and start importing the data
      file = File.read("public/importer/#{set_name}.json")
      data = JSON.parse(file)

      DataImporter.run(data)

      if File.exists? "public/importer/#{set_name}.json"
        File.delete "public/importer/#{set_name}.json"
      end
    end
  end
end
