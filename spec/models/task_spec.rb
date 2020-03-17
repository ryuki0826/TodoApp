require 'rails_helper'

RSpec.describe Task, type: :model do
  it "generates associated data from factory" do
    task = FactoryBot.create(:task)
    puts "This note's project is #{task.user.inspect}"
    expect(task.user). to be_valid
  end
  
  it "is invalid without name" do
    task= FactoryBot.build(:task, name: nil)
    task.valid?
    expect(task.errors[:name]).to include("を入力してください")
  end
  
  it "is invalid with name longer than 30" do
    task= FactoryBot.build(:task, name: "こんにちは。こんにちは。こんにちは。こんにちは。こんにちは。こんにちは。こんにちは。こんにちは。")
    task.valid?
    expect(task.errors[:name]).to include("は30文字以内で入力してください")
  end
  
  it "is invalid with name including comma" do
    task= FactoryBot.build(:task, name: "こんにちは,こんにちは。")
    task.valid?
    expect(task.errors[:name]).to include("_にカンマを含めることができません")
  end

  it "generates csv_attributes" do
      expect(Task.csv_attributes).to eq ["name", "description", "created_at", "updated_at"]
  end
end
