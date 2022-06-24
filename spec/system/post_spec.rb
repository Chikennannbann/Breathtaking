# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '投稿のテスト', type: :system do
  # let!(:post) { create(:post, title:'hoge', nation:'hoge', prefecture:'hoge', place:'hoge') }
  #画像？
  # describe '投稿前ログイン' do
  #   before do
  #     @end_user = FactoryBot.create(:end_user)
  #   end
  #   context 'ログイン処理のテスト' do
  #     before do
  #       visit new_end_user_session_path
  #     end
  #     it 'ログイン' do
  #       fill_in 'end_user[email]', with: 'test@example.com'
  #       fill_in 'end_user[password]', with: 'password'
  #       click_button 'ログイン'
  #       expect(page).to have_current_path posts_path
  #     end
  #   end
  # end
  before do
    @end_user = FactoryBot.build(:end_user)
    @new_post = FactoryBot.build(:post)
     # sign_in @end_user
    visit new_end_user_session_path
      fill_in 'end_user[email]', with: @end_user.email
      fill_in 'end_user[password]', with: @end_user.password
      click_button 'ログイン'
  end

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
        # attach_file 'post[:view_image]', with: @post.view_image
        # fill_in 'post[title]', with: @post.title
        # fill_in 'post[nation]', with: @post.nation
        # fill_in 'post[prefecture]', with: @post.prefecture
        # fill_in 'post[place]', with: @post.place
        # expect(FactoryBot.build(:post))でいける？
        #画像？
        click_button '投稿'
        expect(page).to have_current_path posts_path(Post.last)
      end
    end
  end

  describe '投稿一覧のテスト' do
    before do
      visit posts_path
    end
    context '表示の確認' do
      it '投稿されたものが表示されているか' do
        expect(page).to have_content @new_post.title
        expect(page).to have_link @new_post.view_image
      end
    end
  end

  describe '詳細画面のテスト' do
    before do
      visit post_path(post)
    end
    context '表示の確認' do
      it '削除リンクが存在しているか' do
        expect(page).to have_link '削除'
      end
      it '編集リンクが存在しているか' do
        expect(page).to have_link '編集'
      end
    end
    context 'リンクの遷移先の確認' do
      it '編集の遷移先は編集画面か' do
        edit_link = find_all('a')[3]
        edit_link.click
        expect(current_path).to eq('/posts/' + post.id.to_s + '/edit')
      end
    end
    context '投稿削除のテスト' do
      it '投稿の削除' do
        expect{ post.desctroy }.to change{ Post.count }.by(-1)
      end
    end
  end

  describe '編集画面のテスト' do
    before do
      visit edit_post_path(post)
    end
    context '表示の確認' do
      it '編集前のタイトルと本文がフォームに表示されてる' do
        expect(page).to have_field 'post[:title]', with: @post.title
        expect(page).to have_field 'post[:body]', with: @post.body
      end
      it '保存ボタンが表示されている' do
        expect(page).to have_button '保存'
      end
    end
    context '更新処理に関するテスト' do
      it '更新後のリダイレクト先は正しいか' do
        fill_in 'post[:title]', with: @post.title
        fill_in 'post[:bosy]', with: @post.body
        click_button '更新'
        expect(page).to have_current_path post_path(post)
      end
    end
  end
end