Place.seed(:id) do |place|
  place.id = 1
  place.description = 'これはテストCafeです'
  place.type = 'Cafe'
  place.address = '東京都渋谷区XXXXX'
  place.tel     = '033200222'
  place.user_id = 1
end

Place.seed(:id) do |place|
  place.id = 2
  place.description = 'これはテストParkです'
  place.type = 'Park'
  place.address = '神奈川県横浜市港北区XXXXX'
  place.tel     = '033200211'
  place.user_id = 1
end

Place.seed(:id) do |place|
  place.id = 3
  place.description = 'これはテストRestaurantです'
  place.type = 'Restaurant'
  place.address = '神奈川県横浜市緑区XXXXX'
  place.tel     = '033200444'
  place.user_id = 1
end

