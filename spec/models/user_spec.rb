require 'rails_helper'

RSpec.describe User, type: :model do

  # 有効なファクトリを持つこと# 名前、メール、パスワードがあれば有効な状態であること
  
  it "has a valid factory" do
    expect(FactoryBot.build(:user)).to be_valid
  end
  # 名前がなければ無効な状態であること
  
  it "is invalid without name" do
    user = FactoryBot.build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("を入力してください")
  end
  # メールアドレスがなければ無効な状態であること
  it "is invalid without an email address" do
    user= FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("を入力してください")
  end
  
  # 重複したメールアドレスなら無効な状態であること
  it "is invalid with a duplicate email address" do 
    FactoryBot.create(:user, email: "aaron@example.com")
    user = FactoryBot.build(:user, email: "aaron@example.com")
    user.valid?
    expect(user.errors[:email]).to include("はすでに存在します")
  end
  
end