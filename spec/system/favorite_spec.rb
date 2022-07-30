# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'いいねのテスト', type: :system do
  let!(:end_user_test) { build(:end_user) }
  let!(:post_test) { create(:post, end_user: end_user_test) }
  before do
    # @end_user = FactoryBot.build(:end_user)
    # @post = FactoryBot.create(:post)

    # let!(:end_user) {FactoryBot.create(:end_user)}
    # let(:post) {FactoryBot.create(:post, end_user: end_user)}

    visit new_end_user_session_path
    fill_in 'end_user[email]', with: end_user_test.email
    fill_in 'end_user[password]', with: end_user_test.password
    click_button 'ログイン'

    visit post_path(id: post_test)
  end

  # context 'いいねの確認' do
  #   it 'リンクが正しいか' do
  #     expect(page).to　 have_link post_favorites_path(post_id: post_test)
  #   end
  # end

  context 'いいねをする', js: true do
    it 'いいねできる' do
      find('.fa-regular').click
      expext(page).to have_css '.fa-regular'
      expect(post_test.favorites.count).to eq(1)
      # `gem 'selenium-webdriver'入れない場合は以下でできるか
      # click_button ('.fa-regular')
      # expect(page).to have_button ('.fa-solid')
    end

    it 'いいね取り消しできる' do
      find('.fa-solid').click
      expect(page).to have_css '.fa-solid'
      expect(post_test.favorites.count).to eq(0)
    end
  end
end