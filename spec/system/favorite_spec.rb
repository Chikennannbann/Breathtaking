# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'いいねのテスト', type: :system do
  before do
    @end_user = FactoryBot.build(:end_user)
    @post = FactoryBot.build(:post)

    visit new_end_user_session_path
    fill_in 'end_user[email]', with: @end_user.email
    fill_in 'end_user[password]', with: @end_user.password
    click_button 'ログイン'

    visit post_path(@post)
  end

  context 'いいねの確認' do
    it 'リンクが正しいか' do
      expect(page).to have_link '', href: post_favorites_path(@post)
    end
  end

  context 'いいねをする', js: true do
    it 'いいねできる' do
      find('.fa-regular').click
      expext(page).to have_css '.fa-regular'
      expect(@post.favorites.count).to eq(1)
      # `gem 'selenium-webdriver'入れない場合は以下でできるか
      # click_button ('.fa-regular')
      # expect(page).to have_button ('.fa-solid')
    end

    it 'いいね取り消しできる' do
      find('.fa-solid').click
      expect(page).to have_css '.fa-solid'
      expect(@post.favorites.count).to eq(0)
    end
  end
end