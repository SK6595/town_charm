# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(email: "admin@test.com", password: "321654")

user_attributes = [
  { name: "中川", email: "nakagawa@test.com" },
  { name: "北川", email: "kitagawa@test.com" },
  { name: "植野", email: "ueno@test.com" },
  { name: "芳賀", email: "haga@test.com" },
  { name: "高橋", email: "takahashi@test.com" }
]

user_attributes.each do |attributes|
  User.create!(attributes.merge({ password: "123456" }))
end

(1..5).each do |n|
#[1, 2, 3, 4, 5].each do |n|
  user = User.find(n)
  user.profile_image.attach(io: File.open(Rails.root.join("db/fixtures/images/user_#{n}.jpg")), filename: "user_#{n}.jpg")
end

#GuestUser
User.create!(
  :name=>"ゲストユーザー",
  :is_active=>true,
  :email=>"guest@test.com",
  :password=>"password",
)

#DeleteUser
User.create!(
  :name=>"imo1@imo.com",
  :is_active=>false,
  :email=>"imo1@imo.com",
 :password=>"password"
)

post_attributes = [
  {:user_id=>7, :title=>"テスト", :body=>"test", :address=>"東京都世田谷区", :latitude=>35.6465615, :longitude=>139.6532924},
  {:user_id=>6, :title=>"ゲスト投稿", :body=>"ゲスト投稿", :address=>"東京都渋谷区", :latitude=>35.6619707, :longitude=>139.703795},
  {:user_id=>1, :title=>"⚪⚪商店街の活性化について", :body=>"⚪⚪商店街の活性化について", :address=>"愛知県春日井市八光町", :latitude=>35.2387391, :longitude=>136.9553143},
  {:user_id=>2, :title=>"⚪⚪市のイベントについて", :body=>"⚪⚪市のイベントについて", :address=>"愛知県春日井市八光町", :latitude=>35.2387391, :longitude=>136.9553143},
  {:user_id=>4, :title=>"⚪⚪市の治安について", :body=>"⚪⚪市の治安について", :address=>"愛知県春日井市八光町", :latitude=>35.2387391, :longitude=>136.9553143},
  {:user_id=>3, :title=>"⚪⚪商店街空き店舗の事業承継について", :body=>"⚪⚪商店街空き店舗の事業承継について", :address=>"愛知県春日井市八光町", :latitude=>35.2387391, :longitude=>136.9553143},
  {:user_id=>5, :title=>"⚪⚪市⚪⚪町の地域活性化のアイデアについて", :body=>"⚪⚪市⚪⚪町の地域活性化のアイデアについて", :address=>"愛知県 春日井市八光町", :latitude=>35.2387391, :longitude=>136.9553143}
]

post_attributes.each { |post_attribute| Post.create!(post_attribute) }

group_attributes = [
  {:name=>"⚪⚪市の活性化", :introduction=>"⚪⚪市の活性化を目的に作成されたグループです。", :owner_id=>1},
  {:name=>"⚪⚪町の住民", :introduction=>"⚪⚪町の住民同士で意見を出し合うことを目的に作成された\r\nグループです。", :owner_id=>1},
  {:name=>"⚪⚪市のイベント", :introduction=>"⚪⚪市のイベントの企画を行うために作成されたグループです。", :owner_id=>1}
]

group_attributes.each { |group_attribute| Group.create!(group_attribute) }

group_user_attributes = [
  {:user_id=>4, :group_id=>1, :status=>"rejected"},
  {:user_id=>4, :group_id=>2, :status=>"applying"},
  {:user_id=>4, :group_id=>3, :status=>"applobed"},
  {:user_id=>2, :group_id=>2, :status=>"applobed"},
  {:user_id=>2, :group_id=>3, :status=>"applobed"},
  {:user_id=>2, :group_id=>1, :status=>"rejected"},
  {:user_id=>3, :group_id=>1, :status=>"rejected"},
  {:user_id=>3, :group_id=>2, :status=>"applobed"},
  {:user_id=>3, :group_id=>3, :status=>"applobed"},
  {:user_id=>5, :group_id=>1, :status=>"applobed"},
  {:user_id=>5, :group_id=>2, :status=>"rejected"},
  {:user_id=>5, :group_id=>3, :status=>"applobed"},
  {:user_id=>6, :group_id=>1, :status=>"applying"}
]

group_user_attributes.each { |group_user_attribute| GroupUser.create!(group_user_attribute) }