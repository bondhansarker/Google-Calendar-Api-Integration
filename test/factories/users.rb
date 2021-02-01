FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "#{n}-user@gmail.com"
    end

    first_name {"Test"}
    last_name {"Account"}
    password {"123456"}
    password_confirmation {"123456"}
  end
end
