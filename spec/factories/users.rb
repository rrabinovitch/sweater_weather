FactoryBot.define do
  factory :user do
    email { "whatever@example.com" }
    password { "password" }
    api_key { SecureRandom.uuid }
  end
end
