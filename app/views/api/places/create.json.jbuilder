# frozen_string_literal: true

json.places do
  json.array!(@places.map) do |place|
    json.id place.id
    json.encrypted_id place.encrypted_id
    json.description place.description
    json.type place.type
    json.address place.address
    json.thumb_url place.first_image_url(:thumb)
    json.created_at place.created_at
  end
end
