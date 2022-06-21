# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, 'モデルに関するテスト', type: :model do
  describe '実際に保存してみる' do
    it '有効な投稿内容の場合は保存されるか' do
      #画像？
      # post.view_image = Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/images/test.jpg'))
      expect(FactoryBot.build(:post)).to be_valid
    end
  end
  context '空白のバリデーションチェック' do
    it 'titleが空白の倍いにバリデーションチェックされ空白のエラーメッセージが返ってきているか' do
      post = Post.new(title:'', nation:'hoge', prefecture:'hoge', place:'hoge')
      #画像？
      expect(post).to be_invalid
      expect(post.errors[:title]).to include("can't be blank")
    end
    it 'nationが空白の倍いにバリデーションチェックされ空白のエラーメッセージが返ってきているか' do
      post = Post.new(title:'hoge', nation:'', prefecture:'hoge', place:'hoge')
      #画像？
      expect(post).to be_invalid
      expect(post.errors[:nation]).to include("can't be blank")
    end
    it 'prefectureが空白の倍いにバリデーションチェックされ空白のエラーメッセージが返ってきているか' do
      post = Post.new(title:'hoge', nation:'hoge', prefecture:'', place:'hoge')
      #画像？
      expect(post).to be_invalid
      expect(post.errors[:prefecture]).to include("can't be blank")
    end
    it 'placeが空白の倍いにバリデーションチェックされ空白のエラーメッセージが返ってきているか' do
      post = Post.new(title:'hoge', nation:'hoge', prefecture:'hoge', place:'')
      #画像？
      expect(post).to be_invalid
      expect(post.errors[:place]).to include("can't be blank")
    end
  end
end