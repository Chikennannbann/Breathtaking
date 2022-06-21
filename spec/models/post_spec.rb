# frozen_string_literal: true

require 'rails_helper'

describe 'Postモデルのテスト' do
  it '有効な投稿内容の場合は保存されるか' do
    post.view_image = Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/images/test.jpg')).to be_valid
    expect(FactoryBot.build(:post)).to be_valid
  end
end