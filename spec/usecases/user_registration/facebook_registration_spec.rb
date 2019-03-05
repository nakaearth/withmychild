# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserRegistration::FacebookRegistration do
  describe '.call' do
    let(:params) do
      {
        provider: 'facebook',
        uid: '12345667',
        info: {
          email: 'test@gamil',
          name: 'テスト太郎',
          image: 'http://graph.facebook.com/1234567/picture?type=square'
        },
        credentials: {
          token: 'ABCDEF...', # OAuth 2.0 access_token, which you may wish to store
        },
        extra: {
          raw_info: {
            username: 'jbloggs'
          }
        }
      }
    end

    context '正常なparamsの値が渡ってきた場合' do
      before do
        @user = UserRegistration::FacebookRegistration.call(params)
      end

      it 'usersテーブルにデータを登録し、その結果を返す' do
        expect(@user.provider).to eq params[:provider]
        expect(@user.name).to eq params[:info][:name]
        expect(@user.email).to eq params[:info][:email]
        expect(@user.image_url).to eq params[:info][:image]
        expect(@user.nickname).to eq params[:extra][:raw_info][:username]
        expect(@user.access_token).to eq params[:credentials][:token]
      end
    end
  end
end
