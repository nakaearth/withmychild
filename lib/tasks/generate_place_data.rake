# rubocop:disable Metrics/BlockLength  Style/NumericPredicate:
namespace :app do
  desc "generate place data. 実行方法: rake 'generate_place_data:start[name, radius, type]'"
  task :generate_place_data, %w[name radius types] => :environment do |_, args|
    client = GooglePlaces::Client.new(ENV['API_KEY'])

    radius = 100 if args.radius.blank?
    types = args.types&.include?('|') ? args.types.split('|') : ['park']

    puts 'name is required' and next if args.name.blank?

    centers = client.spots_by_query(args.name)

    puts 'invalid name' and next if centers.blank?

    center = centers.first

    place_set = []
    featured_image_set = []
    place_id = Place.all.length + 1

    types.each do |type|
      spots = client.spots(center.lat, center.lng, radius: radius, types: type, language: 'ja')
      spots.each do |spot|
        place = client.spot(spot.place_id, language: 'ja')
        data = {
          id: place_id,
          name: place.name,
          description: place.reviews[0]&.text,
          type: type.capitalize,
          address: place.formatted_address,
          latitude: place.lat,
          longitude: place.lng,
          tel: place.formatted_phone_number&.gsub!(/-/, ''),
          user_id: 1,
        }
        place_set << data

        if place.photos.length > 0
          data = {
            url: place.photos[0]&.fetch_url(800),
            place_id: place_id,
          }
          featured_image_set << data
        end

        place_id += 1
      end
    end

    SeedFu::Writer.write(Rails.root.join('db', 'fixtures', 'places.rb').to_s, class_name: 'Place') do |writer|
      writer.add(place_set)
    end

    SeedFu::Writer.write(Rails.root.join('db', 'fixtures', 'featured_images.rb').to_s, class_name: 'FeaturedImage') do |writer|
      writer.add(featured_image_set)
    end
  end
end
# rubocop:enable Metrics/BlockLength  Style/NumericPredicate:
