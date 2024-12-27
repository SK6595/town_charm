FactoryBot.define do
  #通常の書き方だと1つしか作れないので、複数作る場合は名前を変えてclassを指定する
  factory :blank_user, class: User do
    name { "" }
    email { "" }
    password { "" }
  end
  
  #通常の書き方
  factory :user do
    name { "test" }
    email { "test@test.com" }
    password { "password" }
  end
end
