require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    driven_by(:rack_test)
  end
  
  describe "新規登録" do
    let(:user) { FactoryBot.build(:user) }
    
    scenario "新規登録に成功する" do
      #下記コードは上のletで代用可、推奨はlet
      #user = FactoryBot.build(:blank_user)
      expect {
        visit root_path
        find('.sign_up').click
        expect(page).to have_content "新規登録"
        fill_in "氏名", with: user.name
        fill_in "Eメール", with: user.email
        fill_in "パスワード", with: user.password
        fill_in "パスワード（確認用）", with: user.password
        click_button "新規登録"
        expect(page).to have_content "アカウント登録が完了しました"
      }.to change(User, :count).by(1)
    end
    
    scenario "新規登録に失敗する" do
      #同じ変数名を使うとletを置き換えることができる
      user = FactoryBot.build(:blank_user)
      expect {
        visit root_path
        find('.sign_up').click
        expect(page).to have_content "新規登録"
        fill_in "氏名", with: user.name
        fill_in "Eメール", with: user.email
        fill_in "パスワード", with: user.password
        fill_in "パスワード（確認用）", with: user.password
        click_button "新規登録"
        expect(page).to have_content "新規登録に失敗しました"
      }.to_not change(User, :count)
    end
  end

  scenario "ゲストログイン" do
    #トップぺ-ジにアクセス
    visit root_path
    #画面真ん中のログインボタンをクリック
    find('.sign_in').click
    #ログインぺ-ジに遷移
    expect(page).to have_content "ゲストログインはこちらから"
    #ゲストログインボタンをクリック
    click_link "ゲストログイン（閲覧用）"
    #ゲストログインが成功
    expect(page).to have_content "ゲストユーザーとしてログインしました"
  end
end