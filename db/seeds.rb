# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
ActiveStorage::AnalyzeJob.queue_adapter = :inline
ActiveStorage::PurgeJob.queue_adapter = :inline

Admin.create!(
  email: 'a@gmail.com',
  password: 'aaaaaa'
)

end_users = EndUser.create!(
  [
    {email: 'nami@test.com', name: 'なみ', password: 'password'},
    {email: 'yamato@test.com', name: 'やまと', password: 'password'},
    {email: 'kuina@test.com', name: 'くいな', password: 'password'}
  ]
)

posts = Post.create!(
  [
    {title: 'ピナクルズ', body: '不思議な造形です', nation: 'オーストラリア', prefecture: 'パース', place: 'ピナクルズ砂漠', view_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg"), end_user_id: end_users[0].id },
    {title: 'カルバリ', body: '', nation: 'オーストラリア', prefecture: 'パース', place: 'カルバリ国立公園', view_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename:"sample-post2.jpg"), end_user_id: end_users[0].id },
    {title: 'アンガン山', body: '正式名称はNgungun', nation: 'オーストラリア', prefecture: 'クイーンズランド', place: 'アンガン山', view_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename:"sample-post3.jpg"), end_user_id: end_users[0].id },
    {title: '海の透き通りがすごい', body: '', nation: 'オーストラリア', prefecture: 'クイーンズランド', place: 'フレイザーアイランド', view_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post4.jpg"), filename:"sample-post4.jpg"), end_user_id: end_users[0].id },
    {title: 'しまなみ海道', body: '夕日が最高です', nation: '日本', prefecture: '愛媛', place: '来島海峡大橋', view_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post5.jpg"), filename:"sample-post5.jpg"), end_user_id: end_users[1].id },
    {title: 'ピンクレイク', body: '', nation: 'オーストラリア', prefecture: 'パース', place: 'ハットラグーンピンクレイク', view_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post6.jpg"), filename:"sample-post6.jpg"), end_user_id: end_users[1].id },
    {title: '富士山7合目', body: 'スマホでこの絶景', nation: '日本', prefecture: '静岡', place: '富士山', view_image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post7.jpg"), filename:"sample-post7.jpg"), end_user_id: end_users[2].id }
  ]
)

Tag.create!(
  [
    {name: '自然'},
    {name: '砂漠'},
    {name: 'オーストラリア'},
    {name: '渓谷'},
    {name: 'パース'},
    {name: '山'},
    {name: 'ハイキング'},
    {name: '海'},
    {name: '島'},
    {name: 'しまなみ海道'},
    {name: '今治'},
    {name: 'サイクリング'},
    {name: 'ピンクレイク'},
    {name: '湖'},
    {name: '富士山'}
  ]
)

PostTag.create! (
  [
    {post_id:1, tag_id:1},
    {post_id:1, tag_id:2},
    {post_id:1, tag_id:3},
    {post_id:2, tag_id:1},
    {post_id:2, tag_id:3},
    {post_id:2, tag_id:4},
    {post_id:2, tag_id:5},
    {post_id:3, tag_id:3},
    {post_id:3, tag_id:6},
    {post_id:3, tag_id:7},
    {post_id:4, tag_id:8},
    {post_id:4, tag_id:9},
    {post_id:5, tag_id:10},
    {post_id:5, tag_id:11},
    {post_id:5, tag_id:12},
    {post_id:6, tag_id:13},
    {post_id:6, tag_id:14},
    {post_id:7, tag_id:6},
    {post_id:7, tag_id:15}
  ]
)

PostComment.create!(
  [
    {end_user_id: end_users[0].id , post_id: posts[4].id, body: 'とっても綺麗ですね！'},
    {end_user_id: end_users[1].id , post_id: posts[1].id, body: '行ってみたいです'},
    {end_user_id: end_users[1].id , post_id: posts[2].id, body: '周りが開けていて気持ちよさそう！'},
    {end_user_id: end_users[0].id , post_id: posts[1].id, body: 'ぜひ！自然の窓も有名ですよ'},
    {end_user_id: end_users[2].id , post_id: posts[4].id, body: '私も夕日好きです！'},
    {end_user_id: end_users[2].id , post_id: posts[5].id, body: '鮮やかですね'}
  ]
)

Group.create!(
  [
    {name: '琵琶湖に行きたい', caption: '琵琶湖で絶景撮りませんか', destination: '琵琶湖', date: 'Sat, 9 Jul 2022', owner_id: end_users[0].id},
    {name: '京都　天橋立', caption: '日本三景の一つを見に行きませんか', destination: '天橋立', date: ' Sun, 14 Aug 2022', owner_id: end_users[1].id},
    {name: '河口湖で富士山見を見る', caption: '河口湖から富士山を撮りたい', destination: '河口湖', date: 'Sat, 23 Jul 2022', owner_id: end_users[0].id}
  ]
)

GroupEndUser.create!(
  [
    {end_user_id:1, group_id:1},
    {end_user_id:2, group_id:2},
    {end_user_id:1, group_id:3}
  ]
)