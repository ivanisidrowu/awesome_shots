namespace :import do
  task :photos => :environment do
    Dir['./datastore/albumelement-convert-json/**/*json'].each do |json_file|
      ap(json_file)
      ap(Time.now)
      records = []
      JSON.load(open(json_file)).each do |record|
        records << {
          url: record['url'],
          link: record['link'],
          thumb: record['thumb'],
          hits: record['hits']['total'],
          uploaded_at: Time.at(record['uploaded_at'].to_i),
          location: record['location']['geojson']['coordinates'],
        }
      end
      Photo.collection.insert(records)
      ap(Time.now)
    end
  end
end