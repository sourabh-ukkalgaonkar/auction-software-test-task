FactoryBot.define do
  factory :project do
    title { Faker::Book.title }
    user { create(:user) }
    category { create(:category) }
  end
end
