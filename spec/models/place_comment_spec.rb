# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PlaceComment, type: :model do
  let!(:user) { create(:user) }
  let!(:park) { create(:place, :park, user: user) }

  describe '幾つかのテーブルと関連を持っている' do
    context 'have a relation tro user class' do
      it { expect belong_to(:user) }
      it { expect belong_to(:place) }
    end
  end

  describe '入力チェックをする' do
    it { is_expected.to validate_length_of(:body).is_at_most(1024) }
  end
end
