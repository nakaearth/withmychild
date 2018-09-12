# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentRegist do
  describe '.call' do
    let(:params) do
      {
        user_id: 1,
        place_id: 1,
        comment: 'これはコメント'
      }
    end

    describe 'paramsの値をcommentsテーブルに登録する' do
      before do
        CommentRegist.call(params)
      end

      # it { expect(@user.provider).to eq params[:provider] }
      # it { expect(@user.name).to eq params[:info][:name] }
      # it { expect(@user.email).to eq params[:info][:email] }
      # it { expect(@user.image_url).to eq params[:info][:image] }
      # it { expect(@user.nickname).to eq params[:info][:nickname] }
      # it { expect(@user.access_token).to eq params[:credentials][:token] }
      # it { expect(@user.secret_token).to eq params[:credentials][:secret] }
    end
  end
end
