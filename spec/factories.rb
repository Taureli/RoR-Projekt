FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Jarek #{n}" }
    sequence(:email) { |n| "jarek_#{n}@bdimension.com"}
    password "koniowo"
    password_confirmation "koniowo"
    factory :admin do
      admin true
    end
  end

  factory :gist do
    snippet "<h1> ZXXZXZZX </h1>"
    description "This is html"
    lang "html"
    user
  end
end
