# frozen_string_literal: true

require 'rails_helper'

describe '投稿のテスト' do
  # image_path = Rails.root.join('spec/fixtures/test.jpg')
  let!(:post) { create(:post, title:'hoge', nation:'hoge', prefecture:'hoge', place:'hoge') }
  #画像？
  describe 'トップ画面(root_path)のテスト' do
    before do
      visit root_path
    end
    context '表示の確認' do
      it 'トップ画面(root_path)に「絶景好きが集まる」が表示されているか' do
        expect(page).to have_content '絶景好きが集まる'
      end
      it 'root_pathが/であるか' do
        expect(current_path).to eq('/')
      end
    end
  end

  describe '投稿画面(new_post_path)のテスト' do
    before do
      visit new_post_path
    end
    context '表示の確認' do
      it 'new_post_pathが/posts/newであるか' do
        expect(current_path).to eq('/posts/new')
      end
      it '投稿ボタンが表示されているか' do
        expect(page).to have_button '投稿'
      end
    end
    context '投稿処理のテスト' do
      it '投稿後のリダイレクト先は正しいか' do
        attach_file('post[:view_image]', image_path, make_visible: true)
        fill_in 'post[title]', with: Faker::Lerem.character(number:10)
        fill_in 'post[nation]', with: Faker::Lerem.character(number:5)
        fill_in 'post[prefecture]', with: Faker::Lerem.character(number:5)
        fill_in 'post[place]', with: Faker::Lerem.character(number:10)
        # expect(FactoryBot.build(:post))でいける？
        #画像？
        click_button '投稿'
        expect(page).to have_current_path posts_path(Post.last)
      end
    end
  end
end