FactoryBot.define do
  factory(:user) do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end

  factory(:project) do
    name { Faker::App.name }
    association :creator, factory: :user
  end

  factory(:issue) do
    title { Faker::Lorem.sentence(word_count: 3) }
    description { Faker::Lorem.paragraph }
    status { "active" }
    assignee_name { Faker::Name.name }
    association :project
  end

  factory(:comment) do
    content { Faker::Lorem.sentence }
    association :issue
    association :creator, factory: :user
  end
end