json.places do
  json.array!(@places.map) do |place|
    json.id place.id
    json.description place.description
    json.type place.type
    json.address place.address
  end
end
