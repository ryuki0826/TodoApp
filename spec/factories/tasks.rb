FactoryBot.define do
  factory :task do
    name {'テストをかく'}
    description {'RSpec&Capybara&FactoryBotを準備'}
    user
  end
end