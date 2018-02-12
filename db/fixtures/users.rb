User.seed(:id) do |user|
  user.id = 1
  user.email = 'withmychild-admin@tgmail.com'
  user.decrypted_password = 'withmychild123'
  user.provider           = 'admin'
  user.nickname           = '管理者'
  user.uid                = '1231312hoge'
  user.image_url          = nil
  user.access_token       = '1231abcederu'
  user.secret_token       = '1xxxxx1'
end
