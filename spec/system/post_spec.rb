# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '投稿のテスト', type: :system do

  before do
    @end_user = FactoryBot.build(:end_user)
    @post = FactoryBot.create(:post)
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
        image_path = Rails.root.join('spec/fixtures/test.jpg')
        attach_file('post[view_image]', image_path)
        # image_path, make_visible: true)はThe :make_visible option is not supported by the current driver - ignoringと出たので削除
        fill_in 'post[title]', with: "海"
        fill_in 'post[nation]', with: "オーストラリア"
        fill_in 'post[prefecture]', with: "クイーンズランド"
        fill_in 'post[place]', with: "フレイザーアイランド"
        click_button '投稿'
        # データがあるか確認
        posts = Post.where(title: "海", nation:"オーストラリア")
        expect(posts.count).to eq(1)
        expect(page).to have_current_path posts_path
      end
    end
  end

  describe '投稿一覧のテスト' do
    before do
      visit posts_path
    end
    context '表示の確認' do
      it '投稿されたものが表示されているか' do
        expect(page).to have_content @post.title
        # 画像が表示されているか確認
        expect(page).to have_selector("img[src$='test.jpg']")
      end
    end
  end

  describe '詳細画面のテスト' do
    before do
      visit post_path(@post)
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
        click_link '編集'
        expect(current_path).to eq('/posts/' + @post.id.to_s + '/edit')
      end
    end
    context '投稿削除のテスト' do
      it '投稿の削除' do
        expect{ @post.destroy }.to change{ Post.count }.by(-1)
      end
    end
  end

  describe '編集画面のテスト' do
    before do
      visit edit_post_path(@post)
    end
    context '表示の確認' do
      it '編集前のタイトルと本文がフォームに表示されてる' do
        expect(page).to have_field 'post[title]', with: @post.title
        expect(page).to have_field 'post[body]', with: @post.body
      end
      it '更新ボタンが表示されている' do
        expect(page).to have_button '更新'
      end
    end
    context '更新処理に関するテスト' do
      it '更新後のリダイレクト先は正しいか' do
        fill_in 'post[title]', with: @post.title
        fill_in 'post[body]', with: @post.body
        click_button '更新'
        expect(page).to have_current_path posts_path
      end
    end
  end
end