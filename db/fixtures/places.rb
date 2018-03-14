# frozen_string_literal: true

Place.seed(:id) do |place|
  place.id = 1
  place.name = '桜台公園'
  place.description = '横浜市青葉区にある緑に囲まれた公園'
  place.type = 'Park'
  place.address = '神奈川県横浜市青葉区桜台42'
  place.latitude = 35.55
  place.longitude = 139.52
  place.tel     = '0459712300'
  place.user_id = 1
end

Place.seed(:id) do |place|
  place.id   = 2
  place.name = 'すみよし台第四公園'
  place.description = 'ボール遊びできる広さと砂場、遊具がある公園'
  place.type = 'Park'
  place.address = '神奈川県横浜市青葉区すみよし台13−2'
  place.latitude = 35.55
  place.longitude = 139.49
  place.tel     = '0459712300'
  place.user_id = 1
end
Place.seed(:id) do |place|
  place.id   = 3
  place.name = '和食レストランとんでん長津田みなみ台店'
  place.description = '和食ファミレスのとんでん。子供が遊べるキッズスペースがあるので、小さな子供と一緒のご家族でも楽しめる。'
  place.type = 'Restaurant'
  place.address = '神奈川県横浜市緑区長津田みなみ台５丁目２４−５'
  place.latitude = 35.52
  place.longitude = 139.49
  place.tel = '0455078081'
  place.user_id = 1
end

Place.seed(:id) do |place|
  place.id = 4
  place.name = '子供の国'
  place.description = '様々な遊具や遊び場がある遊び場。夏にはプールで泳ぐこともできる'
  place.type = 'Park'
  place.address = '神奈川県横浜市青葉区奈良町700'
  place.latitude = 35.56
  place.longitude = 139.48
  place.tel = '0459612111'
  place.user_id = 1
end

Place.seed(:id) do |place|
  place.id = 5
  place.name = '玄海田公園'
  place.description = 'バーベキュー場もあり、他にもサッカー場、テニス、スケートボード場、遊具などある大きな公園。'
  place.type = 'Park'
  place.address = '神奈川県横浜市緑区長津田みなみ台3-1'
  place.latitude = 35.51
  place.longitude = 139.49
  place.tel = '0453225822'
  place.user_id = 1
end

Place.seed(:id) do |place|
  place.id = 6
  place.name = 'ボーネルンドあそびのせかい たまプラーザテラス店'
  place.description = 'たまプラーザ駅に直結した子供の遊び場が沢山あるお店。ボールの海やトランポリン、おままごとやブロック遊びなど子供が遊べる物が沢山。'
  place.type = 'Park'
  place.address = '神奈川県横浜市青葉区美しが丘1-1-2 たまプラーザテラス内1F'
  place.latitude = 35.57
  place.longitude = 139.55
  place.tel = '0454824801'
  place.user_id = 1
end

Place.seed(:id) do |place|
  place.id = 7
  place.name = 'クラブ遊キッズ ノースポートモール'
  place.description = '室内に比較的大きな施設があるkどもの遊び場。子供料金：一般60分/1,000円会員時間無制限/700円、大人料金：無料'
  place.type = 'Park'
  place.address = '神奈川県横浜市都筑区中川中央1-25'
  place.latitude = 35.55
  place.longitude = 139.57
  place.tel = '0454796133'
  place.user_id = 1
end

Place.seed(:id) do |place|
  place.id = 8
  place.name = 'ディノキッズ ららぽーと横浜店'
  place.description = 'ららぽーと横浜にある中に遊具があるレストラン。子供を遊ばせながら、ゆっくり食事ができるレストラン'
  place.type = 'Restaurant'
  place.address = '神奈川県横浜市都筑区池辺町4035-1 ららぽーと横浜 3F'
  place.latitude = 35.51
  place.longitude = 139.56
  place.tel = '0454141944'
  place.user_id = 1
end
