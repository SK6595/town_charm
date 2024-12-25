require 'rails_helper'

RSpec.describe User, type: :model do
  it ":name, :email, :password があれば有効であること" do
    user = User.new
    user.name = "taro"
    user.email = "taro@test.com"
    user.password = "password"
    expect(user).to be_valid
  end
  
  it ":password は6文字未満だと無効であること" do
    user = User.new
    user.password = "pass"
    user.valid?
    expect(user.errors[:password]).to include("は6文字以上で入力してください")
  end
  
  it ":password は6文字以上だと有効であること" do
    user = User.new
    user.password = "password"
    user.valid?
    expect(user.errors[:password]).to_not include("は6文字以上で入力してください")
  end
  
  it "重複した:email は無効であること"
end