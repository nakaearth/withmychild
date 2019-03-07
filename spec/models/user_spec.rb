# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe '幾つかのテーブルと関連を持っている' do
    context 'have a relation to place class' do
      it { should have_many(:places) }
    end
  end

  describe '入力チェックをする' do
    context 'nameカラム' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_length_of(:name).is_at_most(60) }
    end

    context 'uidカラム' do
      it { is_expected.to validate_presence_of(:uid) }
    end

    context 'emailカラム' do
      it { is_expected.to validate_length_of(:email).is_at_most(80) }
    end

    context 'providerカラム' do
      it { is_expected.to validate_presence_of(:provider) }
      it { is_expected.to validate_length_of(:provider).is_at_most(30) }
    end
  end

  # describe '.create_account' do
  #   before do
  #     allow(Users::FacebookRegistration).to receive(:call).with(params).and_return(create(:user, :facebook))
  #     allow(Users::TwitterRegistration).to receive(:call).with(params).and_return(create(:user, :twitter))
  #
  #     @user = User.create_account(params)
  #   end
  #
  #   context 'facebookからの登録の場合' do
  #     let(:params) { { provider: 'facebook' } }
  #
  #     it { expect(@user.provider).to eq 'facebook' }
  #   end
  #
  #   context 'twiterからの登録の場合' do
  #     let(:params) { { provider: 'twitter' } }
  #
  #     it { expect(@user.provider).to eq 'twitter' }
  #   end
  # end
end
