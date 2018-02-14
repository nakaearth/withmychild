Place.seed(:id) do |place|
  place.id = 1
  place.name = '桜台公園'
  place.description = '横浜市青葉区にある緑に囲まれた公園'
  place.type = 'Park'
  place.address = '神奈川県横浜市青葉区桜台42'
  place.tel     = '0459712300'
  place.user_id = 1
end

Place.seed(:id) do |place|
  place.id   = 2
  place.name = 'すみよし台第四公園'
  place.description = 'ボール遊びできる広さと砂場、遊具がある公園'
  place.type = 'Park'
  place.address = '神奈川県横浜市青葉区すみよし台13−2'
  place.tel     = '0459712300'
  place.user_id = 1
end
Place.seed(:id) do |place|
  place.id   = 3
  place.name = '和食レストランとんでん長津田みなみ台店'
  place.description = '和食ファミレスのとんでん。子供が遊べるキッズスペースがあるので、小さな子供と一緒のご家族でも楽しめる。'
  place.type = 'Restaurant'
  place.address = '神奈川県横浜市 緑区長津田みなみ台５丁目２４−５'
  place.tel = '0455078081'
  place.user_id = 1
end

Place.seed(:id) do |place|
  place.id = 4
  place.name = '子供の国'
  place.description = '様々な遊具や遊び場がある遊び場。夏にはプールで泳ぐこともできる'
  place.type = 'Park'
  place.address = '神奈川県横浜市青葉区奈良町700'
  place.tel = '0459612111'
  place.user_id = 1
end
