# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Favorite, 'Favoriteモデルに関するテスト', type: :model do

  describe 'アソシエーションのテスト' do
    context 'EndUserモデルとの関係' do
      it 'N:1となっているか' do
        expect(Favorite.reflect_on_association(:end_user).macro).to eq :belongs_to
      end
    end

    context 'Postモデルとの関係' do
      it 'N:1になっているか' do
        expect(Favorite.reflect_on_association(:post).macro).to eq :belongs_to
      end
    end
  end
end