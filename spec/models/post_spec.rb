# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, 'モデルに関するテスト', type: :model do
  describe '実際に保存してみる' do
    it '有効な投稿内容の場合は保存されるか' do
      expect(FactoryBot.build(:post)).to be_valid
    end
  end
  context '空白のバリデーションチェック' do
    it 'titleが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか' do
      post = Post.new(title:'', nation:'hoge', prefecture:'hoge', place:'hoge')
      #view_image？
      expect(post).to be_invalid
      expect(post.errors[:title]).to include("が入力されていません。")
    end
    it 'nationが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか' do
      post = Post.new(title:'hoge', nation:'', prefecture:'hoge', place:'hoge')
      expect(post).to be_invalid
      expect(post.errors[:nation]).to include("が入力されていません。")
    end
    it 'prefectureが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか' do
      post = Post.new(title:'hoge', nation:'hoge', prefecture:'', place:'hoge')
      expect(post).to be_invalid
      expect(post.errors[:prefecture]).to include("が入力されていません。")
    end
    it 'placeが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか' do
      post = Post.new(title:'hoge', nation:'hoge', prefecture:'hoge', place:'')
      expect(post).to be_invalid
      expect(post.errors[:place]).to include("が入力されていません。")
    end
  end
end