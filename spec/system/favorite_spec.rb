# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'いいねのテスト', type: :system do
  # let!(:end_user_test) { build(:end_user) }
  # let!(:post_test) { create(:post, end_user: end_user_test) }
  # @end_user, @postの代わりに上記でも可能
  before do
    @end_user = FactoryBot.build(:end_user)
    @post = FactoryBot.create(:post)

    visit new_end_user_session_path
    fill_in 'end_user[email]', with: @end_user.email
    fill_in 'end_user[password]', with: @end_user.password
    click_button 'ログイン'

    visit post_path(id: @post)
  end

  context 'いいねをする', js: true do
    it 'いいねできる・取り消しできる' do
      find('.fa-regular').click
      expect(page).to have_css '.fa-solid'
      expect(@post.favorites.count).to eq(1)

      find('#delete-favorite').click
      expect(page).to have_css '.fa-regular'
      expect(@post.favorites.count).to eq(0)
    end
  end
end