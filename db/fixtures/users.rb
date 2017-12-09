User.seed(:id) do |user|
  user.id = 1
  user.email = 'hogetest@tgmail.com'
  user.decrypted_password = '1211hoge'
  user.provider           = 'development'
  user.nickname           = 'ほげの助'
  user.uid                = '1231312hoge'
  user.image_url          = 'http://test.test/test.jpg'
  user.access_token       = '1231abcederu'
  user.secret_token       = '1xxxxx1'
end
