# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::FacebookRegistration do
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
    describe 'paramsの値をusersテーブルに登録する' do
      before do
        @user = Users::FacebookRegistration.call(params)
      end

      it { expect(@user.provider).to eq params[:provider] }
      it { expect(@user.name).to eq params[:info][:name] }
      it { expect(@user.email).to eq params[:info][:email] }
      it { expect(@user.image_url).to eq params[:info][:image] }
      it { expect(@user.nickname).to eq params[:extra][:raw_info][:username] }
      it { expect(@user.access_token).to eq params[:credentials][:token] }
    end
  end
end
